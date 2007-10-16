From: "Fengwei Yin" <yfw.bsp@gmail.com>
Subject: About the buffer_time and period_time
Date: Tue, 16 Oct 2007 16:27:58 +0800
Message-ID: <fb7b9d8c0710160127u569d294v45693f69f51883ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 400E924405
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Oct 2007 10:28:00 +0200 (CEST)
Received: by wx-out-0506.google.com with SMTP id t11so1963824wxc
	for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2007 01:27:58 -0700 (PDT)
Content-Disposition: inline
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
Cc: lea.li@marvell.com
List-Id: alsa-devel@alsa-project.org

Hi all,
I met a problem about period_time/buffer_time on PXA with ASOC enabled.
The kernel version is 2.6.21.

The Audio stream is 32k which is not supported by PXA ASOC driver. Please
refer following
RATES definition for PXA2xx.

#define PXA2XX_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |\
                SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |
SNDRV_PCM_RATE_44100 | \
                SNDRV_PCM_RATE_48000)

So I set plughw as default ALSA device enable auto samplerate conversion.

The code to set the period_time/buffer_time is as following:

    err = snd_pcm_hw_params_set_rate_near(hPCM, params, &rate, 0);
    if (err < 0) {
        error("Rate not available: %d\n", rate);
        return err;
    }


    err = snd_pcm_hw_params_get_buffer_time_max(params,
                &buffer_time, 0);
    if (buffer_time > 500000)
                buffer_time = 500000;

    buffer_time = 400000;
    period_time = buffer_time/4;

    err = snd_pcm_hw_params_set_buffer_time_near(hPCM, params, &buffer_time,
0);
    if (err < 0) {
            error("Buffer time not available: %d, error number: %d\n",
buffer_time,
                        err);
        return err;
    }

    err = snd_pcm_hw_params_set_period_time_near(hPCM, params, &period_time,
0);
    if (err < 0) {
        error("Period time not available: %d\n", period_time);
        return err;
    }


If I set buffer_time to 400000, I will get:
"
Buffer time not available: 400000, error number: -22

Cannot init audio driver.
Floating point exception
"
If I set buffer time to 500000, buffer_time can be set correctly. But audio
playback failed.

If I set period_time before setting buffer_time, Everything is OK.

Any thought about this problem. Thanks.

Regards
Yin, Fengwei
