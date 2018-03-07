From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Make rt5651_apply_properties()
	private" to the asoc tree
Date: Wed, 07 Mar 2018 14:14:56 +0000
Message-ID: <E1etZqK-0001Vs-5X@debutante>
References: <20180304143610.21125-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 49E41267339
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:15:01 +0100 (CET)
In-Reply-To: <20180304143610.21125-2-hdegoede@redhat.com>
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

   ASoC: rt5651: Make rt5651_apply_properties() private

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

>From 1cf5b50426136fe54380a7dd1ca7eb49973cae5a Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 4 Mar 2018 15:35:49 +0100
Subject: [PATCH] ASoC: rt5651: Make rt5651_apply_properties() private

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 14 ++++++++++++--
 sound/soc/codecs/rt5651.h |  2 --
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 55bcc74e344f..767a05e009df 100644
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
@@ -1893,6 +1899,10 @@ static void rt5651_jack_detect_work(struct work_struct *work)
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
2.16.2
