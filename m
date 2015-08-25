From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Modify the jack detection
	function to prevent the pop sound while the jack plug in" to
	the asoc tree
Date: Tue, 25 Aug 2015 19:13:10 +0100
Message-ID: <E1ZUIic-0006CI-R7@debutante>
References: <1440419579-9970-3-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B0992651DC
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 20:13:21 +0200 (CEST)
In-Reply-To: <1440419579-9970-3-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Modify the jack detection function to prevent the pop sound while the jack plug in

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 8db7f56ddf2c4571e33756b70a1a8f492c050449 Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Mon, 24 Aug 2015 20:32:57 +0800
Subject: [PATCH] ASoC: rt5645: Modify the jack detection function to prevent
 the pop sound while the jack plug in

The patch corrects the sequence of the jack detection. It will prevent the
pop sound while the jack plug in.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index ac2f42f4e3a0..bcb44de002c9 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2805,14 +2805,15 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 		}
 
 		regmap_write(rt5645->regmap, RT5645_JD_CTRL3, 0x00f0);
-		regmap_write(rt5645->regmap, RT5645_IN1_CTRL1, 0x0006);
 		regmap_update_bits(rt5645->regmap,
 				   RT5645_IN1_CTRL2, 0x1000, 0x1000);
+		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1, 0x0004,
+			0x0004);
 		msleep(100);
 		regmap_update_bits(rt5645->regmap,
 				   RT5645_IN1_CTRL2, 0x1000, 0x0000);
 
-		msleep(450);
+		msleep(600);
 		regmap_read(rt5645->regmap, RT5645_IN1_CTRL3, &val);
 		val &= 0x7;
 		dev_dbg(codec->dev, "val = %d\n", val);
@@ -2828,9 +2829,17 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 			rt5645->jack_type = SND_JACK_HEADPHONE;
 		}
 
+		snd_soc_update_bits(codec, RT5645_CHARGE_PUMP, 0x0300, 0x0200);
+		snd_soc_write(codec, RT5645_DEPOP_M1, 0x001d);
+		snd_soc_write(codec, RT5645_DEPOP_M1, 0x0001);
 	} else { /* jack out */
 		rt5645->jack_type = 0;
 
+		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL2, 0x1000,
+			0x1000);
+		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL1, 0x0004,
+			0x0000);
+
 		if (rt5645->en_button_func)
 			rt5645_enable_push_button_irq(codec, false);
 
-- 
2.5.0
