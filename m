From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 7/8] ASoC: Blackfin: Simplify the MMAP_SUPPORT
	macros protected code
Date: Tue, 18 Nov 2008 16:18:21 +0800
Message-ID: <1226996302-10234-8-git-send-email-cooloney@kernel.org>
References: <1226996302-10234-1-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id BE406244D1
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 09:17:02 +0100 (CET)
In-Reply-To: <1226996302-10234-1-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@sirena.org.uk, tiwai@suse.de
Cc: Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Bryan Wu <cooloney@kernel.org>
List-Id: alsa-devel@alsa-project.org

Cc: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 sound/soc/blackfin/bf5xx-ac97-pcm.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-ac97-pcm.c b/sound/soc/blackfin/bf5xx-ac97-pcm.c
index 4d25f73..d3d51bc 100644
--- a/sound/soc/blackfin/bf5xx-ac97-pcm.c
+++ b/sound/soc/blackfin/bf5xx-ac97-pcm.c
@@ -100,17 +100,14 @@ static void bf5xx_dma_irq(void *data)
  * The total rx/tx buffer is for ac97 frame to hold all pcm data
  * is  0x20000 * sizeof(struct ac97_frame) / 4.
  */
-#if defined(CONFIG_SND_BF5XX_MMAP_SUPPORT)
 static const struct snd_pcm_hardware bf5xx_pcm_hardware = {
 	.info			= SNDRV_PCM_INFO_INTERLEAVED |
+#if defined(CONFIG_SND_BF5XX_MMAP_SUPPORT)
 				   SNDRV_PCM_INFO_MMAP |
 				   SNDRV_PCM_INFO_MMAP_VALID |
-				   SNDRV_PCM_INFO_BLOCK_TRANSFER,
-#else
-static const struct snd_pcm_hardware bf5xx_pcm_hardware = {
-	.info			= SNDRV_PCM_INFO_INTERLEAVED |
-				  SNDRV_PCM_INFO_BLOCK_TRANSFER,
 #endif
+				   SNDRV_PCM_INFO_BLOCK_TRANSFER,
+
 	.formats		= SNDRV_PCM_FMTBIT_S16_LE,
 	.period_bytes_min	= 32,
 	.period_bytes_max	= 0x10000,
-- 
1.5.6.3
