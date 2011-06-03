From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: Error out when FLL lock interrupt is
	not delivered on WM8915
Date: Fri,  3 Jun 2011 18:47:02 +0100
Message-ID: <1307123223-30847-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1307123223-30847-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C0A59103974
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 19:47:06 +0200 (CEST)
In-Reply-To: <1307123223-30847-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

When the FLL locks on the WM8915 an interrupt is generated.  For safety
error out if we don't get that interrupt when the IRQ output of the
WM8915 is hooked up.  Since we *really* expect an interrupt but the
threaded IRQ handler may take a bit longer than expected to get
scheduled also dramatically increase the delay in this case.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8915.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8915.c b/sound/soc/codecs/wm8915.c
index 6324d4e..62e72fc 100644
--- a/sound/soc/codecs/wm8915.c
+++ b/sound/soc/codecs/wm8915.c
@@ -2009,6 +2009,7 @@ static int wm8915_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 			  unsigned int Fref, unsigned int Fout)
 {
 	struct wm8915_priv *wm8915 = snd_soc_codec_get_drvdata(codec);
+	struct i2c_client *i2c = to_i2c_client(codec->dev);
 	struct _fll_div fll_div;
 	unsigned long timeout;
 	int ret, reg;
@@ -2094,7 +2095,18 @@ static int wm8915_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 	else
 		timeout = msecs_to_jiffies(2);
 
-	wait_for_completion_timeout(&wm8915->fll_lock, timeout);
+	/* Allow substantially longer if we've actually got the IRQ */
+	if (i2c->irq)
+		timeout *= 1000;
+
+	ret = wait_for_completion_timeout(&wm8915->fll_lock, timeout);
+
+	if (ret == 0 && i2c->irq) {
+		dev_err(codec->dev, "Timed out waiting for FLL\n");
+		ret = -ETIMEDOUT;
+	} else {
+		ret = 0;
+	}
 
 	dev_dbg(codec->dev, "FLL configured for %dHz->%dHz\n", Fref, Fout);
 
@@ -2102,7 +2114,7 @@ static int wm8915_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 	wm8915->fll_fout = Fout;
 	wm8915->fll_src = source;
 
-	return 0;
+	return ret;
 }
 
 #ifdef CONFIG_GPIOLIB
-- 
1.7.5.3
