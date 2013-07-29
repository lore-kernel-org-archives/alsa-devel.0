From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Fix the noise after suspend on
	ALC283 codec
Date: Mon, 29 Jul 2013 11:47:41 +0200
Message-ID: <1375091261-18274-2-git-send-email-tiwai@suse.de>
References: <1375091261-18274-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A85F6260291
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 11:46:12 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 41AAAA51FE
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 11:46:12 +0200 (CEST)
In-Reply-To: <1375091261-18274-1-git-send-email-tiwai@suse.de>
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

From: Kailang Yang <kailang@realtek.com>

When the power state of ALC283 codec goes to D3, it gives a noise via
headphone output.  This is because the driver tries to clear all pins
via snd_hda_shutup_pins().  Setting the mic pin to zero triggers such
a noise.

Define a new shutup call specific to this codec and control the pins
there more precisely.  Also, add the power-save enable/disable
sequences in the resume and the new shutup calls.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dbd59df..04a69e3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2712,6 +2712,13 @@ static int alc269_resume(struct hda_codec *codec)
 	hda_call_check_power_status(codec, 0x01);
 	if (spec->has_alc5505_dsp)
 		alc5505_dsp_resume(codec);
+
+	/* clear the power-save mode for ALC283 */
+	if (codec->vendor_id == 0x10ec0283) {
+		alc_write_coef_idx(codec, 0x4, 0xaf01);
+		alc_write_coef_idx(codec, 0x6, 0x2104);
+	}
+
 	return 0;
 }
 #endif /* CONFIG_PM */
@@ -3775,6 +3782,30 @@ static void alc269_fill_coef(struct hda_codec *codec)
 	alc_write_coef_idx(codec, 0x4, val | (1<<11));
 }
 
+/* don't clear mic pin; otherwise it results in noise in D3 */
+static void alc283_headset_shutup(struct hda_codec *codec)
+{
+	int i;
+
+	if (codec->bus->shutdown)
+		return;
+
+	for (i = 0; i < codec->init_pins.used; i++) {
+		struct hda_pincfg *pin = snd_array_elem(&codec->init_pins, i);
+		/* use read here for syncing after issuing each verb */
+		if (pin->nid != 0x19)
+			snd_hda_codec_read(codec, pin->nid, 0,
+					   AC_VERB_SET_PIN_WIDGET_CONTROL, 0);
+	}
+
+	alc_write_coef_idx(codec, 0x4, 0x0f01); /* power save */
+	alc_write_coef_idx(codec, 0x6, 0x2100); /* power save */
+	snd_hda_codec_write(codec, 0x19, 0,
+			AC_VERB_SET_PIN_WIDGET_CONTROL,
+			PIN_VREFHIZ);
+	codec->pins_shutup = 1;
+}
+
 /*
  */
 static int patch_alc269(struct hda_codec *codec)
@@ -3789,6 +3820,9 @@ static int patch_alc269(struct hda_codec *codec)
 	spec = codec->spec;
 	spec->gen.shared_mic_vref_pin = 0x18;
 
+	if (codec->vendor_id == 0x10ec0283)
+		spec->shutup = alc283_headset_shutup;
+
 	snd_hda_pick_fixup(codec, alc269_fixup_models,
 		       alc269_fixup_tbl, alc269_fixups);
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PRE_PROBE);
@@ -3862,7 +3896,8 @@ static int patch_alc269(struct hda_codec *codec)
 	codec->patch_ops.suspend = alc269_suspend;
 	codec->patch_ops.resume = alc269_resume;
 #endif
-	spec->shutup = alc269_shutup;
+	if (!spec->shutup)
+		spec->shutup = alc269_shutup;
 
 	snd_hda_apply_fixup(codec, HDA_FIXUP_ACT_PROBE);
 
-- 
1.8.3.1
