From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/2] ASoC: tlv320aic3x: Add support to shared
	common reset line
Date: Mon,  1 Nov 2010 14:03:56 +0200
Message-ID: <1288613036-13169-2-git-send-email-jhnikula@gmail.com>
References: <1288613036-13169-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F108103818
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 13:04:04 +0100 (CET)
Received: by mail-ey0-f179.google.com with SMTP id 24so2819914eyg.38
	for <alsa-devel@alsa-project.org>; Mon, 01 Nov 2010 05:04:04 -0700 (PDT)
In-Reply-To: <1288613036-13169-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

This is aimed to configurations where multiple aic3x codecs share the same
reset line and are powered from same supply voltages.

Currently aic3x_probe will fail if trying to request already requested
gpio_reset and passing -1 to another aic3x instances cause that those
instances cannot release reset in aic3x_set_power. That is, another
instances can work only if primary aic3x instance is powered and reset is
released.

Solve this by implementing a list of probed instances that is used for
checking if other instance shares the same gpio_reset number. If a shared
reset line exists, then only first instance tries to request and configure
it and the last instance releases it.

Runtime modifications are not needed since aic3x_regulator_event with help
of regulator framework takes already care that reset is pulled down only
when some or all supplies are disabled meaning that all instances using them
are idle.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |   28 +++++++++++++++++++++++++---
 1 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 157b534..684ca3a 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -61,6 +61,8 @@ static const char *aic3x_supply_names[AIC3X_NUM_SUPPLIES] = {
 	"DRVDD",	/* ADC Analog and Output Driver Voltage */
 };
 
+static LIST_HEAD(reset_list);
+
 struct aic3x_priv;
 
 struct aic3x_disable_nb {
@@ -77,6 +79,7 @@ struct aic3x_priv {
 	struct aic3x_setup_data *setup;
 	void *control_data;
 	unsigned int sysclk;
+	struct list_head list;
 	int master;
 	int gpio_reset;
 	int power;
@@ -1344,11 +1347,25 @@ static int aic3x_init(struct snd_soc_codec *codec)
 	return 0;
 }
 
+static bool aic3x_is_shared_reset(struct aic3x_priv *aic3x)
+{
+	struct aic3x_priv *a;
+
+	list_for_each_entry(a, &reset_list, list) {
+		if (gpio_is_valid(aic3x->gpio_reset) &&
+		    aic3x->gpio_reset == a->gpio_reset)
+			return true;
+	}
+
+	return false;
+}
+
 static int aic3x_probe(struct snd_soc_codec *codec)
 {
 	struct aic3x_priv *aic3x = snd_soc_codec_get_drvdata(codec);
 	int ret, i;
 
+	INIT_LIST_HEAD(&aic3x->list);
 	codec->control_data = aic3x->control_data;
 	aic3x->codec = codec;
 	codec->idle_bias_off = 1;
@@ -1359,7 +1376,8 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 		return ret;
 	}
 
-	if (gpio_is_valid(aic3x->gpio_reset)) {
+	if (gpio_is_valid(aic3x->gpio_reset) &&
+	    !aic3x_is_shared_reset(aic3x)) {
 		ret = gpio_request(aic3x->gpio_reset, "tlv320aic3x reset");
 		if (ret != 0)
 			goto err_gpio;
@@ -1405,6 +1423,7 @@ static int aic3x_probe(struct snd_soc_codec *codec)
 		snd_soc_add_controls(codec, &aic3x_classd_amp_gain_ctrl, 1);
 
 	aic3x_add_widgets(codec);
+	list_add(&aic3x->list, &reset_list);
 
 	return 0;
 
@@ -1414,7 +1433,8 @@ err_notif:
 					      &aic3x->disable_nb[i].nb);
 	regulator_bulk_free(ARRAY_SIZE(aic3x->supplies), aic3x->supplies);
 err_get:
-	if (gpio_is_valid(aic3x->gpio_reset))
+	if (gpio_is_valid(aic3x->gpio_reset) &&
+	    !aic3x_is_shared_reset(aic3x))
 		gpio_free(aic3x->gpio_reset);
 err_gpio:
 	kfree(aic3x);
@@ -1427,7 +1447,9 @@ static int aic3x_remove(struct snd_soc_codec *codec)
 	int i;
 
 	aic3x_set_bias_level(codec, SND_SOC_BIAS_OFF);
-	if (gpio_is_valid(aic3x->gpio_reset)) {
+	list_del(&aic3x->list);
+	if (gpio_is_valid(aic3x->gpio_reset) &&
+	    !aic3x_is_shared_reset(aic3x)) {
 		gpio_set_value(aic3x->gpio_reset, 0);
 		gpio_free(aic3x->gpio_reset);
 	}
-- 
1.7.2.3
