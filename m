From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH RFC 0/9] audio timestamping evolutions
Date: Fri, 12 Dec 2014 12:55:30 +0800
Message-ID: <CAN8cciY0_2_FamMDSVkz77D_DwpfZFT-PVv7Cx-Q=+7N1Of0ag@mail.gmail.com>
References: <1418077426-8309-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <CAN8cciaOsP9wk0wvu5S4BXMwZ6mbe6iqBxBc8OfpirF4XN3PgQ@mail.gmail.com>
 <54885ED2.8050403@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f182.google.com (mail-qc0-f182.google.com
 [209.85.216.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 29D20260645
 for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2014 05:55:32 +0100 (CET)
Received: by mail-qc0-f182.google.com with SMTP id r5so5073019qcx.13
 for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2014 20:55:31 -0800 (PST)
In-Reply-To: <54885ED2.8050403@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>>
>> It seem that audio_time.c is hardcoded to use 48000Hz which is the hda
>> link rate, do the measurement still valid when application use 44100Hz ?
>
>
> If you use a wallclock then you really abstract away the actual sampling
frequency and the transmission pattern discontinuity
(12-11-11-12-11-11-12-11-11-11 pattern, with an invalid sample every 12 or
11 samples for HDAudio). It wouldn't matter if you transmitted 44.1 or
48kHz since they use the same wall clock ticks.
>
>

#define PERIOD 6000

#define PLAYBACK_BUFFERS 4

unsigned char buffer_p[PERIOD*4*4];
unsigned char buffer_c[PERIOD*4*4];

I don't understand why you hard coded PERIOD and PLAYBACK_BUFFERS
when you use snd_pcm_set_params

since period size and buffer size can be obtained by snd_pcm_get_params()
after calling snd_pcm_set_params()

if ((err = snd_pcm_set_params(handle_p,
                              SND_PCM_FORMAT_S16,
                              SND_PCM_ACCESS_RW_INTERLEAVED,
                              2,
                              48000,
                              0,
                              500000)) < 0) { /* 0.5sec */
