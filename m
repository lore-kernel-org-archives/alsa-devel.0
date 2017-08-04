From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ALSA: ice1712: add const to snd_ak4xxx_private structures
Date: Fri,  4 Aug 2017 21:04:41 +0530
Message-ID: <1501860881-7025-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_ak4xxx_private structures  as const as they are only passed
to the function snd_ice1712_akm4xxx_init. This argument is of type const,
so make the structures const.
Done using Coccinelle:

@match disable optional_qualifier@
identifier s;
position p;
@@
static struct snd_ak4xxx_private s@p={...};

@good1@
identifier match.s;
position p;
@@
snd_ice1712_akm4xxx_init(...,&s@p,...)

@bad@
identifier match.s;
position p!={match.p,good1.p};
@@
s@p

@depends on !bad disable optional_qualifier@
identifier match.s;
@@
static
+const
struct snd_ak4xxx_private s={...};

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/pci/ice1712/delta.c    | 12 ++++++------
 sound/pci/ice1712/ews.c      |  6 +++---
 sound/pci/ice1712/hoontech.c |  2 +-
 sound/pci/ice1712/phase.c    |  2 +-
 sound/pci/ice1712/revo.c     | 10 +++++-----
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/pci/ice1712/delta.c b/sound/pci/ice1712/delta.c
index da5f37b..4e470f0 100644
--- a/sound/pci/ice1712/delta.c
+++ b/sound/pci/ice1712/delta.c
@@ -454,7 +454,7 @@ static int snd_ice1712_delta1010lt_wordclock_status_get(struct snd_kcontrol *kco
 	}
 };
 
