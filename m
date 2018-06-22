From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 07/16] ALSA: hda/realtek - Convert some manual
	GPIO setups
Date: Fri, 22 Jun 2018 11:53:43 +0200
Message-ID: <20180622095352.19451-8-tiwai@suse.de>
References: <20180622095352.19451-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 482A12676E0
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 11:53:56 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 94082AFA4
 for <alsa-devel@alsa-project.org>; Fri, 22 Jun 2018 09:53:54 +0000 (UTC)
In-Reply-To: <20180622095352.19451-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch converts the remaining static init verbs for GPIO bits with
the common gpio_* fields management.  Only the verbs setting the GPIO
data bits are targeted in this patch.  The rest will be changed in
later patches.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 49 +++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a0881ffcd9d7..f5cc506504c0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -296,6 +296,12 @@ static void alc_fixup_gpio3(struct hda_codec *codec,
 	alc_fixup_gpio(codec, action, 0x03);
 }
 
+static void alc_fixup_gpio4(struct hda_codec *codec,
+			    const struct hda_fixup *fix, int action)
+{
+	alc_fixup_gpio(codec, action, 0x04);
+}
+
 /*
  * Fix hardware PLL issue
  * On some codecs, the analog PLL gating control must be off while
@@ -5172,13 +5178,6 @@ static void alc282_fixup_asus_tx300(struct hda_codec *codec,
 				    const struct hda_fixup *fix, int action)
 {
 	struct alc_spec *spec = codec->spec;
-	/* TX300 needs to set up GPIO2 for the speaker amp */
-	static const struct hda_verb gpio2_verbs[] = {
-		{ 0x01, AC_VERB_SET_GPIO_MASK, 0x04 },
-		{ 0x01, AC_VERB_SET_GPIO_DIRECTION, 0x04 },
-		{ 0x01, AC_VERB_SET_GPIO_DATA, 0x04 },
-		{}
-	};
 	static const struct hda_pintbl dock_pins[] = {
 		{ 0x1b, 0x21114000 }, /* dock speaker pin */
 		{}
@@ -5187,7 +5186,8 @@ static void alc282_fixup_asus_tx300(struct hda_codec *codec,
 	switch (action) {
 	case HDA_FIXUP_ACT_PRE_PROBE:
 		spec->init_amp = ALC_INIT_DEFAULT;
-		snd_hda_add_verbs(codec, gpio2_verbs);
+		/* TX300 needs to set up GPIO2 for the speaker amp */
+		alc_setup_gpio(codec, 0x04);
 		snd_hda_apply_pincfgs(codec, dock_pins);
 		spec->gen.auto_mute_via_amp = 1;
 		spec->gen.automute_hook = asus_tx300_automute;
@@ -5280,6 +5280,19 @@ static void alc280_fixup_hp_9480m(struct hda_codec *codec,
 	}
 }
 
+static void alc275_fixup_gpio4_off(struct hda_codec *codec,
+				   const struct hda_fixup *fix,
+				   int action)
+{
+	struct alc_spec *spec = codec->spec;
+
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		spec->gpio_mask |= 0x04;
+		spec->gpio_dir |= 0x04;
+		/* set data bit low */
+	}
+}
+
 static void alc233_alc662_fixup_lenovo_dual_codecs(struct hda_codec *codec,
 					 const struct hda_fixup *fix,
 					 int action)
@@ -5468,13 +5481,8 @@ static const struct hda_fixup alc269_fixups[] = {
 		}
 	},
 	[ALC275_FIXUP_SONY_VAIO_GPIO2] = {
-		.type = HDA_FIXUP_VERBS,
-		.v.verbs = (const struct hda_verb[]) {
-			{0x01, AC_VERB_SET_GPIO_MASK, 0x04},
-			{0x01, AC_VERB_SET_GPIO_DIRECTION, 0x04},
-			{0x01, AC_VERB_SET_GPIO_DATA, 0x00},
-			{ }
-		},
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc275_fixup_gpio4_off,
 		.chained = true,
 		.chain_id = ALC269_FIXUP_SONY_VAIO
 	},
@@ -6219,14 +6227,9 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
 	},
 	[ALC256_FIXUP_ASUS_AIO_GPIO2] = {
-		.type = HDA_FIXUP_VERBS,
-		.v.verbs = (const struct hda_verb[]) {
-			/* Set up GPIO2 for the speaker amp */
-			{ 0x01, AC_VERB_SET_GPIO_MASK, 0x04 },
-			{ 0x01, AC_VERB_SET_GPIO_DIRECTION, 0x04 },
-			{ 0x01, AC_VERB_SET_GPIO_DATA, 0x04 },
-			{}
-		},
+		.type = HDA_FIXUP_FUNC,
+		/* Set up GPIO2 for the speaker amp */
+		.v.func = alc_fixup_gpio4,
 	},
 	[ALC233_FIXUP_ASUS_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
-- 
2.17.1
