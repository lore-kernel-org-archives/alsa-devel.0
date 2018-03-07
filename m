From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Enable sticky mode for OVCD" to
	the asoc tree
Date: Wed, 07 Mar 2018 14:14:03 +0000
Message-ID: <E1etZpT-0001Pu-AE@debutante>
References: <20180225104713.4745-19-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 591E42673D6
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:14:09 +0100 (CET)
In-Reply-To: <20180225104713.4745-19-hdegoede@redhat.com>
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

   ASoC: rt5651: Enable sticky mode for OVCD

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

>From 1b1ad83539a701a6bdcb25dc9160386e71f6016e Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 4 Mar 2018 15:35:54 +0100
Subject: [PATCH] ASoC: rt5651: Enable sticky mode for OVCD

When the mic-gnd contacts are short-circuited by a headphones plug, the
hardware periodically retries if it can apply the bias-current leading to
the OVCD status flip-flopping 1-0-1 with it being 0 about 10% of the time.
This commit enables the sticky bit for the OVCD status to deal with this.

This commit also introduces 2 helper functions to deal with the OVCD
status bit, this may seem a bit overkill now, but these will also be
used in future patches.

Tested-by: Carlo Caione <carlo@endlessm.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 486817809b7b..62918f7e8270 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1578,6 +1578,22 @@ static void rt5651_disable_micbias1_for_ovcd(struct snd_soc_component *component
 	snd_soc_dapm_mutex_unlock(dapm);
 }
 
+static void rt5651_clear_micbias1_ovcd(struct snd_soc_component *component)
+{
+	snd_soc_component_update_bits(component, RT5651_IRQ_CTRL2,
+		RT5651_MB1_OC_CLR, 0);
+}
+
+static bool rt5651_micbias1_ovcd(struct snd_soc_component *component)
+{
+	int val;
+
+	val = snd_soc_component_read32(component, RT5651_IRQ_CTRL2);
+	dev_dbg(component->dev, "irq ctrl2 %#04x\n", val);
+
+	return (val & RT5651_MB1_OC_CLR);
+}
+
 static irqreturn_t rt5651_irq(int irq, void *data)
 {
 	struct rt5651_priv *rt5651 = data;
@@ -1646,6 +1662,18 @@ static int rt5651_set_jack(struct snd_soc_component *component,
 				      RT5651_PWR_MB_PU |
 				      RT5651_PWR_CLK12M_PU);
 
+	/*
+	 * The over-current-detect is only reliable in detecting the absence
+	 * of over-current, when the mic-contact in the jack is short-circuited,
+	 * the hardware periodically retries if it can apply the bias-current
+	 * leading to the ovcd status flip-flopping 1-0-1 with it being 0 about
+	 * 10% of the time, as we poll the ovcd status bit we might hit that
+	 * 10%, so we enable sticky mode and when checking OVCD we clear the
+	 * status, msleep() a bit and then check to get a reliable reading.
+	 */
+	snd_soc_component_update_bits(component, RT5651_IRQ_CTRL2,
+		RT5651_MB1_OC_STKY_MASK, RT5651_MB1_OC_STKY_EN);
+
 	rt5651->hp_jack = hp_jack;
 
 	ret = devm_request_threaded_irq(component->dev, rt5651->irq, NULL,
@@ -1878,13 +1906,12 @@ static int rt5651_jack_detect(struct snd_soc_component *component, int jack_inse
 
 	if (jack_insert) {
 		rt5651_enable_micbias1_for_ovcd(component);
+		rt5651_clear_micbias1_ovcd(component);
 		msleep(100);
-		if (snd_soc_component_read32(component, RT5651_IRQ_CTRL2) & RT5651_MB1_OC_CLR)
+		if (rt5651_micbias1_ovcd(component))
 			jack_type = SND_JACK_HEADPHONE;
 		else
 			jack_type = SND_JACK_HEADSET;
-		snd_soc_component_update_bits(component, RT5651_IRQ_CTRL2,
-				    RT5651_MB1_OC_CLR, 0);
 		rt5651_disable_micbias1_for_ovcd(component);
 	} else { /* jack out */
 		jack_type = 0;
-- 
2.16.2
