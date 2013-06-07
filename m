From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH] ASoC: WM8962: Set CLKREG_OVD if GP5_FN is not
	its reset value
Date: Fri, 7 Jun 2013 20:14:18 +0800
Message-ID: <1370607258-4750-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F06F2656EB
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 14:07:39 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

According to WM8962 datasheet, the GP5_FN bit of R516 (GPIO 5) depends on
the CLKREG_OVD bit of R8 (Clocking2):

"Note that GPIO5 functions are only supported when CLKREG_OVD=1. When
CLKREG_OVD=0, the contents of Register R516 must not be changed from
the default value."

So set CLKREG_OVD bit before regcache_sync() updates the GP5_FN bit to a
non-reset value.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/codecs/wm8962.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 26219ea..9c8fd11 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3739,6 +3739,23 @@ static int wm8962_i2c_remove(struct i2c_client *client)
 }
 
 #ifdef CONFIG_PM_RUNTIME
+static void wm8962_check_gp5_fn(struct snd_soc_codec *codec)
+{
+	int changed;
+
+	/*
+	 * If GP5_FN is not going to be the reset value 0x0,
+	 * need to set CLKREG_OVD bit of Register CLOCKING2
+	 * before regcache_sync() updates GP5_FN bit to a
+	 * non-reset value. The reset value should be 0x0.
+	 */
+	changed = snd_soc_test_bits(codec, WM8962_GPIO_5,
+			WM8962_GP5_FN_MASK, 0x0);
+	if (changed)
+		snd_soc_update_bits(codec, WM8962_CLOCKING2,
+				WM8962_CLKREG_OVD_MASK, WM8962_CLKREG_OVD);
+}
+
 static int wm8962_runtime_resume(struct device *dev)
 {
 	struct wm8962_priv *wm8962 = dev_get_drvdata(dev);
@@ -3756,6 +3773,8 @@ static int wm8962_runtime_resume(struct device *dev)
 
 	wm8962_reset(wm8962);
 
+	wm8962_check_gp5_fn(wm8962->codec);
+
 	regcache_sync(wm8962->regmap);
 
 	return 0;
-- 
1.7.1
