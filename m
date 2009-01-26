From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] hda: 92hd71xxx disable unmute support for
 codecs that don't have input amps.
Date: Mon, 26 Jan 2009 09:33:52 -0500
Message-ID: <497DC9D0.7070805@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id EE01B2438B
	for <alsa-devel@alsa-project.org>; Mon, 26 Jan 2009 15:34:07 +0100 (CET)
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

Some revisions of the 92hd71xxx codec families don't have input amps on ports
0xa, 0xd and 0xf, so probe the widget caps on port 0xa and check for support,
if found run snd_hda_sequence_write_cache() on the stac92hd71xxx_unmute_core_init
verb list.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
 sound/pci/hda/patch_sigmatel.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 80a4c28..ffef091 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -858,26 +858,25 @@ static struct hda_verb stac92hd83xxx_core_init[] = {
 static struct hda_verb stac92hd71bxx_core_init[] = {
 	/* set master volume and direct control */
 	{ 0x28, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
-	/* unmute right and left channels for nodes 0x0a, 0xd, 0x0f */
-	{ 0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{ 0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
-	{ 0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{}
 };
 
-#define HD_DISABLE_PORTF 2
+#define HD_DISABLE_PORTF 1
 static struct hda_verb stac92hd71bxx_analog_core_init[] = {
 	/* start of config #1 */
 
 	/* connect port 0f to audio mixer */
 	{ 0x0f, AC_VERB_SET_CONNECT_SEL, 0x2},
-	/* unmute right and left channels for node 0x0f */
-	{ 0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	/* start of config #2 */
 
 	/* set master volume and direct control */
 	{ 0x28, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
-	/* unmute right and left channels for nodes 0x0a, 0xd */
+	{}
+};
+
+static struct hda_verb stac92hd71bxx_unmute_core_init[] = {
+	/* unmute right and left channels for nodes 0x0f, 0xa, 0x0d */
+	{ 0x0f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{ 0x0a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{ 0x0d, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(0)},
 	{}
@@ -4942,6 +4941,7 @@ static struct hda_input_mux stac92hd71bxx_dmux = {
 static int patch_stac92hd71bxx(struct hda_codec *codec)
 {
 	struct sigmatel_spec *spec;
+	struct hda_verb *unmute_init = stac92hd71bxx_unmute_core_init;
 	int err = 0;
 
 	spec  = kzalloc(sizeof(*spec), GFP_KERNEL);
@@ -5015,6 +5015,7 @@ again:
 
 		/* disable VSW */
 		spec->init = &stac92hd71bxx_analog_core_init[HD_DISABLE_PORTF];
+		unmute_init++;
 		stac_change_pin_config(codec, 0xf, 0x40f000f0);
 		break;
 	case 0x111d7603: /* 6 Port with Analog Mixer */
@@ -5031,6 +5032,9 @@ again:
 		codec->slave_dig_outs = stac92hd71bxx_slave_dig_outs;
 	}
 
+	if (get_wcaps(codec, 0xa) & AC_WCAP_IN_AMP)
+		snd_hda_sequence_write_cache(codec, unmute_init);
+
 	spec->aloopback_mask = 0x50;
 	spec->aloopback_shift = 0;
 
-- 
1.5.6.3
