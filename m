From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: add asoc_simple_parse_pin_switches()" to the asoc tree
Date: Fri, 26 Apr 2019 11:03:12 +0100 (BST)
Message-ID: <20190426100312.44169441D3C@finisterre.ee.mobilebroadband>
References: <20190426022550.31359-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190426022550.31359-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, od@zcrc.me
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: add asoc_simple_parse_pin_switches()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From 90194281ee8b01fc5a223a12ac90006ae98862c4 Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Fri, 26 Apr 2019 04:25:49 +0200
Subject: [PATCH] ASoC: simple-card-utils: add asoc_simple_parse_pin_switches()

This function is a helper that permits to create pin switch controls for
a list of widgets whose names are listed in the PREFIX "pin-switches"
devicetree property.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/simple_card_utils.h     |  2 +
 sound/soc/generic/simple-card-utils.c | 57 +++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/sound/simple_card_utils.h b/include/sound/simple_card_utils.h
index 67dc3ee6ed01..3429888347e7 100644
--- a/include/sound/simple_card_utils.h
+++ b/include/sound/simple_card_utils.h
@@ -133,6 +133,8 @@ int asoc_simple_parse_routing(struct snd_soc_card *card,
 				      char *prefix);
 int asoc_simple_parse_widgets(struct snd_soc_card *card,
 				      char *prefix);
+int asoc_simple_parse_pin_switches(struct snd_soc_card *card,
+				   char *prefix);
 
 int asoc_simple_init_jack(struct snd_soc_card *card,
 			       struct asoc_simple_jack *sjack,
diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index db1458a19985..f4c6375d11c7 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -430,6 +430,63 @@ int asoc_simple_parse_widgets(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(asoc_simple_parse_widgets);
 
+int asoc_simple_parse_pin_switches(struct snd_soc_card *card,
+				   char *prefix)
+{
+	const unsigned int nb_controls_max = 16;
+	const char **strings, *control_name;
+	struct snd_kcontrol_new *controls;
+	struct device *dev = card->dev;
+	unsigned int i, nb_controls;
+	char prop[128];
+	int ret;
+
+	if (!prefix)
+		prefix = "";
+
+	snprintf(prop, sizeof(prop), "%s%s", prefix, "pin-switches");
+
+	if (!of_property_read_bool(dev->of_node, prop))
+		return 0;
+
+	strings = devm_kcalloc(dev, nb_controls_max,
+			       sizeof(*strings), GFP_KERNEL);
+	if (!strings)
+		return -ENOMEM;
+
+	ret = of_property_read_string_array(dev->of_node, prop,
+					    strings, nb_controls_max);
+	if (ret < 0)
+		return ret;
+
+	nb_controls = (unsigned int)ret;
+
+	controls = devm_kcalloc(dev, nb_controls,
+				sizeof(*controls), GFP_KERNEL);
+	if (!controls)
+		return -ENOMEM;
+
+	for (i = 0; i < nb_controls; i++) {
+		control_name = devm_kasprintf(dev, GFP_KERNEL,
+					      "%s Switch", strings[i]);
+		if (!control_name)
+			return -ENOMEM;
+
+		controls[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+		controls[i].name = control_name;
+		controls[i].info = snd_soc_dapm_info_pin_switch;
+		controls[i].get = snd_soc_dapm_get_pin_switch;
+		controls[i].put = snd_soc_dapm_put_pin_switch;
+		controls[i].private_value = (unsigned long)strings[i];
+	}
+
+	card->controls = controls;
+	card->num_controls = nb_controls;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(asoc_simple_parse_pin_switches);
+
 int asoc_simple_init_jack(struct snd_soc_card *card,
 			  struct asoc_simple_jack *sjack,
 			  int is_hp, char *prefix)
-- 
2.20.1
