From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-generic-dmaengine-pcm: Fix sparse
	warnings" to the asoc tree
Date: Mon, 26 Feb 2018 11:17:13 +0000
Message-ID: <E1eqGmP-0005Pg-BS@debutante>
References: <1519326142-26421-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DEF1C267990
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 12:17:15 +0100 (CET)
In-Reply-To: <1519326142-26421-2-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-generic-dmaengine-pcm: Fix sparse warnings

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7ed310bd51bec0b440a551fc4da1993c7f6cd231 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Thu, 22 Feb 2018 16:02:22 -0300
Subject: [PATCH] ASoC: soc-generic-dmaengine-pcm: Fix sparse warnings

Currently the following sparse warnings are observed:

sound/soc/soc-generic-dmaengine-pcm.c:185:34: warning: restricted snd_pcm_format_t degrades to integer
sound/soc/soc-generic-dmaengine-pcm.c:186:66: warning: incorrect type in argument 1 (different base types)
sound/soc/soc-generic-dmaengine-pcm.c:186:66:    expected restricted snd_pcm_format_t [usertype] format
sound/soc/soc-generic-dmaengine-pcm.c:186:66:    got int [signed] [assigned] i

Fix it by changing the loop variable to be of 'snd_pcm_format_t'.

Also introduce a SNDRV_PCM_FORMAT_FIRST label, which corresponds to the
first member (index 0) of the snd_pcm_format_t formats.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/uapi/sound/asound.h           | 1 +
 sound/soc/soc-generic-dmaengine-pcm.c | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 07d61583fd02..ed0a120d4f08 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -242,6 +242,7 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_DSD_U16_BE	((__force snd_pcm_format_t) 51) /* DSD, 2-byte samples DSD (x16), big endian */
 #define	SNDRV_PCM_FORMAT_DSD_U32_BE	((__force snd_pcm_format_t) 52) /* DSD, 4-byte samples DSD (x32), big endian */
 #define	SNDRV_PCM_FORMAT_LAST		SNDRV_PCM_FORMAT_DSD_U32_BE
+#define	SNDRV_PCM_FORMAT_FIRST		SNDRV_PCM_FORMAT_S8
 
 #ifdef SNDRV_LITTLE_ENDIAN
 #define	SNDRV_PCM_FORMAT_S16		SNDRV_PCM_FORMAT_S16_LE
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 32ea16d062b1..785f25ede3e5 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -132,7 +132,8 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
 	u32 addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 			  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
-	int i, ret;
+	snd_pcm_format_t i;
+	int ret;
 
 	if (pcm->config && pcm->config->pcm_hardware)
 		return snd_soc_set_runtime_hwparams(substream,
@@ -182,7 +183,7 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
 		 * default assumption is that it supports 1, 2 and 4 bytes
 		 * widths.
 		 */
-		for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
+		for (i = SNDRV_PCM_FORMAT_FIRST; i <= SNDRV_PCM_FORMAT_LAST; i++) {
 			int bits = snd_pcm_format_physical_width(i);
 
 			/*
-- 
2.16.1
