From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Enable LDO and micbias1
	supplies for jack-type detection" to the asoc tree
Date: Thu, 01 Mar 2018 19:25:55 +0000
Message-ID: <E1erTpz-0001T0-EI@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 041EB267190
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 20:25:58 +0100 (CET)
In-Reply-To: 
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5651: Enable LDO and micbias1 supplies for jack-type detection

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

>From 1310e737a68741c9b06cf63be0084bae6018b308 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 25 Feb 2018 11:46:55 +0100
Subject: [PATCH] ASoC: rt5651: Enable LDO and micbias1 supplies for jack-type
 detection

To determine if a plugged in jack is a headset (speakers + mic) or
headphones (mic contact shorted to ground) we use the micbias1 OVer Current
Detect (OVCD) functionality.

For this to work we need to have a micbias current to actually cause an
overcurrent condition when headphones are plugged in, so jack-type
detection requires both the LDO and micbias1 supplies to be on.

Before this commit there were 2 issues with the handling of this:
1) The LDO supply was force-enabled twice and never disabled again even
though it only needs to be forced on when doing jack-type detection
2) micbias1 was not force-enabled, and thus may be off when doing jack-type
detection

This commit fixes both by force-enabling the LDO and micbias1 supplies
before checking for an overcurrent condition and disabling them afterwards.

Note that both supplies will still get turned on normally (and OVCD will
protect against overcurrent) when the micbias1 is enabled normally because
the user has activated a sound stream recording from the mic.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index cbf9f56ecb14..be942886700d 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1561,6 +1561,28 @@ static int rt5651_set_bias_level(struct snd_soc_component *component,
 	return 0;
 }
 
+static void rt5651_enable_micbias1_for_ovcd(struct snd_soc_component *component)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+
+	snd_soc_dapm_mutex_lock(dapm);
+	snd_soc_dapm_force_enable_pin_unlocked(dapm, "LDO");
+	snd_soc_dapm_force_enable_pin_unlocked(dapm, "micbias1");
+	snd_soc_dapm_sync_unlocked(dapm);
+	snd_soc_dapm_mutex_unlock(dapm);
+}
+
+static void rt5651_disable_micbias1_for_ovcd(struct snd_soc_component *component)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+
+	snd_soc_dapm_mutex_lock(dapm);
+	snd_soc_dapm_disable_pin_unlocked(dapm, "micbias1");
+	snd_soc_dapm_disable_pin_unlocked(dapm, "LDO");
+	snd_soc_dapm_sync_unlocked(dapm);
+	snd_soc_dapm_mutex_unlock(dapm);
+}
+
 static irqreturn_t rt5651_irq(int irq, void *data)
 {
 	struct rt5651_priv *rt5651 = data;
@@ -1574,7 +1596,6 @@ static irqreturn_t rt5651_irq(int irq, void *data)
 static int rt5651_set_jack(struct snd_soc_component *component,
 			   struct snd_soc_jack *hp_jack, void *data)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	struct rt5651_priv *rt5651 = snd_soc_component_get_drvdata(component);
 	int ret;
 
@@ -1616,9 +1637,6 @@ static int rt5651_set_jack(struct snd_soc_component *component,
 	snd_soc_component_update_bits(component, RT5651_PWR_ANLG2,
 		RT5651_PWR_JD_M, RT5651_PWR_JD_M);
 
-	snd_soc_dapm_force_enable_pin(dapm, "LDO");
-	snd_soc_dapm_sync(dapm);
-
 	snd_soc_component_update_bits(component, RT5651_MICBIAS, 0x38, 0x38);
 
 	rt5651->hp_jack = hp_jack;
@@ -1819,13 +1837,10 @@ static const struct dmi_system_id rt5651_quirk_table[] = {
 
 static int rt5651_jack_detect(struct snd_soc_component *component, int jack_insert)
 {
-	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	int jack_type;
 
 	if (jack_insert) {
-		snd_soc_dapm_force_enable_pin(dapm, "LDO");
-		snd_soc_dapm_sync(dapm);
-
+		rt5651_enable_micbias1_for_ovcd(component);
 		snd_soc_component_update_bits(component, RT5651_MICBIAS,
 				    RT5651_MIC1_OVCD_MASK |
 				    RT5651_MIC1_OVTH_MASK |
@@ -1842,6 +1857,7 @@ static int rt5651_jack_detect(struct snd_soc_component *component, int jack_inse
 			jack_type = SND_JACK_HEADSET;
 		snd_soc_component_update_bits(component, RT5651_IRQ_CTRL2,
 				    RT5651_MB1_OC_CLR, 0);
+		rt5651_disable_micbias1_for_ovcd(component);
 	} else { /* jack out */
 		jack_type = 0;
 
-- 
2.16.2
