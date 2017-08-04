From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ALSA: ice1712: add const to snd_akm4xxx structures
Date: Fri,  4 Aug 2017 23:19:30 +0530
Message-ID: <1501868970-3747-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_akm4xxx structures  as const as they are only passed
to the function snd_ice1712_akm4xxx_init. This argument is of type
const, so make the structures const.
Done using Coccinelle:

@match disable optional_qualifier@
identifier s;
position p;
@@
static struct snd_akm4xxx s@p={...};

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
struct snd_akm4xxx s={...};

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/pci/ice1712/delta.c    | 12 ++++++------
 sound/pci/ice1712/ews.c      |  6 +++---
 sound/pci/ice1712/hoontech.c |  2 +-
 sound/pci/ice1712/juli.c     |  2 +-
 sound/pci/ice1712/phase.c    |  2 +-
 sound/pci/ice1712/quartet.c  |  2 +-
 sound/pci/ice1712/revo.c     | 10 +++++-----
 7 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/sound/pci/ice1712/delta.c b/sound/pci/ice1712/delta.c
index da5f37b..ab4461d 100644
--- a/sound/pci/ice1712/delta.c
+++ b/sound/pci/ice1712/delta.c
@@ -445,7 +445,7 @@ static int snd_ice1712_delta1010lt_wordclock_status_get(struct snd_kcontrol *kco
  * initialize the chips on M-Audio cards
  */
 
-static struct snd_akm4xxx akm_audiophile = {
+static const struct snd_akm4xxx akm_audiophile = {
 	.type = SND_AK4528,
 	.num_adcs = 2,
 	.num_dacs = 2,
@@ -466,7 +466,7 @@ static int snd_ice1712_delta1010lt_wordclock_status_get(struct snd_kcontrol *kco
 	.mask_flags = 0,
 };
 
-static struct snd_akm4xxx akm_delta410 = {
+static const struct snd_akm4xxx akm_delta410 = {
 	.type = SND_AK4529,
 	.num_adcs = 2,
 	.num_dacs = 8,
@@ -487,7 +487,7 @@ static int snd_ice1712_delta1010lt_wordclock_status_get(struct snd_kcontrol *kco
 	.mask_flags = 0,
 };
 
-static struct snd_akm4xxx akm_delta1010lt = {
+static const struct snd_akm4xxx akm_delta1010lt = {
 	.type = SND_AK4524,
 	.num_adcs = 8,
 	.num_dacs = 8,
@@ -509,7 +509,7 @@ static int snd_ice1712_delta1010lt_wordclock_status_get(struct snd_kcontrol *kco
 	.mask_flags = 0,
 };
 
-static struct snd_akm4xxx akm_delta66e = {
+static const struct snd_akm4xxx akm_delta66e = {
 	.type = SND_AK4524,
 	.num_adcs = 4,
 	.num_dacs = 4,
@@ -532,7 +532,7 @@ static int snd_ice1712_delta1010lt_wordclock_status_get(struct snd_kcontrol *kco
 };
 
 
-static struct snd_akm4xxx akm_delta44 = {
+static const struct snd_akm4xxx akm_delta44 = {
 	.type = SND_AK4524,
 	.num_adcs = 4,
 	.num_dacs = 4,
@@ -554,7 +554,7 @@ static int snd_ice1712_delta1010lt_wordclock_status_get(struct snd_kcontrol *kco
 	.mask_flags = 0,
 };
 
-static struct snd_akm4xxx akm_vx442 = {
+static const struct snd_akm4xxx akm_vx442 = {
 	.type = SND_AK4524,
 	.num_adcs = 4,
 	.num_dacs = 4,
diff --git a/sound/pci/ice1712/ews.c b/sound/pci/ice1712/ews.c
index ec07136..de3603e 100644
--- a/sound/pci/ice1712/ews.c
+++ b/sound/pci/ice1712/ews.c
@@ -344,7 +344,7 @@ static void ews88_setup_spdif(struct snd_ice1712 *ice, int rate)
 
 /*
  */
-static struct snd_akm4xxx akm_ews88mt = {
+static const struct snd_akm4xxx akm_ews88mt = {
 	.num_adcs = 8,
 	.num_dacs = 8,
 	.type = SND_AK4524,
@@ -366,7 +366,7 @@ static void ews88_setup_spdif(struct snd_ice1712 *ice, int rate)
 	.mask_flags = 0,
 };
 
-static struct snd_akm4xxx akm_ewx2496 = {
+static const struct snd_akm4xxx akm_ewx2496 = {
 	.num_adcs = 2,
 	.num_dacs = 2,
 	.type = SND_AK4524,
@@ -387,7 +387,7 @@ static void ews88_setup_spdif(struct snd_ice1712 *ice, int rate)
 	.mask_flags = 0,
 };
 
-static struct snd_akm4xxx akm_6fire = {
+static const struct snd_akm4xxx akm_6fire = {
 	.num_adcs = 6,
 	.num_dacs = 6,
 	.type = SND_AK4524,
diff --git a/sound/pci/ice1712/hoontech.c b/sound/pci/ice1712/hoontech.c
index a40001c..0bbb5f4 100644
--- a/sound/pci/ice1712/hoontech.c
+++ b/sound/pci/ice1712/hoontech.c
@@ -269,7 +269,7 @@ static void stdsp24_ak4524_lock(struct snd_akm4xxx *ak, int chip)
 static int snd_ice1712_value_init(struct snd_ice1712 *ice)
 {
 	/* Hoontech STDSP24 with modified hardware */
-	static struct snd_akm4xxx akm_stdsp24_mv = {
+	static const struct snd_akm4xxx akm_stdsp24_mv = {
 		.num_adcs = 2,
 		.num_dacs = 2,
 		.type = SND_AK4524,
diff --git a/sound/pci/ice1712/juli.c b/sound/pci/ice1712/juli.c
index 5bb1467..0dbaccf 100644
--- a/sound/pci/ice1712/juli.c
+++ b/sound/pci/ice1712/juli.c
@@ -282,7 +282,7 @@ static void juli_akm_set_rate_val(struct snd_akm4xxx *ak, unsigned int rate)
 };
 
 
-static struct snd_akm4xxx akm_juli_dac = {
+static const struct snd_akm4xxx akm_juli_dac = {
 	.type = SND_AK4358,
 	.num_dacs = 8,	/* DAC1 - analog out
 			   DAC2 - analog in monitor
diff --git a/sound/pci/ice1712/phase.c b/sound/pci/ice1712/phase.c
index e9ca89c..94bf8ed 100644
--- a/sound/pci/ice1712/phase.c
+++ b/sound/pci/ice1712/phase.c
@@ -102,7 +102,7 @@ struct phase28_spec {
 #define WM_VOL_MAX	(sizeof(wm_vol) - 1)
 #define WM_VOL_MUTE	0x8000
 
-static struct snd_akm4xxx akm_phase22 = {
+static const struct snd_akm4xxx akm_phase22 = {
 	.type = SND_AK4524,
 	.num_dacs = 2,
 	.num_adcs = 2,
diff --git a/sound/pci/ice1712/quartet.c b/sound/pci/ice1712/quartet.c
index f1b3732..d145b5e 100644
--- a/sound/pci/ice1712/quartet.c
+++ b/sound/pci/ice1712/quartet.c
@@ -386,7 +386,7 @@ static void qtet_akm_set_rate_val(struct snd_akm4xxx *ak, unsigned int rate)
 	AK_CONTROL(PCM_34_CAPTURE_VOLUME, 2),
 };
 
-static struct snd_akm4xxx akm_qtet_dac = {
+static const struct snd_akm4xxx akm_qtet_dac = {
 	.type = SND_AK4620,
 	.num_dacs = 4,	/* DAC1 - Output 12
 	*/
diff --git a/sound/pci/ice1712/revo.c b/sound/pci/ice1712/revo.c
index 1d81ae6..5cd3225 100644
--- a/sound/pci/ice1712/revo.c
+++ b/sound/pci/ice1712/revo.c
@@ -235,7 +235,7 @@ static int revo51_i2c_init(struct snd_ice1712 *ice,
 	},
 };
 
-static struct snd_akm4xxx akm_revo_front = {
+static const struct snd_akm4xxx akm_revo_front = {
 	.type = SND_AK4381,
 	.num_dacs = 2,
 	.ops = {
@@ -256,7 +256,7 @@ static int revo51_i2c_init(struct snd_ice1712 *ice,
 	.mask_flags = 0,
 };
 
-static struct snd_akm4xxx akm_revo_surround = {
+static const struct snd_akm4xxx akm_revo_surround = {
 	.type = SND_AK4355,
 	.idx_offset = 1,
 	.num_dacs = 6,
@@ -278,7 +278,7 @@ static int revo51_i2c_init(struct snd_ice1712 *ice,
 	.mask_flags = 0,
 };
 
-static struct snd_akm4xxx akm_revo51 = {
+static const struct snd_akm4xxx akm_revo51 = {
 	.type = SND_AK4358,
 	.num_dacs = 8,
 	.ops = {
@@ -299,7 +299,7 @@ static int revo51_i2c_init(struct snd_ice1712 *ice,
 	.mask_flags = 0,
 };
 
-static struct snd_akm4xxx akm_revo51_adc = {
+static const struct snd_akm4xxx akm_revo51_adc = {
 	.type = SND_AK5365,
 	.num_adcs = 2,
 	.adc_info = revo51_adc,
@@ -346,7 +346,7 @@ static void ap192_set_rate_val(struct snd_akm4xxx *ak, unsigned int rate)
 	AK_DAC("PCM Playback Volume", 2)
 };
 
-static struct snd_akm4xxx akm_ap192 = {
+static const struct snd_akm4xxx akm_ap192 = {
 	.type = SND_AK4358,
 	.num_dacs = 2,
 	.ops = {
-- 
1.9.1
