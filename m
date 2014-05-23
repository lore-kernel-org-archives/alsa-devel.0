From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: On non-rewindability of resamplers
Date: Sat, 24 May 2014 00:59:56 +0600
Message-ID: <537F9AAC.2030204@gmail.com>
References: <5356A9B6.9060405@gmail.com>	<5358FCF0.2040701@ladisch.de>	<53597BA2.8080201@gmail.com>	<5359FE72.8050605@canonical.com>	<535A6C96.7040109@gmail.com>	<CAN8ccibLsqb6oxai=+XOAhZ1dPwZmVVD2r3teDsz2a2_CthoOA@mail.gmail.com>	<535B83E4.5050303@gmail.com>	<CAN8ccibXtR=jc3NJjFMn88stytAhSxjNqbD5QsREDppbKDNg9Q@mail.gmail.com>	<535E908C.4030509@gmail.com>	<CAN8ccib7E7SQFo=Ro5Hksaj74Nn9NtHA1VSQpKX3ARHQDE_QHQ@mail.gmail.com>	<535FDEA8.7010206@gmail.com>	<CAN8cciYoR25LDZnr6R9Bn_ek4rX1q8XoRPT+H4Mpp3ecZJF85w@mail.gmail.com>	<5364CE4D.7040506@gmail.com>	<CAN8cciYB-vD0Oeigv=rGt1XDSZvqGm_KpyV_HwARCg8LLFEQjg@mail.gmail.com>	<536E26A4.1060002@gmail.com>	<CAN8ccibugnc_8FEf_184PTWGBHdt4Wa0Af=A8AwT1_uFSJZX_g@mail.gmail.com>	<53705396.3070406@gmail.com>
 <CAN8cciZGaFs2dPq0FJzhqyrtn9-irGBv6wmTjG1aRcJcCviuHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010201020409080902030703"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com
 [209.85.215.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 34552265218
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 21:00:00 +0200 (CEST)
Received: by mail-la0-f41.google.com with SMTP id e16so4514512lan.14
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 11:59:59 -0700 (PDT)
In-Reply-To: <CAN8cciZGaFs2dPq0FJzhqyrtn9-irGBv6wmTjG1aRcJcCviuHg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: sergemp@mail.ru, artur.stat@gmail.com, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010201020409080902030703
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

23.05.2014 08:03, Raymond Yau wrote:
>
>  >No need to do this. I have already made enough conclusions.
>
>  > Unfortunately, I forgot to attach the new test program (intentionally
>
>  > modified to produce an underrun), doing it now.
>  >
>  > The output here is:
>
>  > Hardware PCM card 2 'HDA Intel PCH' device 0 subdevice 0
>  > Its setup is:
>  >   stream       : PLAYBACK
>  >   access       : RW_INTERLEAVED
>  >   format       : S16_LE
>  >   subformat    : STD
>  >   channels     : 4
>  >   rate         : 48000
>  >   exact rate   : 48000 (48000/1)
>  >   msbits       : 16
>  >   buffer_size  : 4096
>  >   period_size  : 1024
>  >   period_time  : 21333
>  >   tstamp_mode  : NONE
>  >   period_step  : 1
>  >   avail_min    : 1024
>  >   period_event : 0
>  >   start_threshold  : 1024
>  >   stop_threshold   : 4096
>  >   silence_threshold: 0
>  >   silence_size : 0
>  >   boundary     : 4611686018427387904
>  >   appl_ptr     : 4096
>  >   hw_ptr       : 4136
>  > Rewindable: -40, loop iteration: 7807909
>  > This means Too many levels of symbolic links
>  >
>
> appl_ptr is 40 samples behind hw_ptr since your program stop writing
> data to the sound card and perform rewind , snd_pcm_state was change
> from runnning (3) to xrun (4)

Yes.

>
> The appl_ptr  can be placed in any position in the ring buffer for the
> application to write data but the sound card fetch data from this ring
> buffer sequentially, however snd_pcm_write() assume the maximum distance
> between appl_ptr and hwptr is only one buffer
>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/hda_intel.c?id=2ae66c26550cd94b0e2606a9275eb0ab7070ad0e
>
> Do you mean hwptr does not decrease by one period when you use arbitrary
> period sizes for hda-Intel  ?

I cannot comment on this commit. But "snd_hda_intel.align_buffer_size=1" 
indeed existed on my kernel command line (for no good reason now - so 
removed), and I don't use a strange period size.

Still, the bug (negative reported rewindable amount) also exists without 
align_buffer_size=1.

>
> e.g.  48 samples (192 bytes) when using 1ms period time and  stereo
> instead of 4 channels

Not tested.

>
> you program seen hang when using pulse plugin

I am not interested in any more rewind-related bug reports for the pulse 
plugin. This particular bug will be fixed, together with many others, by 
always returning 0 from the .rewindable callback for ioplug if mmap_rw 
is false.

>  > Sorry, there is no userspace API for that. The only way to get the
> minimum period size is via snd_pcm_hw_params_get_period_size_min, which
> obtains the result in terms of frames.
>
>
> Have you set channels, rate and format first and you have to call
> snd_pcm_hw_params_get_period_size_min before you set the period size   ?

Yes. The test program is attached. For stereo S16_LE output, it reports 
32 samples (i.e. 128 bytes) as the minimum period size. Still, hw_ptr 
assumes odd values during the test runs. Maybe due to bdl_pos_adj, which 
is 1 for my analog card. OTOH, with snd_pcm_avail inserted, it assumes 
even values with a step of 8.

>
> http://git.qemu.org/?p=qemu.git;a=blob;f=hw/audio/ac97.c;hb=HEAD
>
> http://git.qemu.org/?p=qemu.git;a=blob;f=hw/audio/hda-codec.c;hb=HEAD
>
> However those emulated AC97 and HDA sound card inside virtual machine
> won't transfer audio like the real sound card, it mainly depend on the
> backend audio driver of the host
>
> http://git.qemu.org/?p=qemu.git;a=tree;f=audio;hb=HEAD

These source files are large. What should I look for?

> Can your program use period size but pulseaudio server user period time,
> all rates supported by the sink (at least  default rate and alternate
> rate used by pulseaudio) ?
>
> the supported channels ( at least 2 and 6 which is commonly used)

Sorry, I don't understand. Besides, the program is only intended to 
demonstrate a bug in snd_pcm_rewindable when applied to the hw plugin, 
and, before fixing hw, I am not ready to discuss any other bugs that it 
may find in any other plugin.

>
>  >
>  >
>  > How do I test this? Could you please post some userspace test code or
> a kernel patch, together with the instructions?
>  >
>
> Attach the patch to dump the values of the audio function group capability

There was no attachment.

> There are three cases
>
> 1) delay in analog output > delay in digital output  e.g, idt codecs
> 2) delay in analog output < delay in digital output e.g. adi codecs
> 3) no delay in audio widgets ,  digital output and analog output have no
> delay difference when output delay in audio  function group is non zero ?

