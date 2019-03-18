From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Add support for active-high
	jack detect" to the asoc tree
Date: Mon, 18 Mar 2019 14:51:13 +0000 (GMT)
Message-ID: <20190318145113.DE9901128874@debutante.sirena.org.uk>
References: <20190305113900.8893-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4657157514713755555=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C3AAF89728
 for <alsa-devel@alsa-project.org>; Mon, 18 Mar 2019 15:51:15 +0100 (CET)
In-Reply-To: <20190305113900.8893-1-hdegoede@redhat.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

--===============4657157514713755555==
Content-Type: text/plain

The patch

   ASoC: rt5651: Add support for active-high jack detect

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

>From 8a68a509ae6b5d7d18c6bfc88553ca7761029ada Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 5 Mar 2019 12:38:59 +0100
Subject: [PATCH] ASoC: rt5651: Add support for active-high jack detect

Some boards use a jack-receptacle with a switch which reports the
jack-inserted status as active-high, rather then the standard active-low
reporting most jacks use.

This commit adds support for it. This is activated by a boolean
"realtek,jack-detect-not-inverted" device-property. The not-inverted
in the device-property name, rather then active-high, was chosen to keep
the device-property naming consistent with the rt5640 codec driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/rt5651.txt      |  5 ++
 sound/soc/codecs/rt5651.c                     | 47 ++++++++++++++++---
 sound/soc/codecs/rt5651.h                     |  1 +
 3 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5651.txt b/Documentation/devicetree/bindings/sound/rt5651.txt
index a41199a5cd79..56e736a1cba9 100644
--- a/Documentation/devicetree/bindings/sound/rt5651.txt
+++ b/Documentation/devicetree/bindings/sound/rt5651.txt
@@ -22,6 +22,11 @@ Optional properties:
   2: Use JD1_2 pin for jack-detect
   3: Use JD2 pin for jack-detect
 
+- realtek,jack-detect-not-inverted
+  bool. Normal jack-detect switches give an inverted (active-low) signal,
+  set this bool in the rare case you've a jack-detect switch which is not
+  inverted.
+
 - realtek,over-current-threshold-microamp
   u32, micbias over-current detection threshold in µA, valid values are
   600, 1500 and 2000µA.
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 29b2d60076b0..cb8252ff31cb 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1645,7 +1645,10 @@ static bool rt5651_jack_inserted(struct snd_soc_component *component)
 		break;
 	}
 
-	return val == 0;
+	if (rt5651->jd_active_high)
+		return val != 0;
+	else
+		return val == 0;
 }
 
 /* Jack detect and button-press timings */
@@ -1868,20 +1871,47 @@ static void rt5651_enable_jack_detect(struct snd_soc_component *component,
 	case RT5651_JD1_1:
 		snd_soc_component_update_bits(component, RT5651_JD_CTRL2,
 			RT5651_JD_TRG_SEL_MASK, RT5651_JD_TRG_SEL_JD1_1);
-		snd_soc_component_update_bits(component, RT5651_IRQ_CTRL1,
-			RT5651_JD1_1_IRQ_EN, RT5651_JD1_1_IRQ_EN);
+		/* active-low is normal, set inv flag for active-high */
+		if (rt5651->jd_active_high)
+			snd_soc_component_update_bits(component,
+				RT5651_IRQ_CTRL1,
+				RT5651_JD1_1_IRQ_EN | RT5651_JD1_1_INV,
+				RT5651_JD1_1_IRQ_EN | RT5651_JD1_1_INV);
+		else
+			snd_soc_component_update_bits(component,
+				RT5651_IRQ_CTRL1,
+				RT5651_JD1_1_IRQ_EN | RT5651_JD1_1_INV,
+				RT5651_JD1_1_IRQ_EN);
 		break;
 	case RT5651_JD1_2:
 		snd_soc_component_update_bits(component, RT5651_JD_CTRL2,
 			RT5651_JD_TRG_SEL_MASK, RT5651_JD_TRG_SEL_JD1_2);
-		snd_soc_component_update_bits(component, RT5651_IRQ_CTRL1,
-			RT5651_JD1_2_IRQ_EN, RT5651_JD1_2_IRQ_EN);
+		/* active-low is normal, set inv flag for active-high */
+		if (rt5651->jd_active_high)
+			snd_soc_component_update_bits(component,
+				RT5651_IRQ_CTRL1,
+				RT5651_JD1_2_IRQ_EN | RT5651_JD1_2_INV,
+				RT5651_JD1_2_IRQ_EN | RT5651_JD1_2_INV);
+		else
+			snd_soc_component_update_bits(component,
+				RT5651_IRQ_CTRL1,
+				RT5651_JD1_2_IRQ_EN | RT5651_JD1_2_INV,
+				RT5651_JD1_2_IRQ_EN);
 		break;
 	case RT5651_JD2:
 		snd_soc_component_update_bits(component, RT5651_JD_CTRL2,
 			RT5651_JD_TRG_SEL_MASK, RT5651_JD_TRG_SEL_JD2);
-		snd_soc_component_update_bits(component, RT5651_IRQ_CTRL1,
-			RT5651_JD2_IRQ_EN, RT5651_JD2_IRQ_EN);
+		/* active-low is normal, set inv flag for active-high */
+		if (rt5651->jd_active_high)
+			snd_soc_component_update_bits(component,
+				RT5651_IRQ_CTRL1,
+				RT5651_JD2_IRQ_EN | RT5651_JD2_INV,
+				RT5651_JD2_IRQ_EN | RT5651_JD2_INV);
+		else
+			snd_soc_component_update_bits(component,
+				RT5651_IRQ_CTRL1,
+				RT5651_JD2_IRQ_EN | RT5651_JD2_INV,
+				RT5651_JD2_IRQ_EN);
 		break;
 	default:
 		dev_err(component->dev, "Currently only JD1_1 / JD1_2 / JD2 are supported\n");
@@ -1986,6 +2016,9 @@ static void rt5651_apply_properties(struct snd_soc_component *component)
 				     "realtek,jack-detect-source", &val) == 0)
 		rt5651->jd_src = val;
 
+	if (device_property_read_bool(component->dev, "realtek,jack-detect-not-inverted"))
+		rt5651->jd_active_high = true;
+
 	/*
 	 * Testing on various boards has shown that good defaults for the OVCD
 	 * threshold and scale-factor are 2000µA and 0.75. For an effective
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
index 41fcb8b5eb40..05b0f6f8b95d 100644
--- a/sound/soc/codecs/rt5651.h
+++ b/sound/soc/codecs/rt5651.h
@@ -2083,6 +2083,7 @@ struct rt5651_priv {
 	int release_count;
 	int poll_count;
 	unsigned int jd_src;
+	bool jd_active_high;
 	unsigned int ovcd_th;
 	unsigned int ovcd_sf;
 
-- 
2.20.1


--===============4657157514713755555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4657157514713755555==--
