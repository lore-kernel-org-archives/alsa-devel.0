From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 03/12] ASoC: mfld_machine: Convert to table
	based DAPM and control setup
Date: Wed, 12 Mar 2014 15:27:31 +0100
Message-ID: <1394634460-15889-4-git-send-email-lars@metafoo.de>
References: <1394634460-15889-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-175.synserver.de (smtp-out-200.synserver.de
 [212.40.185.200])
 by alsa0.perex.cz (Postfix) with ESMTP id EBE7E264F09
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 15:27:13 +0100 (CET)
In-Reply-To: <1394634460-15889-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Ryan Mallon <rmallon@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, =?UTF-8?q?Daniel=20Gl=C3=B6ckner?= <daniel-gl@gmx.net>, Benoit Cousson <bcousson@baylibre.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Use table based setup to register the controls and DAPM widgets and routes.
This on one hand makes the code a bit cleaner and on the other hand
the board level DAPM elements get registered in the card's DAPM context rather
than in the CODEC's DAPM context.

The mfld_machine driver is a bit special in that it directly writes to one of
the CODEC registers from one of the control handlers. Previous to this patch it
was able to get a pointer to the CODEC from the control, since the control was
registered with the CODEC. This won't be possible anymore once the control is
registered with the card. Since there are already global variables in the driver
accessed in the same function the patch adds a global variable that holds a
pointer to the CODEC and uses that.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/intel/mfld_machine.c | 49 +++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/sound/soc/intel/mfld_machine.c b/sound/soc/intel/mfld_machine.c
index 0cef32e..4616942 100644
--- a/sound/soc/intel/mfld_machine.c
+++ b/sound/soc/intel/mfld_machine.c
@@ -53,6 +53,7 @@ enum soc_mic_bias_zones {
 
 static unsigned int	hs_switch;
 static unsigned int	lo_dac;
+static struct snd_soc_codec *mfld_codec;
 
 struct mfld_mc_private {
 	void __iomem *int_base;
@@ -100,8 +101,8 @@ static int headset_get_switch(struct snd_kcontrol *kcontrol,
 static int headset_set_switch(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_context *dapm = &card->dapm;
 
 	if (ucontrol->value.integer.value[0] == hs_switch)
 		return 0;
@@ -127,10 +128,8 @@ static int headset_set_switch(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static void lo_enable_out_pins(struct snd_soc_codec *codec)
+static void lo_enable_out_pins(struct snd_soc_dapm_context *dapm)
 {
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
-
 	snd_soc_dapm_enable_pin_unlocked(dapm, "IHFOUTL");
 	snd_soc_dapm_enable_pin_unlocked(dapm, "IHFOUTR");
 	snd_soc_dapm_enable_pin_unlocked(dapm, "LINEOUTL");
@@ -156,8 +155,8 @@ static int lo_get_switch(struct snd_kcontrol *kcontrol,
 static int lo_set_switch(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec =  snd_kcontrol_chip(kcontrol);
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_card *card = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dapm_context *dapm = &card->dapm;
 
 	if (ucontrol->value.integer.value[0] == lo_dac)
 		return 0;
@@ -167,35 +166,35 @@ static int lo_set_switch(struct snd_kcontrol *kcontrol,
 	/* we dont want to work with last state of lineout so just enable all
 	 * pins and then disable pins not required
 	 */
-	lo_enable_out_pins(codec);
+	lo_enable_out_pins(dapm);
 
 	switch (ucontrol->value.integer.value[0]) {
 	case 0:
 		pr_debug("set vibra path\n");
 		snd_soc_dapm_disable_pin_unlocked(dapm, "VIB1OUT");
 		snd_soc_dapm_disable_pin_unlocked(dapm, "VIB2OUT");
-		snd_soc_update_bits(codec, SN95031_LOCTL, 0x66, 0);
+		snd_soc_update_bits(mfld_codec, SN95031_LOCTL, 0x66, 0);
 		break;
 
 	case 1:
 		pr_debug("set hs  path\n");
 		snd_soc_dapm_disable_pin_unlocked(dapm, "Headphones");
 		snd_soc_dapm_disable_pin_unlocked(dapm, "EPOUT");
-		snd_soc_update_bits(codec, SN95031_LOCTL, 0x66, 0x22);
+		snd_soc_update_bits(mfld_codec, SN95031_LOCTL, 0x66, 0x22);
 		break;
 
 	case 2:
 		pr_debug("set spkr path\n");
 		snd_soc_dapm_disable_pin_unlocked(dapm, "IHFOUTL");
 		snd_soc_dapm_disable_pin_unlocked(dapm, "IHFOUTR");
-		snd_soc_update_bits(codec, SN95031_LOCTL, 0x66, 0x44);
+		snd_soc_update_bits(mfld_codec, SN95031_LOCTL, 0x66, 0x44);
 		break;
 
 	case 3:
 		pr_debug("set null path\n");
 		snd_soc_dapm_disable_pin_unlocked(dapm, "LINEOUTL");
 		snd_soc_dapm_disable_pin_unlocked(dapm, "LINEOUTR");
-		snd_soc_update_bits(codec, SN95031_LOCTL, 0x66, 0x66);
+		snd_soc_update_bits(mfld_codec, SN95031_LOCTL, 0x66, 0x66);
 		break;
 	}
 
@@ -238,26 +237,11 @@ static void mfld_jack_check(unsigned int intr_status)
 
 static int mfld_init(struct snd_soc_pcm_runtime *runtime)
 {
-	struct snd_soc_codec *codec = runtime->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
+	struct snd_soc_dapm_context *dapm = &runtime->card->dapm;
 	int ret_val;
 
-	/* Add jack sense widgets */
-	snd_soc_dapm_new_controls(dapm, mfld_widgets, ARRAY_SIZE(mfld_widgets));
-
-	/* Set up the map */
-	snd_soc_dapm_add_routes(dapm, mfld_map, ARRAY_SIZE(mfld_map));
+	mfld_codec = runtime->codec;
 
-	/* always connected */
-	snd_soc_dapm_enable_pin(dapm, "Headphones");
-	snd_soc_dapm_enable_pin(dapm, "Mic");
-
-	ret_val = snd_soc_add_codec_controls(codec, mfld_snd_controls,
-				ARRAY_SIZE(mfld_snd_controls));
-	if (ret_val) {
-		pr_err("soc_add_controls failed %d", ret_val);
-		return ret_val;
-	}
 	/* default is earpiece pin, userspace sets it explcitly */
 	snd_soc_dapm_disable_pin(dapm, "Headphones");
 	/* default is lineout NC, userspace sets it explcitly */
@@ -352,6 +336,13 @@ static struct snd_soc_card snd_soc_card_mfld = {
 	.owner = THIS_MODULE,
 	.dai_link = mfld_msic_dailink,
 	.num_links = ARRAY_SIZE(mfld_msic_dailink),
+
+	.controls = mfld_snd_controls,
+	.num_controls = ARRAY_SIZE(mfld_snd_controls),
+	.dapm_widgets = mfld_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mfld_widgets),
+	.dapm_routes = mfld_map,
+	.num_dapm_routes = ARRAY_SIZE(mfld_map),
 };
 
 static irqreturn_t snd_mfld_jack_intr_handler(int irq, void *dev)
-- 
1.8.0
