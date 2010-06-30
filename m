From: Adam Rosenberg <adam@alcorn.com>
Subject: How does struct snd_pcm_hardware relate to the actual
	hardware
Date: Wed, 30 Jun 2010 17:32:41 -0400
Message-ID: <AANLkTimiH0xvYIM-gmxx95W3N4PmFKqa1skknvsxluY8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id A182624472
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Jun 2010 23:32:42 +0200 (CEST)
Received: by vws11 with SMTP id 11so1490861vws.38
	for <alsa-devel@alsa-project.org>; Wed, 30 Jun 2010 14:32:41 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

I am using DMA to transfer data to SPORT1 on my Blackfin BF537.  I am
using a CS42448 CODEC that has 8 DACs.  I am using TDM mode and have
set the following:

DMA Buffer Size For Each SPORT Data Line (Rx or Tx) = 131072 bytes
DMA Periods = 8

static struct snd_pcm_hardware snd_pcm_hw =
{
	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
SNDRV_PCM_INFO_RESUME),
	.formats = SNDRV_PCM_FMTBIT_S32_LE,
	.rates = SNDRV_PCM_RATE_48000,
	.rate_min = 48000,
	.rate_max = 48000,
	.buffer_bytes_max = 32768,
	.channels_min = 2,
	.channels_max = 2,
	.period_bytes_min = 8,
	.period_bytes_max = 4096,
	.periods_min = 8,
	.periods_max = 8,
};

Everytime I receive a DMA interrupt from the SPORT driver I call
snd_pcm_period_elapsed for all of the substreams that are currently
active.  In the PCM Copy callback I calculate the position within the
DMA buffer to write to based on the TDM slot for the channel and the
position passed into the function.

The audio is not being placed into the DMA buffer properly.  The audio
plays faster than it should and has a constant stutter.  I have read
the "writing an ALSA driver" guide multiple times but it does not
explain the relationship between struct snd_pcm_hardware,
snd_pcm_period_elapsed, and the copy callback clearly enough for me to
understand what I am doing wrong.

Please explain how these interact in more detail to help me fix this
problem.  I can also send the full source code to the CS42448 driver I
am working on if more details are needed.

Thank you,
Adam
