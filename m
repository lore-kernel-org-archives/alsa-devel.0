From: Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 1/2] ASoC: simple-card-utils: add asoc_simple_parse_pin_switches()
Date: Fri, 26 Apr 2019 04:25:49 +0200
Message-ID: <20190426022550.31359-1-paul@crapouillou.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, od@zcrc.me, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
List-Id: alsa-devel@alsa-project.org

This function is a helper that permits to create pin switch controls for
a list of widgets whose names are listed in the PREFIX "pin-switches"
devicetree property.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: - Rebase on top of for-next
        - Rename to asoc_simple_parse_pin_switches()

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
2.21.0.593.g511ec345e18
