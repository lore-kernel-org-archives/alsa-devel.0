From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH v2] ASoC: da7219: Allow pdata to specify a VDDIO
Date: Sun, 22 Jul 2018 17:28:22 -0600
Message-ID: <20180722232822.34641-1-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f194.google.com (mail-io0-f194.google.com
 [209.85.223.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 06F7F26763A
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2018 01:28:27 +0200 (CEST)
Received: by mail-io0-f194.google.com with SMTP id w11-v6so8591705iob.2
 for <alsa-devel@alsa-project.org>; Sun, 22 Jul 2018 16:28:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>, Support Opensource <support.opensource@diasemi.com>, open list <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Akshu Agrawal <akshu.agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org

Some systems do not have software controllable regulators driving the
DA7219's supplies, nor can they use device tree to create "always-on fixed
regulators" to easily pretend like they do.

On these systems the call to devm_regulator_bulk_get() just creates
a set of dummy registers.  Calling regulator_get_voltage() on a dummy
regulator just returns -EINVAL, in which case the DA7219 is always set up
to use the default VDDIO voltage range of 2.5-3.6V.

Provide a new device property to let such systems specify a different
VDDIO if needed (e.g., 1.8V).

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
Changes for v2:
 - fix to use device_property_read_u32()

 include/sound/da7219.h    |  2 ++
 sound/soc/codecs/da7219.c | 19 +++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/sound/da7219.h b/include/sound/da7219.h
index 1bfcb16f2d10ab..16ab125ad4adbf 100644
--- a/include/sound/da7219.h
+++ b/include/sound/da7219.h
@@ -38,6 +38,8 @@ struct da7219_pdata {
 
 	const char *dai_clks_name;
 
+	u32 vddio;
+
 	/* Mic */
 	enum da7219_micbias_voltage micbias_lvl;
 	enum da7219_mic_amp_in_sel mic_amp_in_sel;
diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 980a6a8bf56d38..9893920b26f41f 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -1634,6 +1634,9 @@ static struct da7219_pdata *da7219_fw_to_pdata(struct snd_soc_component *compone
 	else
 		pdata->mic_amp_in_sel = DA7219_MIC_AMP_IN_SEL_DIFF;
 
+	if (device_property_read_u32(dev, "dlg,vddio", &of_val32) >= 0)
+		pdata->vddio = of_val32;
+
 	return pdata;
 }
 
@@ -1717,8 +1720,12 @@ static int da7219_handle_supplies(struct snd_soc_component *component)
 	/* Determine VDDIO voltage provided */
 	vddio = da7219->supplies[DA7219_SUPPLY_VDDIO].consumer;
 	ret = regulator_get_voltage(vddio);
+	/* If regulator_get_voltage() fails, try to use vddio from pdata. */
+	if (ret < 0 && da7219->pdata)
+		ret = da7219->pdata->vddio;
 	if (ret < 1200000)
-		dev_warn(component->dev, "Invalid VDDIO voltage\n");
+		dev_warn(component->dev, "Invalid VDDIO voltage: %d mV\n",
+			 ret);
 	else if (ret < 2800000)
 		io_voltage_lvl = DA7219_IO_VOLTAGE_LEVEL_1_2V_2_8V;
 
@@ -1872,6 +1879,11 @@ static int da7219_probe(struct snd_soc_component *component)
 	mutex_init(&da7219->ctrl_lock);
 	mutex_init(&da7219->pll_lock);
 
+	/* Handle DT/ACPI/Platform data */
+	da7219->pdata = dev_get_platdata(component->dev);
+	if (!da7219->pdata)
+		da7219->pdata = da7219_fw_to_pdata(component);
+
 	/* Regulator configuration */
 	ret = da7219_handle_supplies(component);
 	if (ret)
@@ -1897,11 +1909,6 @@ static int da7219_probe(struct snd_soc_component *component)
 		break;
 	}
 
-	/* Handle DT/ACPI/Platform data */
-	da7219->pdata = dev_get_platdata(component->dev);
-	if (!da7219->pdata)
-		da7219->pdata = da7219_fw_to_pdata(component);
-
 	da7219_handle_pdata(component);
 
 	/* Check if MCLK provided */
-- 
2.18.0.233.g985f88cf7e-goog