Yes, that's logical.

>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=9a08160bdbe3148a405f72798f76e2a5d30bd243
>
> Audio send to both Analog and digital  output at the same time when
> iec958 default pcm switch is on

This only affects connections inside the sound card. The same samples 
will be sent to both outputs (i.e. there will be one stream), thus, any 
difference in delays will manifest itself.

>
> It is unlikely for ordinary user to measure the delay without using
> oscilloscope since the Analog speaker and digital receiver also have delay

Correct. Also, while delay in analog speakers can be often rightfully 
assumed to be 0 samples, this is not the case for digital receivers. In 
other words, the delay on the digital path is in fact unknown.

However, your considerations above are limited to timing differences 
between several outputs of the same card. The original use case for 
module_combine_sink was to combine several analog cards into one, even 
though they have independent clocks and slightly different (and even 
changing with temperature) ideas about the meaning of "44100 Hz".

>
>
>  >>  > The whole construction should support rewinds, with the
>  >> non-rewindable remainder being one JACK period (which may be
> different from one ALSA period). If the JACK period is 256 samples, this
> plugin should behave very much like one voice of ymfpci.
>  >>
>
> does support snd_pcm_rewind imply support snd_pcm_forward ?

I thought so, but, after thinking a bit more about ADPCM and attempting 
to fix rewinds there, I am no longer sure. In any case, remembering and 
reprocessing the past input is a valid way to implement forwards.

>
>
>            (err = snd_pcm_ioplug_set_param_minmax(&jack->io,
> SND_PCM_IOPLUG_HW_PERIOD_BYTES, 128, 64*1024)) < 0 ||
>
> Like pulse plugin which use same period bytes min as snd-hda-intel
>
> The application can use arbitrary period size but hwptr  seem not always
> change at one period time,  this is much worse than those drivers with
> SNDRV_PCM_INFO_BATCH

For the jack plugin, it is a bug that it hardcodes 128 bytes and thus 
exposes period sizes less than one jack period. If I have time, I will 
look into fixing this, too.

> what other events pulseaudio need to rewind beside
>
> 1) change in volume of sink/source
> 2) change in volume of streams
> 3) change in latency
> 4) sync slaves of combined sinks

I don't think that (4) is valid. It is handled by resampling, not rewinding.

5) explicit rewrite request from the client (if the sink has already 
rendered the rewritten data into its buffer)
6) state change ("If we are added for the first time...") of the sink input
7) corking/uncorking
8) end of underrun (for specific sink inputs)
9) moving streams between sinks

>
>  >The defaults are:
>  >  ; default-fragments = 4
>  > ; default-fragment-size-msec = 25
>  >
>
> Do you mean if volume change is delayed by one buffer( 0.1 seconds ) is
> still unacceptable if the user choose 4 x 25ms buffer time for the sink ?

