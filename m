From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Disable register synchronisation for low
	frequency WM8996 SYSCLK
Date: Thu, 19 Jan 2012 12:00:24 +0000
Message-ID: <1326974424-29233-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 96B54103BF4
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 13:00:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

With a low frequency SYSCLK and a fast I2C clock register synchronisation
may occasionally take too long to take effect, causing I/O issues. Disable
synchronisation in order to avoid any issues.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |    4 ++++
 sound/soc/codecs/wm8996.h |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 691ae4e..8e8f8d1 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2007,6 +2007,7 @@ static int wm8996_set_sysclk(struct snd_soc_dai *dai,
 	struct wm8996_priv *wm8996 = snd_soc_codec_get_drvdata(codec);
 	int lfclk = 0;
 	int ratediv = 0;
+	int sync = WM8996_REG_SYNC;
 	int src;
 	int old;
 
@@ -2051,6 +2052,7 @@ static int wm8996_set_sysclk(struct snd_soc_dai *dai,
 	case 32000:
 	case 32768:
 		lfclk = WM8996_LFCLK_ENA;
+		sync = 0;
 		break;
 	default:
 		dev_warn(codec->dev, "Unsupported clock rate %dHz\n",
@@ -2064,6 +2066,8 @@ static int wm8996_set_sysclk(struct snd_soc_dai *dai,
 			    WM8996_SYSCLK_SRC_MASK | WM8996_SYSCLK_DIV_MASK,
 			    src << WM8996_SYSCLK_SRC_SHIFT | ratediv);
 	snd_soc_update_bits(codec, WM8996_CLOCKING_1, WM8996_LFCLK_ENA, lfclk);
+	snd_soc_update_bits(codec, WM8996_CONTROL_INTERFACE_1,
+			    WM8996_REG_SYNC, sync);
 	snd_soc_update_bits(codec, WM8996_AIF_CLOCKING_1,
 			    WM8996_SYSCLK_ENA, old);
 
diff --git a/sound/soc/codecs/wm8996.h b/sound/soc/codecs/wm8996.h
index 0fde643..de9ac3e 100644
--- a/sound/soc/codecs/wm8996.h
+++ b/sound/soc/codecs/wm8996.h
@@ -1567,6 +1567,10 @@ int wm8996_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack,
 /*
  * R257 (0x101) - Control Interface (1)
  */
+#define WM8996_REG_SYNC                         0x8000  /* REG_SYNC */
+#define WM8996_REG_SYNC_MASK                    0x8000  /* REG_SYNC */
+#define WM8996_REG_SYNC_SHIFT                       15  /* REG_SYNC */
+#define WM8996_REG_SYNC_WIDTH                        1  /* REG_SYNC */
 #define WM8996_AUTO_INC                         0x0004  /* AUTO_INC */
 #define WM8996_AUTO_INC_MASK                    0x0004  /* AUTO_INC */
 #define WM8996_AUTO_INC_SHIFT                        2  /* AUTO_INC */
-- 
1.7.7.3
