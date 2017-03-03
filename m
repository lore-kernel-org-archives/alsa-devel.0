From: Ryan Lee <ryans.lee@maximintegrated.com>
Subject: [PATCH 09/10] Added ACPI support. Changed
	snd_kcontrol_chip to snd_soc_kcontrol_codec
Date: Fri, 3 Mar 2017 23:52:47 +0900
Message-ID: <1488552768-14901-10-git-send-email-ryans.lee@maximintegrated.com>
References: <1488552768-14901-1-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0126.outbound.protection.outlook.com [104.47.32.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 03FEE266B6D
 for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2017 15:54:37 +0100 (CET)
In-Reply-To: <1488552768-14901-1-git-send-email-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, perex@perex.cz, tiwai@suse.com, arnd@arndb.de, michael@amarulasolutions.com, oder_chiou@realtek.com, yesanishhere@gmail.com, jacob@teenage.engineering, Damien.Horsley@imgtec.com, bardliao@realtek.com, kuninori.morimoto.gx@renesas.com, petr@barix.com, lars@metafoo.de, nh6z@nh6z.net, ryans.lee@maximintegrated.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
---
snd_kcontrol_chip was changed to snd_soc_kcontrol_codec.
acpi_match_table was added.

 sound/soc/codecs/max98927.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 6eb745bd..0614936 100755
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -10,7 +10,7 @@
  *  option) any later version.
  */
 
-#include <linux/delay.h>
+#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
@@ -144,7 +144,7 @@ static int max98927_reg_get(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol, unsigned int reg,
 	unsigned int mask, unsigned int shift)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
 	int data;
 
@@ -157,7 +157,7 @@ static int max98927_reg_put(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol, unsigned int reg,
 	unsigned int mask, unsigned int shift)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
 	unsigned int sel = ucontrol->value.integer.value[0];
 
@@ -473,7 +473,7 @@ static DECLARE_TLV_DB_SCALE(max98927_digital_tlv, -1600, 25, 0);
 static int max98927_spk_gain_get(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.integer.value[0] = max98927->spk_gain;
@@ -485,7 +485,7 @@ static int max98927_spk_gain_get(struct snd_kcontrol *kcontrol,
 static int max98927_spk_gain_put(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
 	unsigned int sel = ucontrol->value.integer.value[0];
 
@@ -503,7 +503,7 @@ static int max98927_spk_gain_put(struct snd_kcontrol *kcontrol,
 static int max98927_digital_gain_get(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
 
 	ucontrol->value.integer.value[0] = max98927->digital_gain;
@@ -515,7 +515,7 @@ static int max98927_digital_gain_get(struct snd_kcontrol *kcontrol,
 static int max98927_digital_gain_put(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct max98927_priv *max98927 = snd_soc_codec_get_drvdata(codec);
 	unsigned int sel = ucontrol->value.integer.value[0];
 
@@ -1002,17 +1002,27 @@ static const struct i2c_device_id max98927_i2c_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, max98927_i2c_id);
 
+#if defined(CONFIG_OF)
 static const struct of_device_id max98927_of_match[] = {
 	{ .compatible = "maxim,max98927", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, max98927_of_match);
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id max98927_acpi_match[] = {
+	{ "MX98927", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, max98927_acpi_match);
+#endif
 
 static struct i2c_driver max98927_i2c_driver = {
 	.driver = {
 		.name = "max98927",
-		.owner = THIS_MODULE,
 		.of_match_table = of_match_ptr(max98927_of_match),
+		.acpi_match_table = ACPI_PTR(max98927_acpi_match),
 		.pm = NULL,
 	},
 	.probe  = max98927_i2c_probe,
-- 
2.7.4
