From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Add rt5651_apply_properties()
	helper function" to the asoc tree
Date: Thu, 01 Mar 2018 18:06:47 +0000
Message-ID: <E1erSbP-0005oz-Af@debutante>
References: <20180225104713.4745-6-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 73D4C267B35
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 19:07:01 +0100 (CET)
In-Reply-To: <20180225104713.4745-6-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: Add rt5651_apply_properties() helper function

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 5f293d4354f8aae3c8617f83a3cbd30047676b4d Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 25 Feb 2018 11:46:46 +0100
Subject: [PATCH] ASoC: rt5651: Add rt5651_apply_properties() helper function

Move the applying of the differential input and dmic properties to a new
rt5651_apply_properties() helper function. This new function can be called
by platform code which attaches properties after probe() has run to apply
these new properties.

Note this also moves the time when we apply these properties for DT
platforms from i2c-probe to snd-component-probe time, this should not
result in any functional difference.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 22 ++++++++++++++--------
 sound/soc/codecs/rt5651.h |  2 ++
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 030889143249..4d93248b6401 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1659,6 +1659,18 @@ static int rt5651_set_jack(struct snd_soc_component *component,
 	return 0;
 }
 
+void rt5651_apply_properties(struct snd_soc_component *component)
+{
+	if (device_property_read_bool(component->dev, "realtek,in2-differential"))
+		snd_soc_component_update_bits(component, RT5651_IN1_IN2,
+				RT5651_IN_DF2, RT5651_IN_DF2);
+
+	if (device_property_read_bool(component->dev, "realtek,dmic-en"))
+		snd_soc_component_update_bits(component, RT5651_GPIO_CTRL1,
+				RT5651_GP2_PIN_MASK, RT5651_GP2_PIN_DMIC1_SCL);
+}
+EXPORT_SYMBOL_GPL(rt5651_apply_properties);
+
 static int rt5651_probe(struct snd_soc_component *component)
 {
 	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
@@ -1677,6 +1689,8 @@ static int rt5651_probe(struct snd_soc_component *component)
 
 	snd_soc_component_force_bias_level(component, SND_SOC_BIAS_OFF);
 
+	rt5651_apply_properties(component);
+
 	return 0;
 }
 
@@ -1932,14 +1946,6 @@ static int rt5651_i2c_probe(struct i2c_client *i2c,
 	if (ret != 0)
 		dev_warn(&i2c->dev, "Failed to apply regmap patch: %d\n", ret);
 
-	if (device_property_read_bool(&i2c->dev, "realtek,in2-differential"))
-		regmap_update_bits(rt5651->regmap, RT5651_IN1_IN2,
-					RT5651_IN_DF2, RT5651_IN_DF2);
-
-	if (device_property_read_bool(&i2c->dev, "realtek,dmic-en"))
-		regmap_update_bits(rt5651->regmap, RT5651_GPIO_CTRL1,
-				RT5651_GP2_PIN_MASK, RT5651_GP2_PIN_DMIC1_SCL);
-
 	rt5651->irq = i2c->irq;
 	rt5651->hp_mute = 1;
 
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
index f3158488fc89..7d9d5fa09d6f 100644
--- a/sound/soc/codecs/rt5651.h
+++ b/sound/soc/codecs/rt5651.h
@@ -2080,4 +2080,6 @@ struct rt5651_priv {
 	bool hp_mute;
 };
 
+void rt5651_apply_properties(struct snd_soc_component *component);
+
 #endif /* __RT5651_H__ */
-- 
2.16.2
