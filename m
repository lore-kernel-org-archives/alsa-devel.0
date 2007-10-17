From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: STAC9228 DMIC Support
Date: Wed, 17 Oct 2007 14:44:27 -0400
Message-ID: <4716580B.3080907@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040509090409050904010207"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp107.biz.mail.re2.yahoo.com (smtp107.biz.mail.re2.yahoo.com
	[206.190.52.176]) by alsa0.perex.cz (Postfix) with SMTP id 362E4247E1
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Oct 2007 20:44:27 +0200 (CEST)
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

This is a multi-part message in MIME format.
--------------040509090409050904010207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added DMIC support for STAC9228 cards, as well as adding terminators to 
other hda_nid DMIC arrays, and added a new Vendor ID tag.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------040509090409050904010207
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="stac9228_dmic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stac9228_dmic.patch"

diff -r e91f57f8127a pci/hda/hda_codec.c
--- a/pci/hda/hda_codec.c	Tue Oct 09 11:58:41 2007 +0200
+++ b/pci/hda/hda_codec.c	Wed Oct 17 11:59:47 2007 -0400
@@ -55,6 +55,7 @@ static struct hda_vendor_id hda_vendor_i
 	{ 0x10ec, "Realtek" },
 	{ 0x1057, "Motorola" },
 	{ 0x1106, "VIA" },
+	{ 0x111d, "IDT" },
 	{ 0x11d4, "Analog Devices" },
 	{ 0x13f6, "C-Media" },
 	{ 0x14f1, "Conexant" },
diff -r e91f57f8127a pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Tue Oct 09 11:58:41 2007 +0200
+++ b/pci/hda/patch_sigmatel.c	Wed Oct 17 13:06:58 2007 -0400
@@ -182,8 +182,9 @@ static hda_nid_t stac925x_dac_nids[1] = 
         0x02,
 };
 
-static hda_nid_t stac925x_dmic_nids[1] = {
-	0x15, 
+static hda_nid_t stac925x_dmic_nids[2] = {
+        0x15, 
+        0x00, /* terminator */
 };
 
 static hda_nid_t stac922x_adc_nids[2] = {
@@ -202,6 +203,11 @@ static hda_nid_t stac927x_mux_nids[3] = 
         0x15, 0x16, 0x17
 };
 
+static hda_nid_t stac927x_dmic_nids[3] = {
+        0x13, 0x14,
+        0x00, /* terminator */
+};
+
 static hda_nid_t stac9205_adc_nids[2] = {
         0x12, 0x13
 };
@@ -210,8 +216,9 @@ static hda_nid_t stac9205_mux_nids[2] = 
         0x19, 0x1a
 };
 
-static hda_nid_t stac9205_dmic_nids[2] = {
+static hda_nid_t stac9205_dmic_nids[3] = {
         0x17, 0x18,
+        0x00, /* terminator */
 };
 
 static hda_nid_t stac9200_pin_nids[8] = {
@@ -2716,7 +2723,6 @@ static int patch_stac927x(struct hda_cod
 		spec->mux_nids = stac927x_mux_nids;
 		spec->num_muxes = ARRAY_SIZE(stac927x_mux_nids);
 		spec->num_adcs = ARRAY_SIZE(stac927x_adc_nids);
-		spec->num_dmics = 0;
 		spec->init = d965_core_init;
 		spec->mixer = stac927x_mixer;
 		break;
@@ -2725,7 +2731,6 @@ static int patch_stac927x(struct hda_cod
 		spec->mux_nids = stac927x_mux_nids;
 		spec->num_muxes = ARRAY_SIZE(stac927x_mux_nids);
 		spec->num_adcs = ARRAY_SIZE(stac927x_adc_nids);
-		spec->num_dmics = 0;
 		spec->init = d965_core_init;
 		spec->mixer = stac927x_mixer;
 		break;
@@ -2734,9 +2739,18 @@ static int patch_stac927x(struct hda_cod
 		spec->mux_nids = stac927x_mux_nids;
 		spec->num_muxes = ARRAY_SIZE(stac927x_mux_nids);
 		spec->num_adcs = ARRAY_SIZE(stac927x_adc_nids);
-		spec->num_dmics = 0;
 		spec->init = stac927x_core_init;
 		spec->mixer = stac927x_mixer;
+	}
+
+	switch (codec->subsystem_id) {
+	case 0x1028020A: /* STAC 9228 */
+	case 0x10280209: /* STAC 9228 */
+		spec->dmic_nids = stac927x_dmic_nids;
+		spec->num_dmics = 2;
+		break;
+	default:
+		spec->num_dmics = 0;
 	}
 
 	spec->multiout.dac_nids = spec->dac_nids;
@@ -2798,7 +2812,7 @@ static int patch_stac9205(struct hda_cod
 	spec->mux_nids = stac9205_mux_nids;
 	spec->num_muxes = ARRAY_SIZE(stac9205_mux_nids);
 	spec->dmic_nids = stac9205_dmic_nids;
-	spec->num_dmics = ARRAY_SIZE(stac9205_dmic_nids);
+	spec->num_dmics = 2;
 	spec->dmux_nid = 0x1d;
 
 	spec->init = stac9205_core_init;

--------------040509090409050904010207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------040509090409050904010207--
