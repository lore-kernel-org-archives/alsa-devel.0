From: naveenkrishna.ch <naveenkrishna.ch@gmail.com>
Subject: [ASoC] TWL4030 underrun error
Date: Thu, 18 Dec 2008 10:49:30 +0530
Message-ID: <ef0d8a250812172119t4364194bw839d643c69fc5f3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f19.google.com (mail-gx0-f19.google.com
	[209.85.217.19]) by alsa0.perex.cz (Postfix) with ESMTP id 6891424365
	for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2008 06:19:32 +0100 (CET)
Received: by gxk12 with SMTP id 12so281130gxk.8
	for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2008 21:19:31 -0800 (PST)
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
List-Id: alsa-devel@alsa-project.org

Hello,

I am working on OMAP3 + TWL4030 combination for ASoC codec

The omap generic omap-pcm.c file has

static const struct snd_pcm_hardware omap_pcm_hardware = {
        .info                   = SNDRV_PCM_INFO_MMAP |
                                  SNDRV_PCM_INFO_MMAP_VALID |
                                  SNDRV_PCM_INFO_INTERLEAVED |
                                  SNDRV_PCM_INFO_BLOCK_TRANSFER |
                                  SNDRV_PCM_INFO_PAUSE |
                                  SNDRV_PCM_INFO_RESUME,
        .formats                = SNDRV_PCM_FMTBIT_S16_LE,
        .rates                  = SNDRV_PCM_RATE_8000_96000,
        .period_bytes_min       = 32,
        .period_bytes_max       = 64 * 1024,
        .periods_min            = 2,
        .periods_max            = 255,
        .buffer_bytes_max       = 128 * 1024,
};

following structure,

When i play with
aplay XXX.wav

Rare but i used to get some underrun messages
 i found thses message are coming from aplay.

underrun!!! (at least 10271.545 ms long)
underrun!!! (at least 904.663 ms long)
underrun!!! (at least 771.790 ms long)
underrun!!! (at least 3393.433 ms long)
underrun!!! (at least 777.314 ms long)

I dint found much info about this in net too.
How can i solve this, can any one help me out

-- 
Thanks,

(: Naveen Krishna Ch :)
