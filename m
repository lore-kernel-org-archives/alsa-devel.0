From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Allow specifying over-current
	threshold through a device-property" to the asoc tree
Date: Wed, 07 Mar 2018 14:14:27 +0000
Message-ID: <E1etZpr-0001SG-0E@debutante>
References: <20180304143610.21125-5-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 08046267048
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:14:32 +0100 (CET)
In-Reply-To: <20180304143610.21125-5-hdegoede@redhat.com>
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

   ASoC: rt5651: Allow specifying over-current threshold through a device-property

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

>From 583a9debd71e21a317b1fc7b293c22c49b33d9e4 Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 4 Mar 2018 15:35:52 +0100
Subject: [PATCH] ASoC: rt5651: Allow specifying over-current threshold through
 a device-property

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5651.c | 22 +++++++++++++++++++++-
 sound/soc/codecs/rt5651.h |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 50e1c501b6b9..7ff1bc892cfd 100644
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
2.16.2
