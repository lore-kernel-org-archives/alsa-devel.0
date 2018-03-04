From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 01/22] ASoC: rt5651: Make
	rt5651_apply_properties() private
Date: Sun,  4 Mar 2018 15:35:49 +0100
Message-ID: <20180304143610.21125-2-hdegoede@redhat.com>
References: <20180304143610.21125-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 by alsa0.perex.cz (Postfix) with ESMTP id A016D267063
 for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2018 15:36:15 +0100 (CET)
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

The idea behind exporting rt5651_apply_properties(), was for it to be used
on platforms where the platform code may need to add device-properties,
rather then relying only on properties set by the firmware. The platform
code could then call rt5651_apply_properties() after adding properties to
make sure that the codec driver was aware of the new properties.

But this is not necessary, as long as we do all property parsing from
the codec component-driver's probe function (or later) then the machine
driver can attach properties before calling snd_soc_register_card and
calling rt5651_apply_properties() for ordering reasons is not necessary.

This commit makes rt5651_apply_properties() private and adds 2 comments
documenting that all property parsing must be done from the codec
component-driver's probe function.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
-This is a new patch in v3 of this patch-set
---
 sound/soc/codecs/rt5651.c | 14 ++++++++++++--
 sound/soc/codecs/rt5651.h |  2 --
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 5ea5233e1b7b..7bff5cda61fd 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1666,7 +1666,14 @@ static int rt5651_set_jack(struct snd_soc_component *component,
 	return 0;
 }
 
-void rt5651_apply_properties(struct snd_soc_component *component)
+/*
+ * Note on some platforms the platform code may need to add device-properties,
+ * rather then relying only on properties set by the firmware. Therefor the
+ * property parsing MUST be done from the component driver's probe function,
+ * rather then from the i2c driver's probe function, so that the platform-code
+ * can attach extra properties before calling snd_soc_register_card().
+ */
+static void rt5651_apply_properties(struct snd_soc_component *component)
 {
 	if (device_property_read_bool(component->dev, "realtek,in2-differential"))
 		snd_soc_component_update_bits(component, RT5651_IN1_IN2,
@@ -1676,7 +1683,6 @@ void rt5651_apply_properties(struct snd_soc_component *component)
 		snd_soc_component_update_bits(component, RT5651_GPIO_CTRL1,
 				RT5651_GP2_PIN_MASK, RT5651_GP2_PIN_DMIC1_SCL);
 }
-EXPORT_SYMBOL_GPL(rt5651_apply_properties);
 
 static int rt5651_probe(struct snd_soc_component *component)
 {
@@ -1894,6 +1900,10 @@ static void rt5651_jack_detect_work(struct work_struct *work)
 	snd_soc_jack_report(rt5651->hp_jack, report, SND_JACK_HEADSET);
 }
 
+/*
+ * Note this function MUST not look at device-properties, see the comment
+ * above rt5651_apply_properties().
+ */
 static int rt5651_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
index 7d9d5fa09d6f..f3158488fc89 100644
--- a/sound/soc/codecs/rt5651.h
+++ b/sound/soc/codecs/rt5651.h
@@ -2080,6 +2080,4 @@ struct rt5651_priv {
 	bool hp_mute;
 };
 
-void rt5651_apply_properties(struct snd_soc_component *component);
-
 #endif /* __RT5651_H__ */
-- 
2.14.3
