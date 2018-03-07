From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5651: Allow specifying the OVCD
	scale-factor through a device-property" to the asoc tree
Date: Wed, 07 Mar 2018 14:14:07 +0000
Message-ID: <E1etZpX-0001Qy-6c@debutante>
References: <20180304143610.21125-6-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1737221003849420499=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8423B267048
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 15:14:12 +0100 (CET)
In-Reply-To: <20180304143610.21125-6-hdegoede@redhat.com>
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

--===============1737221003849420499==
Content-Type: text/plain

The patch

   ASoC: rt5651: Allow specifying the OVCD scale-factor through a device-property

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

>From e6eb0207597afa1cdd4914a17a727b101cc859ff Mon Sep 17 00:00:00 2001
From: Hans de Goede <hdegoede@redhat.com>
Date: Sun, 4 Mar 2018 15:35:53 +0100
Subject: [PATCH] ASoC: rt5651: Allow specifying the OVCD scale-factor through
 a device-property

OVer-Current-Detection (OVCD) for the micbias current is used to detect if
an inserted jack is a headset or headphones (mic shorted to ground).

The threshold for at which current the OVCD triggers on the rt5651 is not
only controlled by setting the absolute current limit, but also by setting
a scale factor which applies to the limit. Testing has shown that we need
to set both (depending on the board).

This commit adds support for the sofar unused OVCD scale-factor register
and adds support for specifying non-default values for it through the
"realtek,over-current-scale-factor" device-property.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/rt5651.h    | 11 +++++++++++
 sound/soc/codecs/rt5651.c | 19 +++++++++++++++++++
 sound/soc/codecs/rt5651.h | 11 +++++++++++
 3 files changed, 41 insertions(+)

diff --git a/include/sound/rt5651.h b/include/sound/rt5651.h
index 725b36c329d0..6403b862fb9a 100644
--- a/include/sound/rt5651.h
+++ b/include/sound/rt5651.h
@@ -22,4 +22,15 @@ enum rt5651_jd_src {
 	RT5651_JD2,
 };
 
+/*
+ * Note these MUST match the values from the DT binding:
+ * Documentation/devicetree/bindings/sound/rt5651.txt
+ */
+enum rt5651_ovcd_sf {
+	RT5651_OVCD_SF_0P5,
+	RT5651_OVCD_SF_0P75,
+	RT5651_OVCD_SF_1P0,
+	RT5651_OVCD_SF_1P5,
+};
+
 #endif
diff --git a/sound/soc/codecs/rt5651.c b/sound/soc/codecs/rt5651.c
index 7ff1bc892cfd..486817809b7b 100644
--- a/sound/soc/codecs/rt5651.c
+++ b/sound/soc/codecs/rt5651.c
@@ -1632,6 +1632,10 @@ static int rt5651_set_jack(struct snd_soc_component *component,
 	snd_soc_component_update_bits(component, RT5651_PWR_ANLG2,
 		RT5651_PWR_JD_M, RT5651_PWR_JD_M);
 
+	/* Set OVCD threshold current and scale-factor */
+	snd_soc_component_write(component, RT5651_PR_BASE + RT5651_BIAS_CUR4,
+				0xa800 | rt5651->ovcd_sf);
+
 	snd_soc_component_update_bits(component, RT5651_MICBIAS,
 				      RT5651_MIC1_OVCD_MASK |
 				      RT5651_MIC1_OVTH_MASK |
@@ -1685,7 +1689,13 @@ static void rt5651_apply_properties(struct snd_soc_component *component)
 				     "realtek,jack-detect-source", &val) == 0)
 		rt5651->jd_src = val;
 
+	/*
+	 * Testing on various boards has shown that good defaults for the OVCD
+	 * threshold and scale-factor are 2000µA and 0.75. For an effective
+	 * limit of 1500µA, this seems to be more reliable then 1500µA and 1.0.
+	 */
 	rt5651->ovcd_th = RT5651_MIC1_OVTH_2000UA;
+	rt5651->ovcd_sf = RT5651_MIC_OVCD_SF_0P75;
 
 	if (device_property_read_u32(component->dev,
 			"realtek,over-current-threshold-microamp", &val) == 0) {
@@ -1704,6 +1714,15 @@ static void rt5651_apply_properties(struct snd_soc_component *component)
 				 val);
 		}
 	}
+
+	if (device_property_read_u32(component->dev,
+			"realtek,over-current-scale-factor", &val) == 0) {
+		if (val <= RT5651_OVCD_SF_1P5)
+			rt5651->ovcd_sf = val << RT5651_MIC_OVCD_SF_SFT;
+		else
+			dev_warn(component->dev, "Warning: Invalid over-current-scale-factor value: %d, defaulting to 0.75\n",
+				 val);
+	}
 }
 
 static int rt5651_probe(struct snd_soc_component *component)
diff --git a/sound/soc/codecs/rt5651.h b/sound/soc/codecs/rt5651.h
index 9cd5c279d0d6..71738ab93fb9 100644
--- a/sound/soc/codecs/rt5651.h
+++ b/sound/soc/codecs/rt5651.h
@@ -138,6 +138,7 @@
 /* Index of Codec Private Register definition */
 #define RT5651_BIAS_CUR1			0x12
 #define RT5651_BIAS_CUR3			0x14
+#define RT5651_BIAS_CUR4			0x15
 #define RT5651_CLSD_INT_REG1			0x1c
 #define RT5651_CHPUMP_INT_REG1			0x24
 #define RT5651_MAMP_INT_REG2			0x37
@@ -1966,6 +1967,15 @@
 #define RT5651_D_GATE_EN_SFT			0
 
 /* Codec Private Register definition */
+
+/* MIC Over current threshold scale factor (0x15) */
+#define RT5651_MIC_OVCD_SF_MASK			(0x3 << 8)
+#define RT5651_MIC_OVCD_SF_SFT			8
+#define RT5651_MIC_OVCD_SF_0P5			(0x0 << 8)
+#define RT5651_MIC_OVCD_SF_0P75			(0x1 << 8)
+#define RT5651_MIC_OVCD_SF_1P0			(0x2 << 8)
+#define RT5651_MIC_OVCD_SF_1P5			(0x3 << 8)
+
 /* 3D Speaker Control (0x63) */
 #define RT5651_3D_SPK_MASK			(0x1 << 15)
 #define RT5651_3D_SPK_SFT			15
@@ -2065,6 +2075,7 @@ struct rt5651_priv {
 	struct delayed_work jack_detect_work;
 	enum rt5651_jd_src jd_src;
 	unsigned int ovcd_th;
+	unsigned int ovcd_sf;
 
 	int irq;
 	int sysclk;
-- 
2.16.2


--===============1737221003849420499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1737221003849420499==--