I didn't explicitly mean this. However, please look at this old bug 
resulting from changing the volume at the wrong time: 
http://lists.freedesktop.org/archives/pulseaudio-bugs/2010-January/003766.html 
(which is now fixed for all cards that implement deferred volume changes).

-- 
Alexander E. Patrakov

--------------010201020409080902030703
Content-Type: text/x-csrc;
 name="pcm_rewindable.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pcm_rewindable.c"

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


int main(int argc, char* argv[])
{
        int err;
	int failed = 0;
        unsigned int j;
	short *silence;
	snd_pcm_sframes_t rewindable = 1;
	snd_pcm_uframes_t min_period_size;
	int dir;

        snd_pcm_t *handle;
	snd_output_t *out = NULL;

	snd_pcm_hw_params_t *params;
	snd_pcm_sw_params_t *swparams;

	snd_pcm_hw_params_alloca(&params);
	snd_pcm_sw_params_alloca(&swparams);

	snd_output_stdio_attach(&out, stderr, 0);
	silence = calloc(period_size * periods, sizeof(short) * channels);

	if ((err = snd_pcm_open(&handle, device, SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
		fprintf(stderr, "Playback open error: %s\n", snd_strerror(err));
		exit(EXIT_FAILURE);
	}

	failed =           (err = snd_pcm_hw_params_any(handle, params)) < 0;
	failed = failed || (err = snd_pcm_hw_params_set_rate_resample(handle, params, 1)) < 0;
	failed = failed || (err = snd_pcm_hw_params_set_access(handle, params, SND_PCM_ACCESS_RW_INTERLEAVED)) < 0;
	failed = failed || (err = snd_pcm_hw_params_set_format(handle, params, SND_PCM_FORMAT_S16)) < 0;
	failed = failed || (err = snd_pcm_hw_params_set_channels(handle, params, channels)) < 0;
	failed = failed || (err = snd_pcm_hw_params_set_rate(handle, params, rate, 0)) < 0;

	if (failed) {
		fprintf(stderr, "Playback hwparams (access & format) error: %s\n", snd_strerror(err));
		exit(EXIT_FAILURE);
	}

	err = snd_pcm_hw_params_get_period_size_min(params, &min_period_size, &dir);
	if (err < 0) {
		fprintf(stderr, "Cannot get minimum period size: %s\n", snd_strerror(err));
	}

	fprintf(stderr, "min_period_size: %d frames, dir: %d\n", (int)min_period_size, dir);

	failed =           (err = snd_pcm_hw_params_set_period_size(handle, params, period_size, 0)) < 0;
	failed = failed || (err = snd_pcm_hw_params_set_periods(handle, params, periods, 0)) < 0;
	failed = failed || (err = snd_pcm_hw_params(handle, params)) < 0;
	if (failed) {
		fprintf(stderr, "Playback hwparams (period size & periods) error: %s\n", snd_strerror(err));
		exit(EXIT_FAILURE);
	}

	failed =           (err = snd_pcm_sw_params_current(handle, swparams)) < 0;
	failed = failed || (err = snd_pcm_sw_params_set_start_threshold(handle, swparams, period_size)) < 0;
	failed = failed || (err = snd_pcm_sw_params_set_avail_min(handle, swparams, period_size)) < 0;
	failed = failed || (err = snd_pcm_sw_params(handle, swparams)) < 0;
	if (failed) {
		fprintf(stderr, "Playback swparams error: %s\n", snd_strerror(err));
		exit(EXIT_FAILURE);
	}

	snd_pcm_dump(handle, out);
	fprintf(stderr, "Playing silence\n");
	fflush(stderr);
	memset(silence, 0, period_size * periods * sizeof(short) * channels);
	err = snd_pcm_writei(handle, silence, period_size * periods);
	if (err < 0) {
		fprintf(stderr, "Playback error: %s\n", snd_strerror(err));
		exit(EXIT_FAILURE);
	}

	j = 0;
	while (rewindable > 0) {
		// snd_pcm_avail(handle);
		snd_pcm_sframes_t rewindable1 = snd_pcm_rewindable(handle);
		if (rewindable != rewindable1) {
			fprintf(stderr, "===================\n");
			fprintf(stderr, "State: %d\n", snd_pcm_state(handle));
			snd_pcm_dump(handle, out);
			fprintf(stderr, "Rewindable: %d, loop iteration: %d\n", (int)rewindable1, j);
			if (rewindable1 < 0)
				fprintf(stderr, "This means %s\n", snd_strerror(rewindable1));
		}
		rewindable = rewindable1;
		j++;
	}
	snd_pcm_drop(handle);
	snd_pcm_close(handle);

	free(silence);
	return 0;
}

--------------010201020409080902030703
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010201020409080902030703--
