From: Randolph Chung <rchung42@gmail.com>
Subject: Problem with MX27 ASoC audio
Date: Thu, 12 Aug 2010 18:15:47 +0800
Message-ID: <AANLkTikAybX=rP-DfWm5z8eVcC1EaujyEofsSoSJQ1M8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5686D1038D8
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Aug 2010 12:15:48 +0200 (CEST)
Received: by wwc33 with SMTP id 33so517064wwc.20
	for <alsa-devel@alsa-project.org>; Thu, 12 Aug 2010 03:15:48 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: s.hauer@pengutronix.de
List-Id: alsa-devel@alsa-project.org

I have a target that uses iMX27(L) + tlv320aic3x. The kernel tree is
HEAD of linux-arm from about a week ago.

Simple playback and recording (using aplay and arecord) work fine.
However, I've run into a strange problem when both playback and
capture streams are opened at the same time.

Consider the attached test program. The capture device is setup with a
period time of 10ms, and the program reads samples in a loop. The
expected result is that I get a sample every 10ms. This works fine if
the playback device is *not* opened (more specifically, if the
hw_params are not set). However if the playback device is opened (#if
1 code) then I get samples every 20ms, which seems very wrong.

I have tried using both DMA and FIQ ssi-pcm interfaces and both give
the same strange result. With the FIQ driver, if I instrument the
timer callback, the timer triggers every 10ms but there is only enough
data every 20ms.

The codec is being driven with a 13MHz MCLK (output from MX27) and the
BCLK and WCLK come from the codec. They seem to have the correct
rates.

Any ideas? Can anybody else with MX27 hardware verify if my test
program also fails on their target?

thanks,
randolph


/* Test program */

#include <alsa/asoundlib.h>
#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <sys/time.h>

int main(int argc, char **argv)
{
    int err = -1;
    char buf[4096];
    unsigned long period_size;
    snd_pcm_t *in_handle = NULL, *out_handle;
    snd_pcm_hw_params_t *hwparams;

    if (snd_pcm_open(&in_handle, "hw:0,0", SND_PCM_STREAM_CAPTURE, 0) < 0) {
        printf("Cannot open capture device\n");
        return -1;
    }
    snd_pcm_hw_params_malloc(&hwparams);
    snd_pcm_hw_params_any(in_handle, hwparams);
    snd_pcm_hw_params_set_access(in_handle, hwparams,
SND_PCM_ACCESS_RW_INTERLEAVED);
    snd_pcm_hw_params_set_format(in_handle, hwparams, SND_PCM_FORMAT_S16_LE);
    snd_pcm_hw_params_set_channels(in_handle, hwparams, 1);
    snd_pcm_hw_params_set_rate(in_handle, hwparams, 8000, 0);
    snd_pcm_hw_params_set_period_time(in_handle, hwparams, 10000, 0);
    snd_pcm_hw_params_get_period_size(hwparams, &period_size, 0);
    snd_pcm_hw_params(in_handle, hwparams);
    snd_pcm_hw_params_free(hwparams);

    if (snd_pcm_open(&out_handle, "hw:0,0", SND_PCM_STREAM_PLAYBACK, 0) < 0) {
        printf("Cannot open playback device\n");
        return -1;
    }
#if 1
    snd_pcm_hw_params_malloc(&hwparams);
    snd_pcm_hw_params_any(out_handle, hwparams);
    snd_pcm_hw_params_set_access(out_handle, hwparams,
SND_PCM_ACCESS_RW_INTERLEAVED);
    snd_pcm_hw_params_set_format(out_handle, hwparams, SND_PCM_FORMAT_S16_LE);
    snd_pcm_hw_params_set_channels(out_handle, hwparams, 1);
    snd_pcm_hw_params_set_rate(out_handle, hwparams, 8000, 0);
    snd_pcm_hw_params_set_period_time(out_handle, hwparams, 10000, 0);
    snd_pcm_hw_params(out_handle, hwparams);
    snd_pcm_hw_params_free(hwparams);
#endif

    printf("period size = %u\n", period_size);

    printf("Config done, start loop\n");
    while (1) {
        struct timeval tv;
        int ret = snd_pcm_readi(in_handle, buf, period_size);
        if (ret < 0)
            snd_pcm_prepare(in_handle);
        gettimeofday(&tv, NULL);
        printf("[%u.%06u] snd_pcm_readi() return %d\n",
            tv.tv_sec, tv.tv_usec, ret);
    }

    return 0;
}
