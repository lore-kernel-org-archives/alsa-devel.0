From: Alicia Romero <alromor84@gmail.com>
Subject: Problem with "set_period_size"
Date: Thu, 23 Feb 2012 15:06:12 +0100
Message-ID: <CAKjtJDVC2tZi8FLAo4ADZKr1iB5e0sX9t-jjPQF25F+R0NXBog@mail.gmail.com>
References: <CAKjtJDWJSwoO982Hk5hK44khY5Jw=wMrW3QhrincvJ_iTLDGEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1719824476
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 15:06:33 +0100 (CET)
Received: by ghbg19 with SMTP id g19so579494ghb.38
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 06:06:32 -0800 (PST)
In-Reply-To: <CAKjtJDWJSwoO982Hk5hK44khY5Jw=wMrW3QhrincvJ_iTLDGEg@mail.gmail.com>
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
List-Id: alsa-devel@alsa-project.org

Hi list!
I am new using an ALSA device and I have a problem when setting the period
size.
In my code I try to set the period size to 640 as follow:

     snd_pcm_hw_params_set_access (stream->pb_pcm, params,
SND_PCM_ACCESS_RW_INTERLEAVED);
    /* Set format */
    snd_pcm_hw_params_set_format (stream->pb_pcm, params,
SND_PCM_FORMAT_S16_LE);
    /* Set number of channels */
    snd_pcm_hw_params_set_channels (stream->pb_pcm, params, 2);
    /* Set clock rate */
    rate =32000;
    snd_pcm_hw_params_set_rate_near (stream->pb_pcm, params, &rate, NULL);
    /* Set period size to samples_per_frame frames. */
    stream->pb_frames = (snd_pcm_uframes_t) 640;
    snd_pcm_hw_params_set_period_size_near (stream->pb_pcm, params,
                        &stream->pb_frames, NULL);
    /* Set the sound device buffer size and latency */
    if (param->flags & PJMEDIA_AUD_DEV_CAP_OUTPUT_LATENCY)
    tmp_buf_size = (rate / 1000) * param->output_latency_ms;
    else
    tmp_buf_size = (rate / 1000) * PJMEDIA_SND_DEFAULT_PLAY_LATENCY;
    snd_pcm_hw_params_set_buffer_size_near (stream->pb_pcm, params,
                        &tmp_buf_size);
    stream->param.output_latency_ms = tmp_buf_size / (rate / 1000);
    /* Activate the parameters */
    snd_pcm_hw_params (stream->pb_pcm, params);


The problem here is that the period size is not set to 640, but to 512.
Otherwise if I use instead:

    stream->pb_frames = (snd_pcm_uframes_t) 640;
    snd_pcm_hw_params_set_period_size (stream->pb_pcm, params,
                        &stream->pb_frames, NULL);

the period size is set to 640 and the device is working correctly.

Why is not set to 640 if I use the "*_near*" version?
Thanks!!! :)
