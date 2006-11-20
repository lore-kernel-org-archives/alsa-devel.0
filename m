From: Tobin Davis <tdavis@dsl-only.net>
Subject: Add missing array to conexant driver
Date: Mon, 20 Nov 2006 08:09:48 -0800
Message-ID: <1164038988.5390.212.camel@razman>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-eEwWnmK8jvUofj7KthDp"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-eEwWnmK8jvUofj7KthDp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds a missing array to the conexant driver.

Signed off by:  
-- 
Tobin Davis <tdavis@dsl-only.net>

--=-eEwWnmK8jvUofj7KthDp
Content-Disposition: attachment; filename=conexant-hg-test10.patch
Content-Type: text/x-patch; name=conexant-hg-test10.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -r 21f48c206e92 pci/hda/patch_conexant.c
--- a/pci/hda/patch_conexant.c	Thu Nov 16 17:24:20 2006 +0100
+++ b/pci/hda/patch_conexant.c	Sun Nov 19 00:07:45 2006 -0800
@@ -552,6 +552,9 @@ static hda_nid_t cxt5045_capsrc_nids[1] 
 static hda_nid_t cxt5045_capsrc_nids[1] = { 0x1a };
 #define CXT5045_SPDIF_OUT	0x13
 
+static struct hda_channel_mode cxt5045_modes[1] = {
+	{ 2, NULL },
+};
 
 static struct hda_input_mux cxt5045_capture_source = {
 	.num_items = 2,
@@ -842,6 +845,9 @@ static int patch_cxt5045(struct hda_code
 	spec->num_init_verbs = 1;
 	spec->init_verbs[0] = cxt5045_init_verbs;
 	spec->spdif_route = 0;
+	spec->num_channel_mode = ARRAY_SIZE(cxt5045_modes),
+	spec->channel_mode = cxt5045_modes,
+
 
 	codec->patch_ops = conexant_patch_ops;
 	codec->patch_ops.unsol_event = cxt5045_hp_unsol_event;
@@ -873,6 +879,9 @@ static hda_nid_t cxt5047_capsrc_nids[1] 
 static hda_nid_t cxt5047_capsrc_nids[1] = { 0x1a };
 #define CXT5047_SPDIF_OUT	0x11
 
+static struct hda_channel_mode cxt5047_modes[1] = {
+	{ 2, NULL },
+};
 
 static struct hda_input_mux cxt5047_capture_source = {
 	.num_items = 2,
@@ -1039,7 +1048,7 @@ static struct hda_verb cxt5047_init_verb
 	{0x17, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN|AC_PINCTL_VREF_50 },
 	/* HP, Amp  */
 	{0x13, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT },
-	{0x1A, AC_VERB_SET_CONNECT_SEL,0x01},
+	{0x1A, AC_VERB_SET_CONNECT_SEL,0x03},
 	{0x1A, AC_VERB_SET_AMP_GAIN_MUTE,
 	 AC_AMP_SET_OUTPUT|AC_AMP_SET_RIGHT|AC_AMP_SET_LEFT|0x00},
 	{0x1A, AC_VERB_SET_AMP_GAIN_MUTE,
@@ -1111,9 +1120,9 @@ static struct snd_kcontrol_new cxt5047_t
 	HDA_CODEC_VOLUME("CD Playback Volume", 0x19, 0x04, HDA_INPUT),
 	HDA_CODEC_MUTE("CD Playback Switch", 0x19, 0x04, HDA_INPUT),
 
+#if 0   
 	/* Controls for GPIO pins, assuming they exist and are configured as outputs */
 	CXT_GPIO_DATA_SWITCH("GPIO pin 0", 0x01, 0x01),
-#if 0   /* limit this to one GPIO pin for now */	
 	CXT_GPIO_DATA_SWITCH("GPIO pin 1", 0x01, 0x02),
 	CXT_GPIO_DATA_SWITCH("GPIO pin 2", 0x01, 0x04),
 	CXT_GPIO_DATA_SWITCH("GPIO pin 3", 0x01, 0x08),
@@ -1262,6 +1271,8 @@ static int patch_cxt5047(struct hda_code
 	spec->num_init_verbs = 1;
 	spec->init_verbs[0] = cxt5047_init_verbs;
 	spec->spdif_route = 0;
+	spec->num_channel_mode = ARRAY_SIZE(cxt5047_modes),
+	spec->channel_mode = cxt5047_modes,
 
 	codec->patch_ops = conexant_patch_ops;
 	codec->patch_ops.unsol_event = cxt5047_hp_unsol_event;

--=-eEwWnmK8jvUofj7KthDp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-eEwWnmK8jvUofj7KthDp
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-eEwWnmK8jvUofj7KthDp--
