From: Adam Rosenberg <adam@alcorn.com>
Subject: Re: How does struct snd_pcm_hardware relate to the
	actual hardware
Date: Mon, 12 Jul 2010 16:35:30 -0400
Message-ID: <AANLkTilZBK1qyxlOHeckmK4NiL0eC055aptip6fAu4hh@mail.gmail.com>
References: <AANLkTimiH0xvYIM-gmxx95W3N4PmFKqa1skknvsxluY8@mail.gmail.com>
	<20100701184032.GH8742@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7FBCB245AC
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Jul 2010 22:35:31 +0200 (CEST)
Received: by vws9 with SMTP id 9so4794654vws.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Jul 2010 13:35:30 -0700 (PDT)
In-Reply-To: <20100701184032.GH8742@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

I determined that the secondary data lines of my SPORT were not being
enabled properly.  With that problem solved I am finally seeing test
data sent to the DACs correctly.  I am still having problems with
placing the data correctly using my custom PCM copy operation.

I do not understand the relationship between snd_pcm_period_elapsed
and the PCM copy and trigger functions.  Where can I find a detailed
description of how this works?

I am attempting to troubleshoot this problem but it seems to change
based on values I enter into struct snd_pcm_hardware, which I copy to
substream->runtime->hw when the PCM open operation occurs.  What are
the correct values for struct snd_pcm_hardware?

I have included the values I am currently using and a brief
description of the hardware configuration below:

I am using one Blackfin BF537 SPORT to transfer 16 channels of audio
to 2 CS42448 CODECs using TDM.  There are 8 channels per TDM frame.
The Primary SPORT data lines are connected to one CS42448 and the
Secondary are connected to another.  I use one DMA buffer of 131072
bytes and configure the DMA for 8 periods. I have to interleave the
channel data so that each CODEC receives one TDM frame for every frame
sync clock.  With 8 channels in each TDM frame, there are 256 bits per
frame sync clock.  The frame sync clock and bit clock are generated
from an ICS661 audio clock source configured for 12.288Mhz (256bits *
48Khz).

static struct snd_pcm_hardware ourCS42448PcmHw =
{
	.info = (SNDRV_PCM_INFO_INTERLEAVED |
                   SNDRV_PCM_INFO_BLOCK_TRANSFER |
                   SNDRV_PCM_INFO_RESUME),

	.formats = SNDRV_PCM_FMTBIT_S32_LE,

	.rates = SNDRV_PCM_RATE_48000,
	.rate_min = 48000,
	.rate_max = 48000,

	.buffer_bytes_max = 32768,

	.channels_min = 2,
	.channels_max = 2,

	.period_bytes_min = 4096,
	.period_bytes_max = 4096,

	.periods_min = 8,
	.periods_max = 8,
};

Thanks,
Adam

Adam Rosenberg
Software Engineer

Alcorn McBride Inc.
3300 South Hiawassee
Building 105
Orlando, FL 32835

(407) 296 - 5800 ext. 5490
