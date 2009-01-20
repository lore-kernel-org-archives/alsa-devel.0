From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: 83xxx port 0xe DAC selection
Date: Tue, 20 Jan 2009 16:50:25 -0500
Message-ID: <49764721.5040903@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 857AE1037E3
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 22:50:41 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On the 92hd8xxx codecs port 0xe needs the connection selected to be the
last DAC in the list.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index a4d4afe..7badec0 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -841,10 +841,6 @@ static struct hda_verb stac92hd73xx_10ch_core_init[] = {
 };
 
 static struct hda_verb stac92hd83xxx_core_init[] = {
-	/* start of config #1 */
-	{ 0xe, AC_VERB_SET_CONNECT_SEL, 0x3},
-
-	/* start of config #2 */
 	{ 0xa, AC_VERB_SET_CONNECT_SEL, 0x0},
 	{ 0xb, AC_VERB_SET_CONNECT_SEL, 0x0},
 	{ 0xd, AC_VERB_SET_CONNECT_SEL, 0x1},
@@ -4754,7 +4750,9 @@ static struct hda_input_mux stac92hd83xxx_dmux = {
 static int patch_stac92hd83xxx(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec;
+	hda_nid_t conn[STAC92HD83_DAC_COUNT + 1];
 	int err;
+	int num_dacs;
 
 	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
@@ -4773,13 +4771,21 @@ static int patch_stac92hd83xxx(struct hda_codec *codec)
 	spec->num_pwrs = ARRAY_SIZE(stac92hd83xxx_pwr_nids);
 	spec->multiout.dac_nids = spec->dac_nids;
 
+
+	/* set port 0xe to select the last DAC
+ 	 */
+	num_dacs = snd_hda_get_connections(codec, 0x0e,
+		conn, STAC92HD83_DAC_COUNT + 1) - 1;
+
+	snd_hda_codec_write_cache(codec, 0xe, 0,
+		AC_VERB_SET_CONNECT_SEL, num_dacs);
+
 	spec->init = stac92hd83xxx_core_init;
 	switch (codec->vendor_id) {
 	case 0x111d7605:
 		break;
 	default:
 		spec->num_pwrs--;
-		spec->init++; /* switch to config #2 */
 	}
 
 	spec->mixer = stac92hd83xxx_mixer;
