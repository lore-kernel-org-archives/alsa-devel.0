From: Tobin Davis <tdavis@dsl-only.net>
Subject: Sigmatel STAC9250 (7634) test patch 6
Date: Tue, 12 Dec 2006 08:42:21 -0800
Message-ID: <1165941741.4142.10.camel@razman>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-pxt2A3w67v8/hAbFVTan"
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-pxt2A3w67v8/hAbFVTan
Content-Type: multipart/alternative; boundary="=-flRtu0itnJf6T43sp2bc"


--=-flRtu0itnJf6T43sp2bc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Copied to alsa-devel for archival purposes, hints, suggestions, etc.

Testers:
I've made a few minor adjustments to the initialization code.  Try this
and get back to me.

To apply this patch, download
ftp://ftp.alsa-project.org/pub/driver/alsa-driver-1.0.14rc1.tar.bz2, and
type:
tar -jxvf alsa-driver-1.0.14rc1.tar.bz2
cd alsa-driver-1.0.14rc1/alsa-kernel
patch -p1 <gateway-mp6954.patch.6
cd ..
./configure --with-cards=hda-intel --with-debug=detect ; make
su  # need root access for rest
make install
dmesg -c >/dev/null
modprobe -r snd-hda-intel
modprobe snd-hda-intel
dmesg >dmesg.out  # I need this info if it doesn't work

Now, try alsamixer, play some audio, and try recording.  Let me know
what works and what doesn't.  If nothing works or you get an error, try
reloading with "modprobe -r snd-hda-intel ; modprobe snd-hda-intel
model=ref".

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-flRtu0itnJf6T43sp2bc
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
Copied to alsa-devel for archival purposes, hints, suggestions, etc.<BR>
<BR>
Testers:<BR>
I've made a few minor adjustments to the initialization code.&nbsp; Try this and get back to me.<BR>
<BR>
To apply this patch, download <A HREF="ftp://ftp.alsa-project.org/pub/driver/alsa-driver-1.0.14rc1.tar.bz2,">ftp://ftp.alsa-project.org/pub/driver/alsa-driver-1.0.14rc1.tar.bz2,</A> and type:<BR>
tar -jxvf alsa-driver-1.0.14rc1.tar.bz2<BR>
cd alsa-driver-1.0.14rc1/alsa-kernel<BR>
patch -p1 &lt;gateway-mp6954.patch.6<BR>
cd ..<BR>
./configure --with-cards=hda-intel --with-debug=detect ; make<BR>
su&nbsp; # need root access for rest<BR>
make install<BR>
dmesg -c &gt;/dev/null<BR>
modprobe -r snd-hda-intel<BR>
modprobe snd-hda-intel<BR>
dmesg &gt;dmesg.out&nbsp; # I need this info if it doesn't work<BR>
<BR>
Now, try alsamixer, play some audio, and try recording.&nbsp; Let me know what works and what doesn't.&nbsp; If nothing works or you get an error, try reloading with &quot;modprobe -r snd-hda-intel ; modprobe snd-hda-intel model=ref&quot;.<BR>
<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
-- <BR>
Tobin Davis &lt;<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>&gt;
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-flRtu0itnJf6T43sp2bc--

--=-pxt2A3w67v8/hAbFVTan
Content-Disposition: attachment; filename=gateway-mp6954.patch.6
Content-Type: text/x-patch; name=gateway-mp6954.patch.6; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -r 1ede4dc9b6ea pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Sun Dec 10 00:00:38 2006 +0000
+++ b/pci/hda/patch_sigmatel.c	Tue Dec 12 08:35:12 2006 -0800
@@ -48,6 +48,11 @@ enum {
 };
 
 enum {
+	STAC_925x_REF,
+	STAC_925x_MODELS
+};
+
+enum {
 	STAC_D945_REF,
 	STAC_D945GTP3,
 	STAC_D945GTP5,
@@ -129,6 +134,18 @@ static hda_nid_t stac9200_dac_nids[1] = 
         0x02,
 };
 
+static hda_nid_t stac925x_adc_nids[1] = {
+        0x03,
+};
+
+static hda_nid_t stac925x_mux_nids[1] = {
+        0x0f,
+};
+
+static hda_nid_t stac925x_dac_nids[1] = {
+        0x02,
+};
+
 static hda_nid_t stac922x_adc_nids[2] = {
         0x06, 0x07,
 };
