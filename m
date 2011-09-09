From: Latha Prabhu <lvprabhu@gmail.com>
Subject: ALSA
Date: Fri, 9 Sep 2011 12:22:08 +0530
Message-ID: <CANgzfOudyZwR2i25fJAMdAxkyrKM8jJ64hGP_5cNbgaXfOKZwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EFDF103ADA
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 08:52:08 +0200 (CEST)
Received: by vws20 with SMTP id 20so715701vws.24
	for <alsa-devel@alsa-project.org>; Thu, 08 Sep 2011 23:52:08 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, lvprabhu@gmail.com
List-Id: alsa-devel@alsa-project.org

I wrote a sample program as follows to OPEN ALSA sound device and set its hw
params -

Code:

    /* Open PCM device for playback. */
    rc = snd_pcm_open(&handle, "default",
                    SND_PCM_STREAM_PLAYBACK, 0);
    if (rc < 0) {
      fprintf(stderr,
            "unable to open pcm device: %s\n",
            snd_strerror(rc));
      return 1;
    }

    /* Allocate a hardware parameters object. */
    snd_pcm_hw_params_alloca(&params);

    /* Fill it in with default values. */
    snd_pcm_hw_params_any(handle, params);

    /* Set the desired hardware parameters. */

    /* Interleaved mode */
    snd_pcm_hw_params_set_access(handle, params,
SND_PCM_ACCESS_RW_INTERLEAVED);

    /* Signed 16-bit little-endian format */
    snd_pcm_hw_params_set_format(handle, params, SND_PCM_FORMAT_S16_LE);

    /* One channel (mono) */
    snd_pcm_hw_params_set_channels(handle, params, 1);

    /* 8000 bits/second sampling rate  */
    val = 8000;
    snd_pcm_hw_params_set_rate_near(handle, params,
                                  &val, &dir);

    /* Set period size to 32 frames. */
    frames = 32;
    snd_pcm_hw_params_set_period_size_near(handle,
                              params, &frames, &dir);
    fflush(stderr);

    /* Write the parameters to the driver */
    rc = snd_pcm_hw_params(handle, params);

Above lines of code works fine if I run it as an independent test program.
When I use the same lines of code in my application, it is failing in
snd_pcm_hw_params_any(). It returns "Operation not permitted". So I changed
the device name to "plughw:0,0", instead of "default".
With this change, its failing at snd_pcm_hw_params_set_rate_near(). It
returns some huge value 192000. Also, following
snd_pcm_hw_params_set_period_size() also fails with 699050.

Any idea, why I'm getting this error? Is link to some other library or some
header file inclusion, in my application causing this error? I am trying to
play 8k, 16 bit PCM audio.

Then I changed snd_pcm_hw_set_rate_near() to snd_pcm_hw_set_rate() and also
snd_pcm_hw_params_set_period_size_near() to
snd_pcm_hw_params_set_period_size(). These 2 calls succeed. But when I check
period_size after calling snd_pcm_hw_params(), it is different. My set value
was 32 but I got it as 1. Then call to snd_pcm_writei() crashes with -
 pcm.c:1240: snd_pcm_writei: Assertion `pcm' failed.

Please note my application is  multi threaded but opening the device and
setting hardware parameters are under one place.

I appreciate your help on this.

Thanks,
Latha
