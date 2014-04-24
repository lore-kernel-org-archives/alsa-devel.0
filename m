From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: On non-rewindability of resamplers (was: Testing
 rewindability of a pcm)
Date: Fri, 25 Apr 2014 03:01:22 +0600
Message-ID: <53597BA2.8080201@gmail.com>
References: <5356A9B6.9060405@gmail.com> <5358FCF0.2040701@ladisch.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030707040601000303060301"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f54.google.com (mail-la0-f54.google.com
 [209.85.215.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CBAA26530A
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 23:04:24 +0200 (CEST)
Received: by mail-la0-f54.google.com with SMTP id e16so2129138lan.41
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 14:04:23 -0700 (PDT)
In-Reply-To: <5358FCF0.2040701@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
Cc: david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030707040601000303060301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

24.04.2014 18:00, Clemens Ladisch wrote:
> Alexander E. Patrakov wrote:
>> And we don't even have a rewindable resampler implementation!
>
> The rate plugin implements rewinding.  (I haven't tested if this
> implementation is correct.  What is the problem?)

I was going to demonstrate a program that produces incorrect output, but 
instead got a program that crashes. Still, on extplug with upmix, it 
does demonstrate essentially the same issue with internal state nicely, 
search for "=====" below. And the speculation text below is the one 
about incorrect output that I wrote after looking at the pcm_rate.c code 
but which is not testable right now. So much for the failed trolling 
attempt :(

<speculation>
The implementation of rewinds in the rate plugin is indeed incorrect. I 
will explain this now and show the bigger problem then (after a "+++++").

When resampling, each of the input samples affects more that one output 
sample, and each output sample is affected by more than one input 
sample. In the windowed-sinc approach to resampling (which is 
implemented by speex, libsamplerate and ffmpeg), this is determined by 
the width of the window, which is typically several (8..100) samples and 
depends on the rate ratio and resampler quality setting.

As a consequence, each output fragment (received from 
rate->ops.convert_s16 or from rate->ops.convert in do_convert() into 
dst_areas) is affected not only by the samples in the input fragment 
(src_areas), but also by the samples in the previous input fragment. 
I.e. by a few samples that are logically just before src_offset. Each 
sample rate converter, however, keeps a copy of them in its own history 
buffer (which is called "magic_samples" in speex), instead of looking 
before src_offset.

The important part of the above is that a sample rate converter is not 
stateless, and that this state left over from the previous input can 
yield non-silent output fragment as a result of conversion of a fragment 
of silence.

Let's also note an implicit precondition that do_convert is based on. 
The precondition is that the internal state of the resampler (i.e 
rate->obj) should match what was there after converting the previous 
samples (i.e. those that are just before src_offset now). Without 
rewinds, this precondition is trivially satisfied, as nobody touches 
rate->obj between converting the previous fragment and this fragment.

With rewinds, this precondition is violated: consider a program that 
uses 4 periods, prefills them with silence, and then, in a loop, rewinds 
a period, writes a period of silence, and writes a period of square 
waves. For your convenience, this program is attached. To test the rate 
plugin, edit it in order to use the correct device (such as plughw:2) 
and a rate (such as 32000 Hz) that the card doesn't support. As it 
always overwrites square waves with silence before the hardware pointer 
goes over them, the only correct output from this program on any device 
that properly supports rewinds is pure silence (unless the program 
complains about anything).

If I understand the code correctly (which, given the crash, is false), 
the rate plugin sometimes would give the square wave to the resampler as 
an input. And it never tells the resampler to forget that - there is no 
such op in snd_pcm_rate_ops_t! In fact, the rewind path 
(snd_pcm_rate_rewind, snd_pcm_rate_move_applptr) calls only read-only 
functions on obj, which is what I object to. However, see below why my 
requirements (which are indeed valid requirements if the rate plugin 
must implement rewinds correctly) are actually unreasonable.
</speculation>

Now to the crash that was totally unexpected. The problem is that, in 
snd_pcm_rate_fast_ops, the .rewindable callback gets defaulted to NULL 
and that got dereferenced through the snd_pcm_rewindable() call in my 
test program. OK, we can comment out the call to snd_pcm_rewindable() 
and the check. But then, with alsa-lib 1.0.27.2, snd_pcm_rewind() would 
return negative numbers close to minus buffer size! I do see a commit by 
Andrew Eikum in the recent git history, but that only papers over the 
problem, as it was never explained where these negative numbers came from.

Installation of alsa-lib from git yields snd_pcm_rewind() that forgets 
~4090 samples out of 1024 requested. Also not usable. And worse, the 
program produces a lot of steady sound - so here is obviously a bug with 
accounting in addition to the fundamental problem with state that I 
speculated about above.

So please understand my position: rewinding in the rate plugin never 
worked, so it cannot have any users that won't also be satisfied by 
being told that it should not work, always returning 0 and ignoring the 
rewind. Especially since the fundamental problem with state actually 
requires writing a new resampler implementation from scratch (see 
below), and since there are other plugins (such as AC3 encoder) where 
implementing proper rewinds is impossible without even larger efforts, 
so a program must be prepared to deal with this situation anyway. Of 
course, this is only my position, you are free to ignore it.

+++++

And now let's return to that fundamental problem with state. Inside the 
speculation block, I have suggested that the problem is that we don't 
have ops in snd_pcm_rate_ops_t that forward rewinds to the resampler 
implementation, so that it can restore its state to the one 
corresponding to an earlier moment in time. The real big problem (and 
the one I really meant in the original trolling attempt) is that even if 
you define new ops in snd_pcm_rate_ops_t, one can't implement them using 
existing open-source resamplers. Their APIs just don't have a function 
to rewind and to restore the prior magic samples.

=====

Now to the upmix plugin which does demonstrate a similar bug successfully.

With the following .asoundrc, the test program, when modified to run on 
the "upmix" pcm, produces silence in front channels and non-silence in 
back channels, indicating a bug in upmix.

pcm.!upmix {
     type upmix
     channels 6
     slave.pcm "hw:2"
}

The bug is now that the snd_pcm_extplug_callback structure does not have 
a callback that would notify the implementation about the rewind, so 
that the implementation restores its internal state (for upmix - a delay 
buffer) to a prior moment of time. Of course, implementability of this 
callback is again a valid question.


>
>> Should PulseAudio indeed use a complex dance with snd_pcm_rewindable()
>> to get the essentially-static bit of information whether a given PCM
>> supports full rewinds?
>
> As far as I can tell, ALSA assumes that _every_ device allows random
> access to its ring buffer.
>
> In particular, both alsa-lib's internal API and the explug/ioplug APIs,
> when writing samples, have no concept of "current position" and write to
> an explicitly specified position in the buffer.  The implementation
> if snd_pcm_rewindable() assumes that the entire buffer is accessible
> (the only plugin to change this is the file plugin).
>
> snd_pcm_rewindable/forwardable() are just for determining the possible
> amount of movement, not whether it's possible at all.

Understood.

> In other words: any plugin that does not allow random access is, as far
> as the ALSA API is concerned, buggy.

See (3).

>> 2) Use snd_pcm_forwardable() with an empty buffer just after setting
>>     hw_params: works (once the implementation in ioplug/extplug is
>>     fixed to return 0), doesn't require API additions,
>
> If ALSA is changed to track the information whether a device allows
> random access or not, this would be the correct way.

OK, I am willing to do this change, but I am a bit confused. Is the 
suggeestion to do (3), and, in addition, to add restrictions to 
snd_pcm_forwardable() that use the same underlying information?

>>     but David doesn't like it. He thinks that the sets of PCMs that
>>     support forwarding and rewinding may be different (here I disagree,
>>     but can't provide arguments).
>
> It's possible to imagine devices that implement forwarding by just
> inserting zero samples, but cannot go back in time.  (I'm not sure if
> implemting that would make any sense.)

No comments here.

>> 3) Add a new function to ALSA that gets this bit of static information
>>     for a given pcm handle, use it.
>
> I guess this will happen.

Do you agree with this prototype, and the fact that the function should 
be exportable?

int snd_pcm_hw_params_is_seekable(const snd_pcm_hw_params_t *params);

Check if the device fully supports rewinds and forwards.

Parameters:
     params	Configuration space

Return values:
     0	The whole plugin chain is not guaranteed to support arbitrary 
rewinds and forwards.
     1	The whole plugin chain is guaranteed, under all remaining 
configurations in the configuration space, to support any rewinds and 
forwards that don't move the application pointer through the hardware 
pointer.

If this function is called when there is more than one configuration 
exists in the configuration set (e.g. when the rate is not fixed), it 
may return pessimistic results.

-- 
Alexander E. Patrakov

--------------030707040601000303060301
Content-Type: text/x-csrc;
 name="pcm_rewind2.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pcm_rewind2.c"

/*
 *  This extra small demo sends silence to your speakers if all your ALSA plugins support rewinds properly.
 */

#include <asoundlib.h>

#include <stdio.h>
#include <stdlib.h>

const char* device = "hw:2";
const int channels = 2;
const snd_pcm_sframes_t period_size = 1024;
const int periods = 4;
const int rate = 48000;
const int freq = 440;


int main(int argc, char* argv[])
{
        int err;
        unsigned int c, i, s, t;
	short *wave;
	short *silence;
	unsigned int half_period = rate / 2 / freq;

        snd_pcm_t *handle;
	snd_output_t *out = NULL;

	snd_pcm_hw_params_t *params;
	snd_pcm_sw_params_t *swparams;

	snd_pcm_hw_params_alloca(&params);
	snd_pcm_sw_params_alloca(&swparams);

	t = 0;

	snd_output_stdio_attach(&out, stderr, 0);
	wave = calloc(period_size, sizeof(short) * channels);
	silence = calloc(period_size * periods, sizeof(short) * channels);

	if ((err = snd_pcm_open(&handle, device, SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
		fprintf(stderr, "Playback open error: %s\n", snd_strerror(err));
		exit(EXIT_FAILURE);
	}

	err =   snd_pcm_hw_params_any(handle, params) < 0 ||
		snd_pcm_hw_params_set_rate_resample(handle, params, 1) < 0 ||
		snd_pcm_hw_params_set_access(handle, params, SND_PCM_ACCESS_RW_INTERLEAVED) < 0 ||
		snd_pcm_hw_params_set_format(handle, params, SND_PCM_FORMAT_S16) < 0 ||
		snd_pcm_hw_params_set_channels(handle, params, channels) < 0 ||
		snd_pcm_hw_params_set_rate(handle, params, rate, 0) < 0 ||
		snd_pcm_hw_params_set_period_size(handle, params, period_size, 0) < 0 ||
		snd_pcm_hw_params_set_periods(handle, params, periods, 0) < 0 ||
		snd_pcm_hw_params(handle, params) < 0;
	if (err) {
		fprintf(stderr, "Playback hwparams error: %s\n", snd_strerror(err));
		exit(EXIT_FAILURE);
	}

	err =   snd_pcm_sw_params_current(handle, swparams) < 0 ||
		snd_pcm_sw_params_set_start_threshold(handle, swparams, period_size) < 0 ||
		snd_pcm_sw_params_set_avail_min(handle, swparams, period_size) < 0 ||
		snd_pcm_sw_params(handle, swparams) < 0;
	if (err) {
		fprintf(stderr, "Playback swparams error: %s\n", snd_strerror(err));
		exit(EXIT_FAILURE);
	}

	snd_pcm_dump(handle, out);
	fprintf(stderr, "Playing silence\n");
	fflush(stderr);
	memset(silence, 0, period_size * sizeof(short) * channels);
	for (i = 0; i < periods; i++) {
		err = snd_pcm_writei(handle, silence, period_size);
		if (err != period_size) {
			fprintf(stderr, "Playback incomplete write or error: %d\n", err);
			exit(EXIT_FAILURE);
		}
	}
	fprintf(stderr, "Playing tricks\n");
	for (i = 0; i < 100; i++) {
		snd_pcm_sframes_t towrite;
		err = snd_pcm_rewindable(handle);
		if (err < period_size) {
			fprintf(stderr, "Cannot rewind, got %d\n", err);
			exit(EXIT_FAILURE);
		}
		towrite = snd_pcm_rewind(handle, period_size);
		if (towrite < period_size) {
			fprintf(stderr, "Rewind attempt failed or didn't yield as much as we want, got %d\n", err);
			exit(EXIT_FAILURE);
		}
		fprintf(stderr, "Rewind attempt forgot %d samples out of %d requested\n", (int)towrite, (int)period_size);
		err = snd_pcm_writei(handle, silence, towrite);
		if (err != towrite) {
			fprintf(stderr, "Writing silence: incomplete write or error: %d\n", err);
			exit(EXIT_FAILURE);
		}

		for (s = 0; s < period_size; s++) {
			short val = (t % (2 * half_period) >= half_period) ? 30000 : -30000;
			for (c = 0; c < channels; c++)
				wave[c + s * channels] = val;
			t++;
		}

		err = snd_pcm_writei(handle, wave, period_size);
		if (err != period_size) {
			fprintf(stderr, "Writing wave: incomplete write or error: %d\n", err);
			exit(EXIT_FAILURE);
		}
	}
	snd_pcm_drop(handle);
	snd_pcm_close(handle);

	free(wave);
	free(silence);


	return 0;
}

--------------030707040601000303060301
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030707040601000303060301--
