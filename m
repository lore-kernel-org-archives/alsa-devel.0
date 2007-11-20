From: Heikki Lindholm <holindho@cs.helsinki.fi>
Subject: Re: alsa timestamps
Date: Tue, 20 Nov 2007 18:07:25 +0200
Message-ID: <4743063D.5030604@cs.helsinki.fi>
References: <47413D60.9000404@cs.helsinki.fi>	<47418778.20609@cs.helsinki.fi>	<Pine.LNX.4.61.0711191405590.7813@tm8103.perex-int.cz>	<4741929A.5000005@cs.helsinki.fi>	<s5habp9gg9c.wl%tiwai@suse.de>	<4742F528.3030905@cs.helsinki.fi>
	<s5hve7x3rl1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030101090200080904060808"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emh05.mail.saunalahti.fi (emh05.mail.saunalahti.fi
	[62.142.5.111]) by alsa0.perex.cz (Postfix) with ESMTP id 7F80324A4C
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 17:07:30 +0100 (CET)
In-Reply-To: <s5hve7x3rl1.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030101090200080904060808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai kirjoitti:
> At Tue, 20 Nov 2007 16:54:32 +0200,
> Heikki Lindholm wrote:
>> Takashi Iwai kirjoitti:
>>> At Mon, 19 Nov 2007 15:41:46 +0200,
>>> Heikki Lindholm wrote:
>>>> Jaroslav Kysela kirjoitti:
>>>>> On Mon, 19 Nov 2007, Heikki Lindholm wrote:
>>>>>
>>>>>> Heikki Lindholm kirjoitti:
>>>>>>> Hello list,
>>>>>>>
>>>>>>> I took up some old dusty code of mine that uses snd_pcm_state followed 
>>>>>>> by snd_pcm_status_get_tstamp when in capture mode. The code used to 
>>>>>>> work, but now the returned timestamps are all zeroes. Is there some API 
>>>>>>> change done recently or is the whole timestamping deprecated or 
>>>>>>> something? I've tried with different drivers on ubuntu's alsa .14 and 
>>>>>>> gentoo's .14. I've also tried mmap'ed and r/w modes, and I'm setting the 
>>>>>>> TSTAMP_MMAP sw param.
>>>>>> I figured out that this doesn't happen when using hw:x,y devices. Is it 
>>>>>> a documented feature that some (software?) devices don't fill in timestamps?
>>>>> I think that it should be fixed. Could you send us 'snd_pcm_dump()' for a 
>>>>> non-working device? It's probably ommited code in direct pcm plugins (dmix 
>>>>> & etc.).
>>>> Here goes. The driver is snd_aoa. It seems as if the timestamp mode 
>>>> isn't propagated to the hw device.
>>> AFAIK, the time-stamp mode isn't handled properly with direct plugins
>>> because of its nature.  Since the direct plugins share the same PCM
>>> hardware instance with multiple processes, you cannot change the
>>> parameter arbitrarily from a single client.
>>>
>>> We may implement an emulation in alsa-lib instead, though...
>> For the time being, is there any other way of determining whether a pcm 
>> supports time stamps than just trying out and seeing if zero is all that 
>> comes out?
> 
> Hmm, at the second look at the dmix/dsnoop code, it has some lines
> that actually update the timestamp value (as emulation).  So,
> basically it should work.  Maybe some other parts are broken...
> Do you have a small test case code just for checking?

Attached a test case that I just wrote. Seems I need it anyway since 
drivers are acting bogus, too. On a Power Mac G5, using snd_aoa, running 
the program with
./alsatest hw:0,0 1024
produces good timestamps whereas running with
./alsatest default 1024
produces zeros (the second param is period size).
I also observed the same behaviour on a bog standard x86, with SB Live, 
I think..

-- Heikki Lindholm


--------------030101090200080904060808
Content-Type: text/plain;
 name="alsatest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsatest.c"

#include <stdio.h>
#include <stdint.h>
#include <alsa/asoundlib.h>

#define FORMAT SND_PCM_FORMAT_S16_BE
#define RATE 48000

int main(int argc, char *argv[]) {
	snd_pcm_t *handle;
	snd_pcm_hw_params_t *params;
	snd_pcm_sw_params_t *swparams;
	snd_pcm_uframes_t period_size;
	snd_pcm_uframes_t buffer_size;
	snd_pcm_status_t *status;
	uint8_t *buf;
	int rate;
	int ret;
	ssize_t r;
	int t;

	if ((ret = snd_pcm_open(&handle, argv[1], 
			SND_PCM_STREAM_CAPTURE, 0)) < 0) {
		goto out;
	}

	snd_pcm_hw_params_alloca(&params);
	snd_pcm_sw_params_alloca(&swparams);
	if ((ret = snd_pcm_hw_params_any(handle, params)) < 0) {
		goto out;
	}
	if ((ret = snd_pcm_hw_params_set_access(handle,
			params, SND_PCM_ACCESS_RW_INTERLEAVED)) < 0) {
		goto out;
	}
	if ((ret = snd_pcm_hw_params_set_format(handle, params, 
			FORMAT)) < 0) {
		goto out;		
	}
	if ((ret = snd_pcm_hw_params_set_channels(handle,
			params, 2)) < 0) {
		goto out;
	}
	rate = RATE;
	if ((ret = snd_pcm_hw_params_set_rate_near(handle, params,
			&rate, 0) < 0)) {
		goto out;
	}
	period_size = atoi(argv[2]);
	if ((ret = snd_pcm_hw_params_set_period_size_near(handle, params,
			&period_size, 0)) < 0) {
		fprintf(stderr, "failed to set period size.\n");
	}
	t = 1000000;
	if ((ret = snd_pcm_hw_params_set_buffer_time_near(handle, params,
			&t, 0)) < 0) {
		fprintf(stderr, "failed to set buffer time.\n");
	}
	if ((ret = snd_pcm_hw_params(handle, params)) < 0) {
		goto out;
	}
	snd_pcm_hw_params_get_period_size(params, &period_size, 0);
	snd_pcm_hw_params_get_buffer_size(params, &buffer_size);

	snd_pcm_sw_params_current(handle, swparams);
	if ((ret = snd_pcm_sw_params_set_tstamp_mode(handle, swparams,
			 SND_PCM_TSTAMP_MMAP)) < 0) {
		goto out;
	}
	if ((ret = snd_pcm_sw_params(handle, swparams)) < 0) {	
		goto out;
	}
	if ((ret = snd_pcm_prepare(handle)) < 0) {
		goto out;
	}

	buf = malloc(period_size*2*2);

	snd_pcm_status_alloca(&status);
	for (t = 0; t < 1000; t++) {
		r = snd_pcm_readi(handle, buf, period_size);
		if (snd_pcm_status(handle, status) < 0) {
			fprintf(stderr, "snd_pcm_status failed.\n");
		}
		else {
			snd_htimestamp_t tstamp;
			snd_pcm_status_get_htstamp(status, &tstamp);
			printf("time: %d %d\n", tstamp.tv_sec, tstamp.tv_nsec);
		}
	}

	snd_pcm_close(handle);
out:
	return 0;
}

--------------030101090200080904060808
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030101090200080904060808--
