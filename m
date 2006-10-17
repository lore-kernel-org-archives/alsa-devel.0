From: Tobin Davis <tdavis@dsl-only.net>
Subject: Patch from Realtek alsa tree.
Date: Mon, 16 Oct 2006 18:59:59 -0700
Message-ID: <1161050399.14329.49.camel@razman>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-YNNtYK/bVbrQDZWdTAOC"
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


--=-YNNtYK/bVbrQDZWdTAOC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Summary: Patch sync from RealTek.

Description:
        This patch adds support for Toshiba laptops.  Code is from
        RealTek's alsa-driver-1.0.12-4.05b tree.
        
Signed off by:
-- 
Tobin Davis <tdavis@dsl-only.net>

--=-YNNtYK/bVbrQDZWdTAOC
Content-Disposition: attachment; filename=toshiba.patch
Content-Type: text/x-patch; name=toshiba.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -r 45560ff5ca98 Documentation/ALSA-Configuration.txt
--- a/Documentation/ALSA-Configuration.txt	Mon Oct 16 21:19:48 2006 +0200
+++ b/Documentation/ALSA-Configuration.txt	Mon Oct 16 18:56:51 2006 -0700
@@ -831,6 +831,7 @@ Prior to version 0.9.0rc4 options had a 
 	  6stack-dig	6-jack with SPDIF I/O
 	  3stack-660	3-jack (for ALC660)
 	  uniwill-m31	Uniwill M31 laptop
+	  toshiba	Toshiba laptop support
 	  auto		auto-config reading BIOS (default)
 
 	CMI9880
diff -r 45560ff5ca98 pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Mon Oct 16 21:19:48 2006 +0200
+++ b/pci/hda/patch_realtek.c	Mon Oct 16 18:56:51 2006 -0700
@@ -91,6 +91,7 @@ enum {
 	ALC861_3ST_DIG,
 	ALC861_6ST_DIG,
 	ALC861_UNIWILL_M31,
+	ALC861_TOSHIBA,
 	ALC861_AUTO,
 	ALC861_MODEL_LAST,
 };
@@ -6202,7 +6203,29 @@ static struct snd_kcontrol_new alc861_3S
                 .private_value = ARRAY_SIZE(alc861_threestack_modes),
 	},
 	{ } /* end */
-};			
+};
+
+static snd_kcontrol_new_t alc861_toshiba_mixer[] = {
+        /* output mixer control */
+	HDA_CODEC_MUTE("Master Playback Switch", 0x03, 0x0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Mic Playback Volume", 0x15, 0x01, HDA_INPUT),
+	HDA_CODEC_MUTE("Mic Playback Switch", 0x15, 0x01, HDA_INPUT),
+	
+        /*Capture mixer control */
+	HDA_CODEC_VOLUME("Capture Volume", 0x08, 0x0, HDA_INPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x08, 0x0, HDA_INPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Capture Source",
+		.count = 1,
+		.info = alc_mux_enum_info,
+		.get = alc_mux_enum_get,
+		.put = alc_mux_enum_put,
+	},
+
+	{ } /* end */
+};	
+
 static struct snd_kcontrol_new alc861_uniwill_m31_mixer[] = {
         /* output mixer control */
 	HDA_CODEC_MUTE("Front Playback Switch", 0x03, 0x0, HDA_OUTPUT),
@@ -6485,6 +6508,39 @@ static struct hda_verb alc861_auto_init_
 	{ }
 };
 
+static struct hda_verb alc861_toshiba_init_verbs[] = {
+	{0x0f, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | ALC880_HP_EVENT},
+        
+	{ }
+};
+
+/* toggle speaker-output according to the hp-jack state */
+static void alc861_toshiba_automute(struct hda_codec *codec)
+{
+ 	unsigned int present;
+ 
+ 	present = snd_hda_codec_read(codec, 0x0f, 0,
+				     AC_VERB_GET_PIN_SENSE, 0) & 0x80000000;
+	snd_hda_codec_amp_update(codec, 0x16, 0, HDA_INPUT, 0,
+				 0x80, present ? 0x80 : 0);
+	snd_hda_codec_amp_update(codec, 0x16, 1, HDA_INPUT, 0,
+				 0x80, present ? 0x80 : 0);
+	snd_hda_codec_amp_update(codec, 0x1a, 0, HDA_INPUT, 3,
+				 0x80, present ? 0 : 0x80);
+	snd_hda_codec_amp_update(codec, 0x1a, 1, HDA_INPUT, 3,
+				 0x80, present ? 0 : 0x80);
+}
+
+static void alc861_toshiba_unsol_event(struct hda_codec *codec, unsigned int res)
+{
+	/* Looks like the unsol event is incompatible with the standard
+	 * definition.  6bit tag is placed at 26 bit!
+	 */
+	if ((res >> 26) == ALC880_HP_EVENT) {
+		alc861_toshiba_automute(codec);
+	}
+}
+
 /* pcm configuration: identiacal with ALC880 */
 #define alc861_pcm_analog_playback	alc880_pcm_analog_playback
 #define alc861_pcm_analog_capture	alc880_pcm_analog_capture
@@ -6770,6 +6826,12 @@ static struct hda_board_config alc861_cf
 	{ .modelname = "uniwill-m31", .config = ALC861_UNIWILL_M31},
 	{ .pci_subvendor = 0x1584, .pci_subdevice = 0x9072,
 	  .config = ALC861_UNIWILL_M31 },
+	{ .modelname = "", .config = ALC861_UNIWILL_M31},
+	{ .pci_subvendor = 0x1043, .pci_subdevice = 0x1338,
+	  .config = ALC861_TOSHIBA },
+	{ .modelname = "toshiba", .config = ALC861_TOSHIBA },
+	{ .pci_subvendor = 0x1179, .pci_subdevice = 0xff10,
+	  .config = ALC861_TOSHIBA },
 	{ .modelname = "auto", .config = ALC861_AUTO },
 	{}
 };
@@ -6837,7 +6899,19 @@ static struct alc_config_preset alc861_p
 		.adc_nids = alc861_adc_nids,
 		.input_mux = &alc861_capture_source,
 	},
-
+	[ALC861_TOSHIBA] = {
+		.mixers = { alc861_toshiba_mixer },
+		.init_verbs = { alc861_base_init_verbs, alc861_toshiba_init_verbs },
+		.num_dacs = ARRAY_SIZE(alc861_dac_nids),
+		.dac_nids = alc861_dac_nids,
+		.num_channel_mode = ARRAY_SIZE(alc883_3ST_2ch_modes),
+		.channel_mode = alc883_3ST_2ch_modes,
+		.num_adc_nids = ARRAY_SIZE(alc861_adc_nids),
+		.adc_nids = alc861_adc_nids,
+		.input_mux = &alc861_capture_source,
+		.unsol_event = alc861_toshiba_unsol_event,
+		.init_hook = alc861_toshiba_automute,
+	},
 };	
 
 

--=-YNNtYK/bVbrQDZWdTAOC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-YNNtYK/bVbrQDZWdTAOC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-YNNtYK/bVbrQDZWdTAOC--
