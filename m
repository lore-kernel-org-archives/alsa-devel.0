From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: STAC927x power down inactive DACs
Date: Wed, 30 Jan 2008 09:14:02 -0500
Message-ID: <47A0862A.2070000@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp108.biz.mail.mud.yahoo.com (smtp108.biz.mail.mud.yahoo.com
	[68.142.201.177])
	by alsa0.perex.cz (Postfix) with SMTP id F4126103807
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 15:14:09 +0100 (CET)
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

On several laptops that have STAC9228 codecs have unused DACs, this powers them down to a D3 state.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r 86c8c0a82bb9 pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Wed Jan 30 11:52:33 2008 +0100
+++ b/pci/hda/patch_sigmatel.c	Wed Jan 30 08:58:37 2008 -0500
@@ -288,6 +288,10 @@ static hda_nid_t stac927x_adc_nids[3] = 
 
 static hda_nid_t stac927x_mux_nids[3] = {
         0x15, 0x16, 0x17
+};
+
+static hda_nid_t stac927x_dac_nids[5] = {
+	0x02, 0x03, 0x04, 0x05, 0x06
 };
 
 static hda_nid_t stac927x_dmux_nids[1] = {
@@ -3537,7 +3541,7 @@ static int patch_stac927x(struct hda_cod
 static int patch_stac927x(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec;
-	int err;
+	int err, i;
 
 	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (spec == NULL)
@@ -3628,6 +3632,14 @@ static int patch_stac927x(struct hda_cod
 		stac92xx_free(codec);
 		return err;
 	}
+
+	/* on some 3-stack systems not all the DACs are used
+ 	 * this powers down ones that aren't used
+ 	 */
+	for (i = 0; i < ARRAY_SIZE(stac927x_dac_nids); i++)
+		if (!is_in_dac_nids(spec, stac927x_dac_nids[i]))
+			snd_hda_codec_write_cache(codec, stac927x_dac_nids[i],
+				0, AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
 
 	codec->patch_ops = stac92xx_patch_ops;
