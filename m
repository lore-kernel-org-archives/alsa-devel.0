From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 1/3] ASoC: support sample sizes properly in the
	WM8776 codec driver
Date: Tue, 13 Sep 2011 12:59:35 -0500
Message-ID: <1315936777-27994-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F9F3103A4F
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Sep 2011 19:59:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Use snd_pcm_format_width() to determine the sample size, instead of
checking specify sample formats and assuming that those are the only
valid format.

This change adds support for big-endian architectures (which use the _BE
formats) and the packed 24-bit format (SNDRV_PCM_FORMAT_S24_3xE).

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 sound/soc/codecs/wm8776.c |   25 +++++++++++++------------
 1 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wm8776.c b/sound/soc/codecs/wm8776.c
index 8e7953b..ad6f0fa 100644
--- a/sound/soc/codecs/wm8776.c
+++ b/sound/soc/codecs/wm8776.c
@@ -215,8 +215,6 @@ static int wm8776_hw_params(struct snd_pcm_substream *substream,
 	int ratio_shift, master;
 	int i;
 
-	iface = 0;
-
 	switch (dai->driver->id) {
 	case WM8776_DAI_DAC:
 		iface_reg = WM8776_DACIFCTRL;
@@ -232,20 +230,23 @@ static int wm8776_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
-
 	/* Set word length */
-	switch (params_format(params)) {
-	case SNDRV_PCM_FORMAT_S16_LE:
+	i = snd_pcm_format_width(params_format(params));
+	switch (i) {
+	case 16:
+		iface = 0;
+	case 20:
+		iface = 0x10;
 		break;
-	case SNDRV_PCM_FORMAT_S20_3LE:
-		iface |= 0x10;
+	case 24:
+		iface = 0x20;
 		break;
-	case SNDRV_PCM_FORMAT_S24_LE:
-		iface |= 0x20;
-		break;
-	case SNDRV_PCM_FORMAT_S32_LE:
-		iface |= 0x30;
+	case 32:
+		iface = 0x30;
 		break;
+	default:
+		dev_err(codec->dev, "Unsupported sample size: %i\n", i);
+		return -EINVAL;
 	}
 
 	/* Only need to set MCLK/LRCLK ratio if we're master */
-- 
1.7.3.4
