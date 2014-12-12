From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH RFC 0/9] audio timestamping evolutions
Date: Fri, 12 Dec 2014 09:28:46 -0600
Message-ID: <548B09AE.1090000@linux.intel.com>
References: <1418077426-8309-1-git-send-email-pierre-louis.bossart@linux.intel.com>	<CAN8cciaOsP9wk0wvu5S4BXMwZ6mbe6iqBxBc8OfpirF4XN3PgQ@mail.gmail.com>	<54885ED2.8050403@linux.intel.com>
 <CAN8cciY0_2_FamMDSVkz77D_DwpfZFT-PVv7Cx-Q=+7N1Of0ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 36667260669
 for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2014 16:28:48 +0100 (CET)
In-Reply-To: <CAN8cciY0_2_FamMDSVkz77D_DwpfZFT-PVv7Cx-Q=+7N1Of0ag@mail.gmail.com>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


>
> #define PERIOD 6000
>
> #define PLAYBACK_BUFFERS 4
>
> unsigned char buffer_p[PERIOD*4*4];
> unsigned char buffer_c[PERIOD*4*4];
>
> I don't understand why you hard coded PERIOD and PLAYBACK_BUFFERS
> when you use snd_pcm_set_params

Thanks for pointing this out. I have no idea what this is still there, i 
think the idea was to use a fixed-size buffer to make sure the timing is 
predictable, it's been that way for 2+ years. Will fix.

>
> since period size and buffer size can be obtained by
> snd_pcm_get_params() after calling snd_pcm_set_params()
>
> if ((err = snd_pcm_set_params(handle_p,
>                                SND_PCM_FORMAT_S16,
>                                SND_PCM_ACCESS_RW_INTERLEAVED,
>                                2,
>                                48000,
>                                0,
>                                500000)) < 0) { /* 0.5sec */
>
