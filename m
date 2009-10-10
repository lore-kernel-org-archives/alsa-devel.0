From: Logan Li <loganli@viatech.com.cn>
Subject: [PATCH 3/30] ALSA: HDA VIA: Add VT1708B-CE codec
	support.
Date: Sat, 10 Oct 2009 19:07:29 +0800
Message-ID: <4AD06AF1.3070700@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id D0DB0244E5
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Oct 2009 13:07:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, HaraldWelte@viatech.com, LydiaWang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: HDA VIA: Add VT1708B-CE codec support.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |   27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -84,6 +84,7 @@
 	VT1708B_8CH,
 	VT1708B_4CH,
 	VT1708S,
+	VT1708BCE,
 	VT1702,
 	CODEC_TYPES,
 };
@@ -104,9 +105,11 @@
 		codec_type = VT1709_10CH;
 	else if (dev_id >= 0xe714 && dev_id <= 0xe717)
 		codec_type = VT1709_6CH;
-	else if (dev_id >= 0xe720 && dev_id <= 0xe723)
+	else if (dev_id >= 0xe720 && dev_id <= 0xe723) {
 		codec_type = VT1708B_8CH;
-	else if (dev_id >= 0xe724 && dev_id <= 0xe727)
+		if (snd_hda_param_read(codec, 0x16, AC_PAR_CONNLIST_LEN) == 0x7)
+			codec_type = VT1708BCE;
+	} else if (dev_id >= 0xe724 && dev_id <= 0xe727)
 		codec_type = VT1708B_4CH;
 	else if ((dev_id & 0xfff) == 0x397
 		 && (dev_id >> 12) < 8)
@@ -224,6 +227,8 @@
 	const struct hda_input_mux *hp_mux;
 	unsigned int hp_independent_mode;
 
+	enum VIA_HDA_CODEC codec_type;
+
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	struct hda_loopback_check loopback;
 #endif
@@ -979,6 +984,10 @@
 	for (i = 0; i < spec->num_iverbs; i++)
 		snd_hda_sequence_write(codec, spec->init_verbs[i]);
 
+	spec->codec_type = get_codec_type(codec);
+	if (spec->codec_type == VT1708BCE)
+		spec->codec_type = VT1708S; /* VT1708BCE & VT1708S are almost
+					       same */
 	/* Lydia Add for EAPD enable */
 	if (!spec->dig_in_nid) { /* No Digital In connection */
 		if (spec->dig_in_pin) {
@@ -2369,12 +2378,14 @@
 	{ } /* end */
 };
 #endif
-
+static int patch_vt1708S(struct hda_codec *codec);
 static int patch_vt1708B_8ch(struct hda_codec *codec)
 {
 	struct via_spec *spec;
 	int err;
 
+	if (get_codec_type(codec) == VT1708BCE)
+		return patch_vt1708S(codec);
 	/* create a codec specific record */
 	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
@@ -2906,6 +2917,16 @@
 	spec->loopback.amplist = vt1708S_loopbacks;
 #endif
 
+	/* correct names for VT1708BCE */
+	if (get_codec_type(codec) == VT1708BCE)	{
+		kfree(codec->chip_name);
+		codec->chip_name = kstrdup("VT1708BCE", GFP_KERNEL);
+		snprintf(codec->bus->card->mixername,
+			 sizeof(codec->bus->card->mixername),
+			 "%s %s", codec->vendor_name, codec->chip_name);
+		spec->stream_name_analog = "VT1708BCE Analog";
+		spec->stream_name_digital = "VT1708BCE Digital";
+	}
 	return 0;
 }
