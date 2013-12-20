From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/19] ASoC: blackfin: Don't set unused struct
	snd_pcm_hardware fields
Date: Fri, 20 Dec 2013 14:20:09 +0100
Message-ID: <1387545625-19240-3-git-send-email-lars@metafoo.de>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-044.synserver.de (smtp-out-122.synserver.de
 [212.40.185.122])
 by alsa0.perex.cz (Postfix) with ESMTP id F1C8C26561E
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 15:19:34 +0100 (CET)
In-Reply-To: <1387545625-19240-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The ASoC core assumes that the PCM component of the ASoC card transparently
moves data around and does not impose any restrictions on the memory layout or
the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
the PCM driver that are related to this. Setting these fields in the PCM driver
might suggest otherwise though, so rather not set them.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/blackfin/bf5xx-ac97-pcm.c | 1 -
 sound/soc/blackfin/bf5xx-i2s-pcm.c  | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index 1d4c676..cdb8ee7 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -107,7 +107,6 @@ static const struct snd_pcm_hardware bf5xx_pcm_hardware = {
 #endif
 				   SNDRV_PCM_INFO_BLOCK_TRANSFER,
 
-	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
 	.period_bytes_min	= 32,
 	.period_bytes_max	= 0x10000,
 	.periods_min		= 1,
diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index 2a5b434..a3881c4 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -52,9 +52,6 @@ static const struct snd_pcm_hardware bf5xx_pcm_hardware = {
 	.info			= SNDRV_PCM_INFO_INTERLEAVED |
 				   SNDRV_PCM_INFO_MMAP_VALID |
 				   SNDRV_PCM_INFO_BLOCK_TRANSFER,
-	.formats		= SNDRV_PCM_FMTBIT_S16_LE |
-				   SNDRV_PCM_FMTBIT_S24_LE |
-				   SNDRV_PCM_FMTBIT_S32_LE,
 	.period_bytes_min	= 32,
 	.period_bytes_max	= 0x10000,
 	.periods_min		= 1,
-- 
1.8.0
