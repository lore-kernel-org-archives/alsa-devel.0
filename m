From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH1/1] hda: digital slave support for IDT codecs
Date: Mon, 08 Sep 2008 11:20:05 -0400
Message-ID: <48C542A5.9020106@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id D55F324399
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 17:20:12 +0200 (CEST)
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

Added slave_dig_outs entries for several IDT codecs that have multiple
SPDIF outs, and enabled these SPDIF outs in several pin configs.

---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index ee24a0d..655a87c 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -235,6 +235,10 @@ static hda_nid_t stac92hd73xx_pwr_nids[8] = {
 	0x0f, 0x10, 0x11
 };

+static hda_nid_t stac92hd73xx_slave_dig_outs[2] = {
+	0x26, 0,
+};
+
 static hda_nid_t stac92hd73xx_adc_nids[2] = {
 	0x1a, 0x1b
 };
@@ -284,6 +288,10 @@ static hda_nid_t stac92hd83xxx_pwr_nids[4] = {
 	0xa, 0xb, 0xd, 0xe,
 };

+static hda_nid_t stac92hd83xxx_slave_dig_outs[2] = {
+	0x1e, 0,
+};
+
 static unsigned int stac92hd83xxx_pwr_mapping[4] = {
 	0x03, 0x0c, 0x10, 0x40,
 };
@@ -317,6 +325,10 @@ static hda_nid_t stac92hd71bxx_dmic_nids[STAC92HD71BXX_NUM_DMICS + 1] = {
 	0x18, 0x19, 0
 };

+static hda_nid_t stac92hd71bxx_slave_dig_outs[2] = {
+	0x22, 0
+};
+
 static hda_nid_t stac925x_adc_nids[1] = {
         0x03,
 };
@@ -418,9 +430,10 @@ static hda_nid_t stac92hd83xxx_pin_nids[14] = {
 	0x0f, 0x10, 0x11, 0x12, 0x13,
 	0x1d, 0x1e, 0x1f, 0x20
 };
-static hda_nid_t stac92hd71bxx_pin_nids[10] = {
+static hda_nid_t stac92hd71bxx_pin_nids[11] = {
 	0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
 	0x0f, 0x14, 0x18, 0x19, 0x1e,
+	0x1f,
 };

 static hda_nid_t stac927x_pin_nids[14] = {
@@ -1492,22 +1505,22 @@ static struct snd_pci_quirk stac92hd83xxx_cfg_tbl[] = {
 		      "DFI LanParty", STAC_92HD71BXX_REF),
 };

-static unsigned int ref92hd71bxx_pin_configs[10] = {
+static unsigned int ref92hd71bxx_pin_configs[11] = {
 	0x02214030, 0x02a19040, 0x01a19020, 0x01014010,
 	0x0181302e, 0x01114010, 0x01019020, 0x90a000f0,
-	0x90a000f0, 0x01452050,
+	0x90a000f0, 0x01452050, 0x01452050,
 };

-static unsigned int dell_m4_1_pin_configs[10] = {
+static unsigned int dell_m4_1_pin_configs[11] = {
 	0x0421101f, 0x04a11221, 0x40f000f0, 0x90170110,
 	0x23a1902e, 0x23014250, 0x40f000f0, 0x90a000f0,
-	0x40f000f0, 0x4f0000f0,
+	0x40f000f0, 0x4f0000f0, 0x4f0000f0,
 };

-static unsigned int dell_m4_2_pin_configs[10] = {
+static unsigned int dell_m4_2_pin_configs[11] = {
 	0x0421101f, 0x04a11221, 0x90a70330, 0x90170110,
 	0x23a1902e, 0x23014250, 0x40f000f0, 0x40f000f0,
-	0x40f000f0, 0x044413b0,
+	0x40f000f0, 0x044413b0, 0x044413b0,
 };

 static unsigned int *stac92hd71bxx_brd_tbl[STAC_92HD71BXX_MODELS] = {
@@ -3984,6 +3997,7 @@ static int patch_stac92hd83xxx(struct hda_codec *codec)
 		return -ENOMEM;

 	codec->spec = spec;
+	codec->slave_dig_outs = stac92hd83xxx_slave_dig_outs;
 	spec->mono_nid = 0x19;
 	spec->digbeep_nid = 0x21;
 	spec->dmic_nids = stac92hd83xxx_dmic_nids;
@@ -4134,6 +4148,7 @@ again:
 	case 0x111d76b5:
 		spec->mixer = stac92hd71bxx_mixer;
 		spec->init = stac92hd71bxx_core_init;
+		codec->slave_dig_outs = stac92hd71bxx_slave_dig_outs;
 		break;
 	case 0x111d7608: /* 5 Port with Analog Mixer */
 		if ((codec->revision_id & 0xf) == 0 ||
@@ -4166,6 +4181,7 @@ again:
 	default:
 		spec->mixer = stac92hd71bxx_analog_mixer;
 		spec->init = stac92hd71bxx_analog_core_init;
+		codec->slave_dig_outs = stac92hd71bxx_slave_dig_outs;
 	}

 	spec->aloopback_mask = 0x20;