-static struct snd_ak4xxx_private akm_audiophile_priv = {
+static const struct snd_ak4xxx_private akm_audiophile_priv = {
 	.caddr = 2,
 	.cif = 0,
 	.data_mask = ICE1712_DELTA_AP_DOUT,
@@ -475,7 +475,7 @@ static int snd_ice1712_delta1010lt_wordclock_status_get(struct snd_kcontrol *kco
 	}
 };
 
-static struct snd_ak4xxx_private akm_delta410_priv = {
+static const struct snd_ak4xxx_private akm_delta410_priv = {
 	.caddr = 0,
 	.cif = 0,
 	.data_mask = ICE1712_DELTA_AP_DOUT,
@@ -497,7 +497,7 @@ static int snd_ice1712_delta1010lt_wordclock_status_get(struct snd_kcontrol *kco
 	}
 };
 
-static struct snd_ak4xxx_private akm_delta1010lt_priv = {
+static const struct snd_ak4xxx_private akm_delta1010lt_priv = {
 	.caddr = 2,
 	.cif = 0, /* the default level of the CIF pin from AK4524 */
 	.data_mask = ICE1712_DELTA_1010LT_DOUT,
@@ -519,7 +519,7 @@ static int snd_ice1712_delta1010lt_wordclock_status_get(struct snd_kcontrol *kco
 	}
 };
 
-static struct snd_ak4xxx_private akm_delta66e_priv = {
+static const struct snd_ak4xxx_private akm_delta66e_priv = {
 	.caddr = 2,
 	.cif = 0, /* the default level of the CIF pin from AK4524 */
 	.data_mask = ICE1712_DELTA_66E_DOUT,
@@ -542,7 +542,7 @@ static int snd_ice1712_delta1010lt_wordclock_status_get(struct snd_kcontrol *kco
 	}
 };
 
-static struct snd_ak4xxx_private akm_delta44_priv = {
+static const struct snd_ak4xxx_private akm_delta44_priv = {
 	.caddr = 2,
 	.cif = 0, /* the default level of the CIF pin from AK4524 */
 	.data_mask = ICE1712_DELTA_CODEC_SERIAL_DATA,
@@ -564,7 +564,7 @@ static int snd_ice1712_delta1010lt_wordclock_status_get(struct snd_kcontrol *kco
 	}
 };
 
-static struct snd_ak4xxx_private akm_vx442_priv = {
+static const struct snd_ak4xxx_private akm_vx442_priv = {
 	.caddr = 2,
 	.cif = 0,
 	.data_mask = ICE1712_VX442_DOUT,
diff --git a/sound/pci/ice1712/ews.c b/sound/pci/ice1712/ews.c
index ec07136..5bc14e8 100644
--- a/sound/pci/ice1712/ews.c
+++ b/sound/pci/ice1712/ews.c
@@ -354,7 +354,7 @@ static void ews88_setup_spdif(struct snd_ice1712 *ice, int rate)
 	}
 };
 
-static struct snd_ak4xxx_private akm_ews88mt_priv = {
+static const struct snd_ak4xxx_private akm_ews88mt_priv = {
 	.caddr = 2,
 	.cif = 1, /* CIF high */
 	.data_mask = ICE1712_EWS88_SERIAL_DATA,
@@ -375,7 +375,7 @@ static void ews88_setup_spdif(struct snd_ice1712 *ice, int rate)
 	}
 };
 
-static struct snd_ak4xxx_private akm_ewx2496_priv = {
+static const struct snd_ak4xxx_private akm_ewx2496_priv = {
 	.caddr = 2,
 	.cif = 1, /* CIF high */
 	.data_mask = ICE1712_EWS88_SERIAL_DATA,
@@ -396,7 +396,7 @@ static void ews88_setup_spdif(struct snd_ice1712 *ice, int rate)
 	}
 };
 
-static struct snd_ak4xxx_private akm_6fire_priv = {
+static const struct snd_ak4xxx_private akm_6fire_priv = {
 	.caddr = 2,
 	.cif = 1, /* CIF high */
 	.data_mask = ICE1712_6FIRE_SERIAL_DATA,
diff --git a/sound/pci/ice1712/hoontech.c b/sound/pci/ice1712/hoontech.c
index a40001c..de2fcc9 100644
--- a/sound/pci/ice1712/hoontech.c
+++ b/sound/pci/ice1712/hoontech.c
@@ -278,7 +278,7 @@ static int snd_ice1712_value_init(struct snd_ice1712 *ice)
 		}
 	};
 
-	static struct snd_ak4xxx_private akm_stdsp24_mv_priv = {
+	static const struct snd_ak4xxx_private akm_stdsp24_mv_priv = {
 		.caddr = 2,
 		.cif = 1, /* CIF high */
 		.data_mask = ICE1712_STDSP24_SERIAL_DATA,
diff --git a/sound/pci/ice1712/phase.c b/sound/pci/ice1712/phase.c
index e9ca89c..4f85482 100644
--- a/sound/pci/ice1712/phase.c
+++ b/sound/pci/ice1712/phase.c
@@ -108,7 +108,7 @@ struct phase28_spec {
 	.num_adcs = 2,
 };
 
-static struct snd_ak4xxx_private akm_phase22_priv = {
+static const struct snd_ak4xxx_private akm_phase22_priv = {
 	.caddr =	2,
 	.cif =		1,
 	.data_mask =	1 << 4,
diff --git a/sound/pci/ice1712/revo.c b/sound/pci/ice1712/revo.c
index 1d81ae6..5cc4213 100644
--- a/sound/pci/ice1712/revo.c
+++ b/sound/pci/ice1712/revo.c
@@ -244,7 +244,7 @@ static int revo51_i2c_init(struct snd_ice1712 *ice,
 	.dac_info = revo71_front,
 };
 
-static struct snd_ak4xxx_private akm_revo_front_priv = {
+static const struct snd_ak4xxx_private akm_revo_front_priv = {
 	.caddr = 1,
 	.cif = 0,
 	.data_mask = VT1724_REVO_CDOUT,
@@ -266,7 +266,7 @@ static int revo51_i2c_init(struct snd_ice1712 *ice,
 	.dac_info = revo71_surround,
 };
 
-static struct snd_ak4xxx_private akm_revo_surround_priv = {
+static const struct snd_ak4xxx_private akm_revo_surround_priv = {
 	.caddr = 3,
 	.cif = 0,
 	.data_mask = VT1724_REVO_CDOUT,
@@ -287,7 +287,7 @@ static int revo51_i2c_init(struct snd_ice1712 *ice,
 	.dac_info = revo51_dac,
 };
 
-static struct snd_ak4xxx_private akm_revo51_priv = {
+static const struct snd_ak4xxx_private akm_revo51_priv = {
 	.caddr = 2,
 	.cif = 0,
 	.data_mask = VT1724_REVO_CDOUT,
@@ -305,7 +305,7 @@ static int revo51_i2c_init(struct snd_ice1712 *ice,
 	.adc_info = revo51_adc,
 };
 
-static struct snd_ak4xxx_private akm_revo51_adc_priv = {
+static const struct snd_ak4xxx_private akm_revo51_adc_priv = {
 	.caddr = 2,
 	.cif = 0,
 	.data_mask = VT1724_REVO_CDOUT,
@@ -355,7 +355,7 @@ static void ap192_set_rate_val(struct snd_akm4xxx *ak, unsigned int rate)
 	.dac_info = ap192_dac,
 };
 
-static struct snd_ak4xxx_private akm_ap192_priv = {
+static const struct snd_ak4xxx_private akm_ap192_priv = {
 	.caddr = 2,
 	.cif = 0,
 	.data_mask = VT1724_REVO_CDOUT,
-- 
1.9.1
