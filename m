From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: BUG in >=1.0.13rc1
Date: Thu, 28 Dec 2006 13:13:07 -0800
Message-ID: <1167340387.9563.102.camel@localhost>
References: <20061227220022.GB28449@volumehost.com>
	<s5hodpoxja6.wl%tiwai@suse.de>  <1167330473.9563.83.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-GpilE/QhvpPpsWVMYK+f"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1167330473.9563.83.camel@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-GpilE/QhvpPpsWVMYK+f
Content-Type: multipart/alternative; boundary="=-iQEzuYSP4KuEfSMYi9o/"


--=-iQEzuYSP4KuEfSMYi9o/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Nope, this didn't fix the problem.

Here is what my testers are seeing:

ALSA /home/arojasp/Drivers/alsa-driver-1.0.14rc1patch/pci/hda/hda_codec.c:216: hda_codec: invalid dep_range_val 0:7fff
ALSA /home/arojasp/Drivers/alsa-driver-1.0.14rc1patch/pci/hda/hda_codec.c:216: hda_codec: invalid dep_range_val 0:7fff
ALSA /home/arojasp/Drivers/alsa-driver-1.0.14rc1patch/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:623: hda-intel: get_response timeout: IRS=0x0
.
. # repeated multiple times
.
ALSA /home/arojasp/Drivers/alsa-driver-1.0.14rc1patch/pci/hda/hda_codec.c:216: hda_codec: invalid dep_range_val 0:7fff
ALSA /home/arojasp/Drivers/alsa-driver-1.0.14rc1patch/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:623: hda-intel: get_response timeout: IRS=0x0
ALSA /home/arojasp/Drivers/alsa-driver-1.0.14rc1patch/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:623: hda-intel: get_response timeout: IRS=0x0
ALSA /home/arojasp/Drivers/alsa-driver-1.0.14rc1patch/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:683: hda_generic: no proper input path found
ALSA /home/arojasp/Drivers/alsa-driver-1.0.14rc1patch/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:431: hda_generic: no proper output path found
ALSA /home/arojasp/Drivers/alsa-driver-1.0.14rc1patch/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:1001: hda_generic: no PCM found

In further communications with one of the testers, a third phantom codec
is appearing with garbage data.

Codec: Generic ffff ID ffff
Address: 3
Vendor Id: 0xffffffff
Subsystem Id: 0xffffffff
Revision Id: 0xffffffff

They are getting this with and without my patch (even on
alsa-driver-1.0.13).  It appears that the system bios is adding this, as
it is there after a clean reboot.

Any ideas?

Tobin

On Thu, 2006-12-28 at 10:27 -0800, Tobin Davis wrote:

> This could also explain why my patch for the Stac9250 is breaking.
> 
> I've forwarded this fix to my testers.  Hope it fixes their systems.
> 
> On Thu, 2006-12-28 at 14:05 +0100, Takashi Iwai wrote:
> 
> > Could you try ALSA HG version?
> > There was a bug in hda_generic.c that may cause Oops, and got fixed
> > recently after 1.0.14rc1.
> > 
> > 
> > Takashi 
> 
> -- 
> Tobin Davis <tdavis@dsl-only.net>

-- 
Tobin Davis <tdavis@dsl-only.net>

--=-iQEzuYSP4KuEfSMYi9o/
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.0">
</HEAD>
<BODY>
Nope, this didn't fix the problem.<BR>
<BR>
Here is what my testers are seeing:<BR>
<BR>
<TT>ALSA /home/arojasp/Drivers/alsa-driver-1.0.14rc1patch/pci/hda/hda_codec.c:216: hda_codec: invalid dep_range_val 0:7fff</TT><BR>
<TT>ALSA /home/arojasp/Drivers/alsa-driver-1.0.14rc1patch/pci/hda/hda_codec.c:216: hda_codec: invalid dep_range_val 0:7fff</TT><BR>
<TT>ALSA /home/arojasp/Drivers/alsa-driver-1.0.14rc1patch/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:623: hda-intel: get_response timeout: IRS=0x0</TT><BR>
.<BR>
. # repeated multiple times<BR>
.<BR>
<TT>ALSA /home/arojasp/Drivers/alsa-driver-1.0.14rc1patch/pci/hda/hda_codec.c:216: hda_codec: invalid dep_range_val 0:7fff</TT><BR>
<TT>ALSA /home/arojasp/Drivers/alsa-driver-1.0.14rc1patch/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:623: hda-intel: get_response timeout: IRS=0x0</TT><BR>
<TT>ALSA /home/arojasp/Drivers/alsa-driver-1.0.14rc1patch/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:623: hda-intel: get_response timeout: IRS=0x0</TT><BR>
<TT>ALSA /home/arojasp/Drivers/alsa-driver-1.0.14rc1patch/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:683: hda_generic: no proper input path found</TT><BR>
<TT>ALSA /home/arojasp/Drivers/alsa-driver-1.0.14rc1patch/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:431: hda_generic: no proper output path found</TT><BR>
<TT>ALSA /home/arojasp/Drivers/alsa-driver-1.0.14rc1patch/pci/hda/../../alsa-kernel/pci/hda/hda_generic.c:1001: hda_generic: no PCM found</TT><BR>
<BR>
In further communications with one of the testers, a third phantom codec is appearing with garbage data.<BR>
<BR>
Codec: Generic ffff ID ffff<BR>
Address: 3<BR>
Vendor Id: 0xffffffff<BR>
Subsystem Id: 0xffffffff<BR>
Revision Id: 0xffffffff<BR>
<BR>
They are getting this with and without my patch (even on alsa-driver-1.0.13).&nbsp; It appears that the system bios is adding this, as it is there after a clean reboot.<BR>
<BR>
Any ideas?<BR>
<BR>
Tobin<BR>
<BR>
On Thu, 2006-12-28 at 10:27 -0800, Tobin Davis wrote:<BR>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">This could also explain why my patch for the Stac9250 is breaking.</FONT><BR>
    <BR>
    <FONT COLOR="#000000">I've forwarded this fix to my testers.&nbsp; Hope it fixes their systems.</FONT><BR>
    <BR>
    <FONT COLOR="#000000">On Thu, 2006-12-28 at 14:05 +0100, Takashi Iwai wrote:</FONT><BR>
    <BLOCKQUOTE TYPE=CITE>
        <TT><FONT COLOR="#000000">Could you try ALSA HG version?</FONT></TT><BR>
        <TT><FONT COLOR="#000000">There was a bug in hda_generic.c that may cause Oops, and got fixed</FONT></TT><BR>
        <TT><FONT COLOR="#000000">recently after 1.0.14rc1.</FONT></TT><BR>
        <BR>
        <BR>
        <TT><FONT COLOR="#000000">Takashi</FONT></TT><FONT COLOR="#000000"> </FONT><BR>
    </BLOCKQUOTE>
    <TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
