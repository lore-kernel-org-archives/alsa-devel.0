From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: cs42l73: Unify the way to define
	bits of register
Date: Fri, 18 Nov 2011 16:05:13 +0800
Message-ID: <1321603513.7338.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 26362103823
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 09:05:25 +0100 (CET)
Received: by ywp27 with SMTP id 27so2280213ywp.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 00:05:23 -0800 (PST)
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Brian Austin <brian.austin@cirrus.com>, Georgi Vlaev <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

Current code defines some bits with left shift to the proper bit defined in
datasheet, but some don't.
Unify the definition with proper left shift and adjust the code accordingly.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
Hi, 
I don't have this hardware handy.
I'd appreciate if someone can test this serial of patches.

Thanks
Axel
 sound/soc/codecs/cs42l73.c |    6 +++---
 sound/soc/codecs/cs42l73.h |   18 +++++++++---------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 6fe259a..0306e72 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -1028,13 +1028,13 @@ static int cs42l73_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 		switch (format) {
 		case SND_SOC_DAIFMT_DSP_B:
 			if (inv == SND_SOC_DAIFMT_IB_IF)
-				spc |= (PCM_MODE0 << 4);
+				spc |= PCM_MODE0;
 			if (inv == SND_SOC_DAIFMT_IB_NF)
-				spc |= (PCM_MODE1 << 4);
+				spc |= PCM_MODE1;
 		break;
 		case SND_SOC_DAIFMT_DSP_A:
 			if (inv == SND_SOC_DAIFMT_IB_IF)
-				spc |= (PCM_MODE1 << 4);
+				spc |= PCM_MODE1;
 			break;
 		default:
 			return -EINVAL;
diff --git a/sound/soc/codecs/cs42l73.h b/sound/soc/codecs/cs42l73.h
index 7c3bf7f..f30a4c4 100644
--- a/sound/soc/codecs/cs42l73.h
+++ b/sound/soc/codecs/cs42l73.h
@@ -162,16 +162,16 @@
 
 /* CS42L73_ASPC, CS42L73_XSPC, CS42L73_VSPC */
 #define	SP_3ST			(1 << 7)
-#define SPDIF_I2S		0
+#define SPDIF_I2S		(0 << 6)
 #define SPDIF_PCM		(1 << 6)
-#define PCM_MODE0		0
-#define PCM_MODE1		1
-#define PCM_MODE2		2
-#define PCM_BO_MSBLSB		0
-#define PCM_BO_LSBMSB		1
-#define MCK_SCLK_64FS		0
-#define MCK_SCLK_MCLK		2
-#define MCK_SCLK_PREMCLK	3
+#define PCM_MODE0		(0 << 4)
+#define PCM_MODE1		(1 << 4)
+#define PCM_MODE2		(2 << 4)
+#define PCM_MODE_MASK		(3 << 4)
+#define PCM_BIT_ORDER		(1 << 3)
+#define MCK_SCLK_64FS		(0 << 0)
+#define MCK_SCLK_MCLK		(2 << 0)
+#define MCK_SCLK_PREMCLK	(3 << 0)
 
 /* CS42L73_xSPMMCC */
 #define MS_MASTER		(1 << 7)
-- 
1.7.5.4
