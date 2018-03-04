From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 04/22] ASoC: rt5651: Allow specifying
	over-current threshold through a device-property
Date: Sun,  4 Mar 2018 15:35:52 +0100
Message-ID: <20180304143610.21125-5-hdegoede@redhat.com>
References: <20180304143610.21125-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id BEDB72670F9
 for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2018 15:36:19 +0100 (CET)
In-Reply-To: <20180304143610.21125-1-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

OVer-Current-Detection (OVCD) for the micbias current is used to detect
if an inserted jack is a headset or headphones (mic shorted to ground).

Some boards may need different values for the OVCD current threshold
because of a resistor on the board in serial with or parallel to the
jack mic contact.

This commit adds support for configuring the OCVD current threshold
through the "realtek,over-current-threshold-microamp" device-property.

Note this commit changes the default value from 600uA to 2000uA,
because testing has shown 600uA to be a poor default.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
-Split out the dt-bindings documentation for the new properties into a
 separate patch
-Append "-microamp to the device-property name
-Split out seeting of OCVD scale-factor into a separate patch, keeping
 only OVCD current threshold configuration in this patch
---
 sound/soc/codecs/rt5651.c | 22 +++++++++++++++++++++-
 sound/soc/codecs/rt5651.h |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index f80b3da4667f..19f7c89d1e7a 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1638,7 +1638,7 @@ static int rt5651_set_jack(struct snd_soc_component *component,
 				      RT5651_PWR_CLK12M_MASK |
 				      RT5651_PWR_MB_MASK,
 				      RT5651_MIC1_OVCD_EN |
-				      RT5651_MIC1_OVTH_600UA |
+				      rt5651->ovcd_th |
 				      RT5651_PWR_MB_PU |
 				      RT5651_PWR_CLK12M_PU);
 
@@ -1684,6 +1684,26 @@ static void rt5651_apply_properties(struct snd_soc_component *component)
 	if (device_property_read_u32(component->dev,
 				     "realtek,jack-detect-source", &val) == 0)
 		rt5651->jd_src = val;
+
+	rt5651->ovcd_th = RT5651_MIC1_OVTH_2000UA;
+
+	if (device_property_read_u32(component->dev,
+			"realtek,over-current-threshold-microamp", &val) == 0) {
+		switch (val) {
+		case 600:
+			rt5651->ovcd_th = RT5651_MIC1_OVTH_600UA;
+			break;
+		case 1500:
+			rt5651->ovcd_th = RT5651_MIC1_OVTH_1500UA;
+			break;
+		case 2000:
+			rt5651->ovcd_th = RT5651_MIC1_OVTH_2000UA;
+			break;
+		default:
+			dev_warn(component->dev, "Warning: Invalid over-current-threshold-microamp value: %d, defaulting to 2000uA\n",
+				 val);
+		}
+	}
 }
 
 static int rt5651_probe(struct snd_soc_component *component)
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
index f3158488fc89..9cd5c279d0d6 100644
--- a/sound/soc/codecs/rt5651.h
+++ b/sound/soc/codecs/rt5651.h
@@ -2064,6 +2064,7 @@ struct rt5651_priv {
 	struct snd_soc_jack *hp_jack;
 	struct delayed_work jack_detect_work;
 	enum rt5651_jd_src jd_src;
+	unsigned int ovcd_th;
 
 	int irq;
 	int sysclk;
-- 
2.14.3
