From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Remove incorrect settings" to
	the asoc tree
Date: Mon, 14 Sep 2015 19:54:03 +0100
Message-ID: <E1ZbYt9-0002De-9w@finisterre>
References: <1441863617-15145-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 394F82605FF
 for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2015 20:54:11 +0200 (CEST)
In-Reply-To: <1441863617-15145-1-git-send-email-oder_chiou@realtek.com>
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

   ASoC: rt5645: Remove incorrect settings

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

>From f17b329b73a0393dc9d5fc5b4457189f92e5bbef Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Thu, 10 Sep 2015 13:40:16 +0800
Subject: [PATCH] ASoC: rt5645: Remove incorrect settings

The patch removes the incorrect settings to avoid the pop sound in the
first playback with headphone after boot.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 4972bf3..595ace9 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2829,10 +2829,6 @@ static int rt5645_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 			snd_soc_dapm_sync(dapm);
 			rt5645->jack_type = SND_JACK_HEADPHONE;
 		}
-
-		snd_soc_update_bits(codec, RT5645_CHARGE_PUMP, 0x0300, 0x0200);
-		snd_soc_write(codec, RT5645_DEPOP_M1, 0x001d);
-		snd_soc_write(codec, RT5645_DEPOP_M1, 0x0001);
 	} else { /* jack out */
 		rt5645->jack_type = 0;
 
@@ -2880,8 +2876,6 @@ int rt5645_set_jack_detect(struct snd_soc_codec *codec,
 		rt5645->en_button_func = true;
 		regmap_update_bits(rt5645->regmap, RT5645_GPIO_CTRL1,
 				RT5645_GP1_PIN_IRQ, RT5645_GP1_PIN_IRQ);
-		regmap_update_bits(rt5645->regmap, RT5645_DEPOP_M1,
-				RT5645_HP_CB_MASK, RT5645_HP_CB_PU);
 		regmap_update_bits(rt5645->regmap, RT5645_GEN_CTRL1,
 				RT5645_DIG_GATE_CTRL, RT5645_DIG_GATE_CTRL);
 	}
-- 
2.5.0