-- <BR>
Tobin Davis &lt;<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>&gt;
</TD>
</TR>
</TABLE>
</BLOCKQUOTE>
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

--=-iQEzuYSP4KuEfSMYi9o/--

--=-GpilE/QhvpPpsWVMYK+f
Content-Disposition: attachment; filename=gateway-mp6954.patch.7
Content-Type: text/x-patch; name=gateway-mp6954.patch.7; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 9998aa91f5da pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Fri Dec 22 12:44:25 2006 +0100
+++ b/pci/hda/patch_sigmatel.c	Thu Dec 28 11:58:03 2006 -0800
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
 
@@ -408,6 +453,28 @@ static struct snd_pci_quirk stac9200_cfg
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
+	SND_PCI_QUIRK(PCI_VENDOR_ID_INTEL, 0x2668, "DFI LanParty", STAC_REF),
+	SND_PCI_QUIRK(0x107b, 0x0366, "Gateway MP6954", STAC_REF),
+	SND_PCI_QUIRK(0x107b, 0x0461, "Gateway NX560XL", STAC_REF),
+	SND_PCI_QUIRK(0x1002, 0x437b, "Gateway MX6453", STAC_REF),
 	{} /* terminator */
 };
 
@@ -1699,6 +1766,58 @@ static int patch_stac9200(struct hda_cod
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
+	} else if (stac925x_brd_tbl[spec->board_config] != NULL) {
+		spec->pin_configs = stac925x_brd_tbl[spec->board_config];
+		snd_printdd(KERN_INFO "STAC925x: setting config regs\n");
+		stac92xx_set_config_regs(codec);
+	}
+
+	spec->adc_nids = stac925x_adc_nids;
+	spec->mux_nids = stac925x_mux_nids;
+	spec->num_muxes = 1;
+	spec->num_dmics = 0;
+
+	snd_printdd(KERN_INFO "STAC925x: Init.\n");
+	spec->init = stac925x_core_init;
+	spec->mixer = stac925x_mixer;
+
+	spec->multiout.dac_nids = spec->dac_nids;
+
+	snd_printdd(KERN_INFO "STAC925x: Parsing autoconfig.\n");
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
@@ -2149,6 +2268,12 @@ struct hda_codec_preset snd_hda_preset_s
  	{ .id = 0x83847627, .name = "STAC9271D", .patch = patch_stac927x },
  	{ .id = 0x83847628, .name = "STAC9274X5NH", .patch = patch_stac927x },
  	{ .id = 0x83847629, .name = "STAC9274D5NH", .patch = patch_stac927x },
+	{ .id = 0x83847632, .name = "STAC9202",  .patch = patch_stac925x },
+	{ .id = 0x83847633, .name = "STAC9202D", .patch = patch_stac925x },
+	{ .id = 0x83847634, .name = "STAC9250",  .patch = patch_stac925x },
+	{ .id = 0x83847635, .name = "STAC9250D", .patch = patch_stac925x },
+	{ .id = 0x83847636, .name = "STAC9251",  .patch = patch_stac925x },
+	{ .id = 0x83847637, .name = "STAC9250D", .patch = patch_stac925x },
  	/* The following does not take into account .id=0x83847661 when subsys =
  	 * 104D0C00 which is STAC9225s. Because of this, some SZ Notebooks are
  	 * currently not fully supported.

--=-GpilE/QhvpPpsWVMYK+f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-GpilE/QhvpPpsWVMYK+f
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-GpilE/QhvpPpsWVMYK+f--
