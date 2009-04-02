From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: SoC pxa2xx-ac97 + wm9705 +
	touchscreen	suspend/resume
Date: Thu, 2 Apr 2009 15:53:30 +0100
Message-ID: <20090402145330.GA21646@sirena.org.uk>
References: <20090330223720.GC31396@n2100.arm.linux.org.uk>
	<20090331103048.GC11800@sirena.org.uk>
	<20090331183755.GA27451@n2100.arm.linux.org.uk>
	<20090401192710.GH21294@sirena.org.uk>
	<20090402121348.GC9522@n2100.arm.linux.org.uk>
	<20090402121803.GD4527@sirena.org.uk>
	<20090402123844.GD9522@n2100.arm.linux.org.uk>
	<20090402133124.GE9522@n2100.arm.linux.org.uk>
	<20090402141200.GH4527@sirena.org.uk>
	<20090402144017.GI9522@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 49000103859
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 16:53:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090402144017.GI9522@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, eric miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 02, 2009 at 03:40:17PM +0100, Russell King - ARM Linux wrote:

> It's actually worse though - using my devmem2 hack no longer restores
> things to a functional state.  devmem2 says the control register is
> now set as:

Gah, I see one problem with the patch I sent.  The one below *might* do
better if you have time to test it.  In any case, thanks a lot for your
help here - I'm fairly confident that the remaining problems you're
seeing are due to the lack of suspend and resume operations in the
WM9705 driver.

>From eeec4f57eb9d8f5f45d9536319e0eb130cc3ba28 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 2 Apr 2009 15:49:41 +0100
Subject: [PATCH] ASoC: Implement suspend and resume operations for WM9705

Compile tested only.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9705.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 3265817..2109b50 100644
--- a/sound/soc/codecs/wm9705.c
+++ b/sound/soc/codecs/wm9705.c
@@ -317,6 +317,41 @@ static int wm9705_reset(struct snd_soc_codec *codec)
 	return -EIO;
 }
 
+#ifdef CONFIG_PM
+static int wm9705_soc_suspend(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	soc_ac97_ops.write(codec->ac97, AC97_POWERDONW, 0xffff);
+
+	return 0;
+}
+
+static int wm9705_soc_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+	int i, ret;
+	u16 *cache = codec->reg_cache;
+
+	ret = wm9705_reset(codec);
+	if (ret < 0) {
+		printk(KERN_ERR "could not reset AC97 codec\n");
+		return ret;
+	}
+
+	for (i = 2; i < ARRAY_SIZE(wm9705_reg) << 1; i += 2) {
+		soc_ac97_ops.write(codec->ac97, i, cache[i>>1]);
+	}
+
+	return 0;
+}
+#else
+#define wm9705_soc_suspend NULL
+#define wm9705_soc_resume NULL
+#endif
+
 static int wm9705_soc_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
@@ -407,6 +442,8 @@ static int wm9705_soc_remove(struct platform_device *pdev)
 struct snd_soc_codec_device soc_codec_dev_wm9705 = {
 	.probe = 	wm9705_soc_probe,
 	.remove = 	wm9705_soc_remove,
+	.suspend =	wm9705_soc_suspend,
+	.resume =	wm9705_soc_resume,
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_wm9705);
 
-- 
1.6.2.1