@@ -160,6 +177,11 @@ static hda_nid_t stac9200_pin_nids[8] = 
 static hda_nid_t stac9200_pin_nids[8] = {
 	0x08, 0x09, 0x0d, 0x0e, 
 	0x0f, 0x10, 0x11, 0x12,
+};
+
+static hda_nid_t stac925x_pin_nids[8] = {
+	0x07, 0x08, 0x0a, 0x0b, 
+	0x0c, 0x0d, 0x10, 0x11,
 };
 
 static hda_nid_t stac922x_pin_nids[10] = {
@@ -238,6 +260,12 @@ static struct hda_verb stac9200_core_ini
 static struct hda_verb stac9200_core_init[] = {
 	/* set dac0mux for dac converter */
 	{ 0x07, AC_VERB_SET_CONNECT_SEL, 0x00},
+	{}
+};
+
+static struct hda_verb stac925x_core_init[] = {
+	/* set dac0mux for dac converter */
+	{ 0x06, AC_VERB_SET_CONNECT_SEL, 0x00},
 	{}
 };
 
@@ -283,6 +311,23 @@ static struct snd_kcontrol_new stac9200_
 	HDA_CODEC_VOLUME("Capture Volume", 0x0a, 0, HDA_OUTPUT),
 	HDA_CODEC_MUTE("Capture Switch", 0x0a, 0, HDA_OUTPUT),
 	HDA_CODEC_VOLUME("Capture Mux Volume", 0x0c, 0, HDA_OUTPUT),
+	{ } /* end */
+};
+
+static struct snd_kcontrol_new stac925x_mixer[] = {
+	HDA_CODEC_VOLUME("Master Playback Volume", 0xe, 0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Master Playback Switch", 0xe, 0, HDA_OUTPUT),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Input Source",
+		.count = 1,
+		.info = stac92xx_mux_enum_info,
+		.get = stac92xx_mux_enum_get,
+		.put = stac92xx_mux_enum_put,
+	},
+	HDA_CODEC_VOLUME("Capture Volume", 0x09, 0, HDA_OUTPUT),
+	HDA_CODEC_MUTE("Capture Switch", 0x09, 0, HDA_OUTPUT),
+	HDA_CODEC_VOLUME("Capture Mux Volume", 0x0f, 0, HDA_OUTPUT),
 	{ } /* end */
 };
 
@@ -408,6 +453,32 @@ static struct snd_pci_quirk stac9200_cfg
 		      "Dell Latitude D620", STAC_REF),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x01cb,
 		      "Dell Latitude 120L", STAC_REF),
+	{} /* terminator */
+};
+
+static unsigned int ref925x_pin_configs[8] = {
+	0x40c003f0, 0x424503f2, 0x01813022, 0x02a19021,
+	0x90a70320, 0x02214210, 0x400003f1, 0x9033032e,
+};
+
+static unsigned int *stac925x_brd_tbl[STAC_925x_MODELS] = {
+	[STAC_REF] = ref925x_pin_configs,
+};
+
+static const char *stac925x_models[STAC_925x_MODELS] = {
+	[STAC_REF] = "ref",
+};
+
+static struct snd_pci_quirk stac925x_cfg_tbl[] = {
+	/* SigmaTel reference board */
+	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668,
+		      "DFI LanParty", STAC_REF),
+	SND_PCI_QUIRK(0x107b, 0x0366, "Gateway MP6954",
+			STAC_REF),
+	SND_PCI_QUIRK(0x107b, 0x0461, "Gateway NX560XL",
+			STAC_REF),
+	SND_PCI_QUIRK(0x1002, 0x437b, "Gateway MX6453",
+			STAC_REF),
 	{} /* terminator */
 };
 
@@ -1699,6 +1770,56 @@ static int patch_stac9200(struct hda_cod
 	return 0;
 }
 
+static int patch_stac925x(struct hda_codec *codec)
+{
+	struct sigmatel_spec *spec;
+	int err;
+
+	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (spec == NULL)
+		return -ENOMEM;
+
+	codec->spec = spec;
+	spec->num_pins = 8;
+	spec->pin_nids = stac925x_pin_nids;
+	spec->board_config = snd_hda_check_board_config(codec, STAC_925x_MODELS,
+							stac925x_models,
+							stac925x_cfg_tbl);
+	if (spec->board_config < 0) {
+		snd_printdd(KERN_INFO "hda_codec: Unknown model for STAC925x, using BIOS defaults\n");
+		err = stac92xx_save_bios_config_regs(codec);
+		if (err < 0) {
+			stac92xx_free(codec);
+			return err;
+		}
+		spec->pin_configs = spec->bios_pin_configs;
+	} else {
+		spec->pin_configs = stac925x_brd_tbl[spec->board_config];
+		stac92xx_set_config_regs(codec);
+	}
+
+	spec->multiout.max_channels = 2;
+	spec->multiout.num_dacs = 1;
+	spec->multiout.dac_nids = stac925x_dac_nids;
+	spec->adc_nids = stac925x_adc_nids;
+	spec->mux_nids = stac925x_mux_nids;
+	spec->num_muxes = 1;
+	spec->num_dmics = 0;
+
+	spec->init = stac925x_core_init;
+	spec->mixer = stac925x_mixer;
+
+	err = stac92xx_parse_auto_config(codec, 0x8, 0x7);
+	if (err < 0) {
+		stac92xx_free(codec);
+		return err;
+	}
+
+	codec->patch_ops = stac92xx_patch_ops;
+
+	return 0;
+}
+
 static int patch_stac922x(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec;
@@ -2137,6 +2258,10 @@ struct hda_codec_preset snd_hda_preset_s
  	{ .id = 0x83847627, .name = "STAC9271D", .patch = patch_stac927x },
  	{ .id = 0x83847628, .name = "STAC9274X5NH", .patch = patch_stac927x },
  	{ .id = 0x83847629, .name = "STAC9274D5NH", .patch = patch_stac927x },
+	{ .id = 0x83847634, .name = "STAC9250", .patch = patch_stac925x },
+	{ .id = 0x83847635, .name = "STAC9250D", .patch = patch_stac925x },
+	{ .id = 0x83847636, .name = "STAC9251", .patch = patch_stac925x },
+	{ .id = 0x83847637, .name = "STAC9250D", .patch = patch_stac925x },
  	/* The following does not take into account .id=0x83847661 when subsys =
  	 * 104D0C00 which is STAC9225s. Because of this, some SZ Notebooks are
  	 * currently not fully supported.

--=-pxt2A3w67v8/hAbFVTan
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-pxt2A3w67v8/hAbFVTan
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-pxt2A3w67v8/hAbFVTan--
