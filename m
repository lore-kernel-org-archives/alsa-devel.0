From: Selma Bensaid <selma.bensaid@intel.com>
Subject: [PATCH] ASOC: utils: Update dummy codec DAI settings
	to allow stream creation
Date: Thu,  7 Jun 2012 12:08:41 +0200
Message-ID: <1339063721-15193-1-git-send-email-selma.bensaid@intel.com>
References: <1339058158.1927.15.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id B49C510453D
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 12:08:54 +0200 (CEST)
In-Reply-To: <1339058158.1927.15.camel@vkoul-udesk3>
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
Cc: vinod.koul@intel.com, sylvain.centelles@intel.com, broonie@opensource.wolfsonmicro.com, louis.le.gall@intel.com, Selma Bensaid <selma.bensaid@intel.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

This patch consists in settings the channels_min, rates and formats
of the dummy codec DAI driver to enable the creation of the PCM streams
using it.

Signed-off-by: Selma Bensaid <selma.bensaid@intel.com>
---
 include/sound/pcm.h   |    7 +++++++
 sound/soc/soc-utils.c |   13 +++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index ff536f1..649b0d5 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -203,6 +203,13 @@ struct snd_pcm_ops {
 #define SNDRV_PCM_FMTBIT_IEC958_SUBFRAME SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_BE
 #endif
 
+#define SNDRV_PCM_FMTBIT_CONTINUOUS \
+	(SNDRV_PCM_FMTBIT_S16 | SNDRV_PCM_FMTBIT_U16 |\
+	SNDRV_PCM_FMTBIT_S24 | SNDRV_PCM_FMTBIT_U24 |\
+	SNDRV_PCM_FMTBIT_S32 | SNDRV_PCM_FMTBIT_U32 |\
+	SNDRV_PCM_FMTBIT_FLOAT | SNDRV_PCM_FMTBIT_FLOAT64 |\
+	SNDRV_PCM_FMTBIT_IEC958_SUBFRAME)
+
 struct snd_pcm_file {
 	struct snd_pcm_substream *substream;
 	int no_compat_mmap;
diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 6005370..79125a0 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -92,6 +92,19 @@ static struct snd_soc_platform_driver dummy_platform = {
 static struct snd_soc_codec_driver dummy_codec;
 static struct snd_soc_dai_driver dummy_dai = {
 	.name = "snd-soc-dummy-dai",
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 16,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.formats = SNDRV_PCM_FMTBIT_CONTINUOUS,
+	},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 16,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
+		.formats = SNDRV_PCM_FMTBIT_CONTINUOUS,
+	},
+	.ops = NULL,
 };
 
 static __devinit int snd_soc_dummy_probe(struct platform_device *pdev)
-- 
1.7.0.4

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
