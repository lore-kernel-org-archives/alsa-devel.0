From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: SoC pxa2xx-ac97 + wm9705 +
	touchscreen	suspend/resume
Date: Thu, 2 Apr 2009 15:12:01 +0100
Message-ID: <20090402141200.GH4527@sirena.org.uk>
References: <20090330223720.GC31396@n2100.arm.linux.org.uk>
	<20090331103048.GC11800@sirena.org.uk>
	<20090331183755.GA27451@n2100.arm.linux.org.uk>
	<20090401192710.GH21294@sirena.org.uk>
	<20090402121348.GC9522@n2100.arm.linux.org.uk>
	<20090402121803.GD4527@sirena.org.uk>
	<20090402123844.GD9522@n2100.arm.linux.org.uk>
	<20090402133124.GE9522@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D992243CF
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 16:12:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090402133124.GE9522@n2100.arm.linux.org.uk>
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

On Thu, Apr 02, 2009 at 02:31:24PM +0100, Russell King - ARM Linux wrote:

> So, basically, we're starting to access the AC97 bus without first
> initializing the controller.  This can't work on _any_ PXA platform.

Ah, that explains it - yes, this just isn't going to do suspend/resume
as-is (but see the patch below).

> That happens in the probe just fine because one of the first actions
> that the core ALSA AC97 code does is to issue a cold reset - see
> sound/pci/ac97/ac97_codec.c:snd_ac97_mixer() where it calls the
> bus reset() method.

The core ALSA AC97 code shouldn't be getting involved for ASoC-specific
CODEC drivers.  An ASoC-specific driver should be doing whatever is
required to the CODEC directly - one of the reasons for having an
ASoC-specific driver is to allow more detailed management of the device
than can be supported within the standard ALSA AC97 framework.

ac97.c calls into the standard ALSA AC97 code to provide an adaption
layer which allows the generic AC97 support to be used with an ASoC AC97
controller driver for devices which don't need or want any additional
support.

> I now find that the board crashes inexplicably on suspend... because...
> Argh, Ian, what pile of mess have you created in wm9705?

> You do:

>         ret = snd_soc_new_ac97_codec(codec, &soc_ac97_ops, 0);

> which doesn't actually give us an AC97 codec device - it only kmallocs
> some memory for them.

That's what an ASoC AC97 driver should do - it is responsible for
bringing up the link by issuing a reset operation (which the wm9705
driver is doing) and doing any other setup required.  The ASoC core will
then go and register the AC97 bus device for child devices like the 

> Okay, I'm going to shelve this project for at least the next three
> months now, and will return to it when (and if) the ASoC codec
> situation improves.

Before doing that could you please try the patch below to wm9705.c
implementing suspend and resume operations?  It's completely
speculative, I don't have a WM9705 test system to hand but I'm
moderately confident

>From e904fe0f0653ba66c20faa97034b99ee87602cff Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 2 Apr 2009 15:05:55 +0100
Subject: [PATCH] ASoC: Implement suspend and resume operations for WM9705

Compile tested only.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9705.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm9705.c b/sound/soc/codecs/wm9705.c
index 3265817..0564476 100644
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
+	ac97_write(codec, AC97_POWERDOWN, 0xffff);
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
