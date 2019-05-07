From: Curtis Malainey <cujomalainey@chromium.org>
Subject: [PATCH] ASoC: rt5677: Add component driver name
Date: Tue,  7 May 2019 16:32:13 -0700
Message-ID: <20190507233213.53036-1-cujomalainey@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6DECF80726
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 01:33:11 +0200 (CEST)
Received: by mail-pg1-x542.google.com with SMTP id h17so3101911pgv.0
 for <alsa-devel@alsa-project.org>; Tue, 07 May 2019 16:33:10 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Curtis Malainey <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org

Add name to component driver so it is possible to lookup the component
when needed.

Signed-off-by: Curtis Malainey <cujomalainey@chromium.org>
---
 sound/soc/codecs/rt5677.c | 7 ++++---
 sound/soc/codecs/rt5677.h | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index 6fc70e441458..44071c7a4670 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4650,7 +4650,7 @@ static int rt5677_to_irq(struct gpio_chip *chip, unsigned offset)
 }
 
 static const struct gpio_chip rt5677_template_chip = {
-	.label			= "rt5677",
+	.label			= RT5677_DRV_NAME,
 	.owner			= THIS_MODULE,
 	.direction_output	= rt5677_gpio_direction_out,
 	.set			= rt5677_gpio_set,
@@ -4958,6 +4958,7 @@ static struct snd_soc_dai_driver rt5677_dai[] = {
 };
 
 static const struct snd_soc_component_driver soc_component_dev_rt5677 = {
+	.name			= RT5677_DRV_NAME,
 	.probe			= rt5677_probe,
 	.remove			= rt5677_remove,
 	.suspend		= rt5677_suspend,
@@ -5079,7 +5080,7 @@ static struct regmap_irq rt5677_irqs[] = {
 };
 
 static struct regmap_irq_chip rt5677_irq_chip = {
-	.name = "rt5677",
+	.name = RT5677_DRV_NAME,
 	.irqs = rt5677_irqs,
 	.num_irqs = ARRAY_SIZE(rt5677_irqs),
 
@@ -5267,7 +5268,7 @@ static int rt5677_i2c_remove(struct i2c_client *i2c)
 
 static struct i2c_driver rt5677_i2c_driver = {
 	.driver = {
-		.name = "rt5677",
+		.name = RT5677_DRV_NAME,
 		.of_match_table = rt5677_of_match,
 		.acpi_match_table = ACPI_PTR(rt5677_acpi_match),
 	},
diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index 183d92b03045..11a2ffceec3b 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -1674,6 +1674,8 @@
 #define RT5677_FIRMWARE1	"rt5677_dsp_fw1.bin"
 #define RT5677_FIRMWARE2	"rt5677_dsp_fw2.bin"
 
+#define RT5677_DRV_NAME		"rt5677"
+
 /* System Clock Source */
 enum {
 	RT5677_SCLK_S_MCLK,
-- 
2.21.0.1020.gf2820cf01a-goog
