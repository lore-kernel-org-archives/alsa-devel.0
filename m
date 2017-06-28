From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: add inv_jd1_1 flag" to the asoc
	tree
Date: Wed, 28 Jun 2017 20:24:06 +0100
Message-ID: <E1dQIZK-0004Nk-9i@finisterre>
References: <20170628124939.11696-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4784726720D
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 21:24:16 +0200 (CEST)
In-Reply-To: <20170628124939.11696-4-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>, Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: add inv_jd1_1 flag

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

>From aea086dda2d5df659a7c5d9efe85721e9442a133 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Wed, 28 Jun 2017 14:49:38 +0200
Subject: [PATCH] ASoC: rt5645: add inv_jd1_1 flag

The flag will invert jd1_1 status. Which will be used if the jack
connector is normal closed.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/rt5645.h    | 2 ++
 sound/soc/codecs/rt5645.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/sound/rt5645.h b/include/sound/rt5645.h
index c427f10a39ae..d0c33a9972b9 100644
--- a/include/sound/rt5645.h
+++ b/include/sound/rt5645.h
@@ -23,6 +23,8 @@ struct rt5645_platform_data {
 	unsigned int jd_mode;
 	/* Use level triggered irq */
 	bool level_trigger_irq;
+	/* Invert JD1_1 status polarity */
+	bool inv_jd1_1;
 };
 
 #endif
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index e0c09bbd3f12..162044d82632 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3833,6 +3833,10 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		default:
 			break;
 		}
+		if (rt5645->pdata.inv_jd1_1) {
+			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
+				RT5645_JD_1_1_MASK, RT5645_JD_1_1_INV);
+		}
 	}
 
 	regmap_update_bits(rt5645->regmap, RT5645_ADDA_CLK1,
-- 
2.13.2
