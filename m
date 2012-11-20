From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 10/10] ASoC: kirkwood-dma: remove channel
	restrictions
Date: Tue, 20 Nov 2012 12:20:55 +0000
Message-ID: <E1Tamox-0007Xk-3H@rmk-PC.arm.linux.org.uk>
References: <20121120121726.GN3290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id B3E0126537C
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2012 13:20:57 +0100 (CET)
In-Reply-To: <20121120121726.GN3290@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Liam Girdwood <lrg@ti.com>, Rabeeh Khoury <rabeeh@solid-run.com>
List-Id: alsa-devel@alsa-project.org

This is part of a patch found in Rabeeh Khoury's git tree for the
cubox.

With SPDIF passthrough, we are not restricted to just two channels of
audio; we can support however many channels the non-audio stream can
itself support.  In any case, kirkwood-dma is not involved in the
format selection.  So yet rid of this restriction.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 sound/soc/kirkwood/kirkwood-dma.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index 73c90c6..58d5a96 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -29,7 +29,9 @@
 #define KIRKWOOD_FORMATS \
 	(SNDRV_PCM_FMTBIT_S16_LE | \
 	 SNDRV_PCM_FMTBIT_S24_LE | \
-	 SNDRV_PCM_FMTBIT_S32_LE)
+	 SNDRV_PCM_FMTBIT_S32_LE | \
+	 SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE | \
+	 SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_BE)
 
 struct kirkwood_dma_priv {
 	struct snd_pcm_substream *play_stream;
@@ -48,7 +50,7 @@ static struct snd_pcm_hardware kirkwood_dma_snd_hw = {
 	.rate_min		= 8000,
 	.rate_max		= 384000,
 	.channels_min		= 1,
-	.channels_max		= 2,
+	.channels_max		= 8,
 	.buffer_bytes_max	= KIRKWOOD_SND_MAX_PERIOD_BYTES * KIRKWOOD_SND_MAX_PERIODS,
 	.period_bytes_min	= KIRKWOOD_SND_MIN_PERIOD_BYTES,
 	.period_bytes_max	= KIRKWOOD_SND_MAX_PERIOD_BYTES,
-- 
1.7.4.4
