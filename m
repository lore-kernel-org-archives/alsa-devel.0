From: David Henningsson <david.henningsson@canonical.com>
Subject: [RFC PATCH] Inverted internal mic
Date: Tue, 28 Feb 2012 09:57:56 +0100
Message-ID: <4F4C9714.1080307@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080406020609030400030200"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id E31DC24591
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 09:57:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: 903853@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080406020609030400030200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

One of the more common problems on laptop machines, is that the internal 
mic provides a stereo signal but with one channel phase inverted, or 
differential output.

This means problems for applications recording two channels but later 
merging them into one, leaving them with zero or near-zero output.

There are various ways we can work around this in both the kernel, 
alsa-lib and PulseAudio layers. It's a matter of picking the right one. 
I'm leaning towards trying to fix it in the kernel's codec drivers, because
1) we already have quirking infrastructure there
2) we already have some working quirks already in that layer
3) it would benefit other sound applications that use ALSA directly.

The downside to that is really that we're silencing out one channel for
everyone, leading to no application being able to use both channels, 
even if they would implement some kind of 
"auto-detect-and-reverse-one-channel" functionality.

For the most part, this has been some Acer Aspire machines running 
Realtek ALC268 / ALC269 / ALC271X / ALC272X, and for two of these we 
have proc coefs we can set, but for the other two these proc coefs, if 
they exist, are unknown to us.

Recently I came across a Conexant as well, and I decided to write a 
patch for it, that would take the approach that the internal mic is 
forced mono on the kcontrol, and make sure the right channel is always 
muted. The patch is verified by the reporter to fix this problem. It 
could use some perfection though - it would make sense to to the same to 
the internal mic boost as well, and the strcmp('Internal Mic') call 
could maybe be turned into something more elegant. But before going 
ahead with that, I'd like to hear your opinion on the matter, if you 
agree that this is a good approach to the problem?

References:

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/903853/+attachment/2631623/+files/alsa-info.txt.VmCN7lMBL4

https://bugs.launchpad.net/bugs/903853

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------080406020609030400030200
Content-Type: text/x-patch;
 name="0001-Fix-internal-mic-for-Lenovo-Ideapad-U300s.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Fix-internal-mic-for-Lenovo-Ideapad-U300s.patch"

>From 3ef2a105a85195c14e25190bca53bb55260feffa Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Fri, 24 Feb 2012 14:57:44 +0100
Subject: [PATCH] Fix internal mic for Lenovo Ideapad U300s

The internal mic input is phase inverted on one channel.
To avoid people in userspace summing the channels together
and get zero result, mute the right channel and make sure
they can't unmute it.

BugLink: https://bugs.launchpad.net/bugs/903853
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |   41 +++++++++++++++++++++++++++++----------
 1 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 266e5a6..4a05817 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -140,6 +140,7 @@ struct conexant_spec {
 	unsigned int asus:1;
 	unsigned int pin_eapd_ctrls:1;
 	unsigned int single_adc_amp:1;
+	unsigned int fixup_stereo_dmic:1;
 
 	unsigned int adc_switching:1;
 
@@ -4044,7 +4045,7 @@ static int cx_auto_init(struct hda_codec *codec)
 
 static int cx_auto_add_volume_idx(struct hda_codec *codec, const char *basename,
 			      const char *dir, int cidx,
-			      hda_nid_t nid, int hda_dir, int amp_idx)
+			      hda_nid_t nid, int hda_dir, int amp_idx, int chs)
 {
 	static char name[32];
 	static struct snd_kcontrol_new knew[] = {
@@ -4056,7 +4057,7 @@ static int cx_auto_add_volume_idx(struct hda_codec *codec, const char *basename,
 
 	for (i = 0; i < 2; i++) {
 		struct snd_kcontrol *kctl;
-		knew[i].private_value = HDA_COMPOSE_AMP_VAL(nid, 3, amp_idx,
+		knew[i].private_value = HDA_COMPOSE_AMP_VAL(nid, chs, amp_idx,
 							    hda_dir);
 		knew[i].subdevice = HDA_SUBDEV_AMP_FLAG;
 		knew[i].index = cidx;
@@ -4074,7 +4075,7 @@ static int cx_auto_add_volume_idx(struct hda_codec *codec, const char *basename,
 }
 
 #define cx_auto_add_volume(codec, str, dir, cidx, nid, hda_dir)		\
-	cx_auto_add_volume_idx(codec, str, dir, cidx, nid, hda_dir, 0)
+	cx_auto_add_volume_idx(codec, str, dir, cidx, nid, hda_dir, 0, 3)
 
 #define cx_auto_add_pb_volume(codec, nid, str, idx)			\
 	cx_auto_add_volume(codec, str, " Playback", idx, nid, HDA_OUTPUT)
@@ -4152,14 +4153,22 @@ static int cx_auto_add_capture_volume(struct hda_codec *codec, hda_nid_t nid,
 	int i;
 
 	for (i = 0; i < spec->num_adc_nids; i++) {
+		int chs = 3;
 		hda_nid_t adc_nid = spec->adc_nids[i];
 		int idx = get_input_connection(codec, adc_nid, nid);
 		if (idx < 0)
 			continue;
 		if (spec->single_adc_amp)
 			idx = 0;
+
+		if (spec->fixup_stereo_dmic && (strcmp("Internal Mic", label) == 0)) {
+			/* Make left channel controllable and right channel muted */
+			chs = 1;
+			snd_hda_codec_write_cache(codec, adc_nid, 0, AC_VERB_SET_AMP_GAIN_MUTE, 
+				AC_AMP_SET_RIGHT | AC_AMP_SET_INPUT | (idx << AC_AMP_SET_INDEX_SHIFT) | AC_AMP_MUTE);
+		}
 		return cx_auto_add_volume_idx(codec, label, pfx,
-					      cidx, adc_nid, HDA_INPUT, idx);
+					      cidx, adc_nid, HDA_INPUT, idx, chs);
 	}
 	return 0;
 }
@@ -4335,22 +4344,30 @@ static void apply_pincfg(struct hda_codec *codec, const struct cxt_pincfg *cfg)
 
 }
 
-static void apply_pin_fixup(struct hda_codec *codec,
+enum {
+	CXT_PINCFG_LENOVO_X200,
+	CXT_FIXUP_STEREO_DMIC,
+};
+
+static void apply_fixup(struct hda_codec *codec,
 			    const struct snd_pci_quirk *quirk,
 			    const struct cxt_pincfg **table)
 {
+	struct conexant_spec *spec = codec->spec;
+
 	quirk = snd_pci_quirk_lookup(codec->bus->pci, quirk);
-	if (quirk) {
+	if (quirk && table[quirk->value]) {
 		snd_printdd(KERN_INFO "hda_codec: applying pincfg for %s\n",
 			    quirk->name);
 		apply_pincfg(codec, table[quirk->value]);
 	}
+	if (quirk->value == CXT_FIXUP_STEREO_DMIC) {
+		snd_printdd(KERN_INFO "hda_codec: applying internal mic workaround for %s\n",
+			    quirk->name);
+		spec->fixup_stereo_dmic = 1;
+	}
 }
 
-enum {
-	CXT_PINCFG_LENOVO_X200,
-};
-
 static const struct cxt_pincfg cxt_pincfg_lenovo_x200[] = {
 	{ 0x16, 0x042140ff }, /* HP (seq# overridden) */
 	{ 0x17, 0x21a11000 }, /* dock-mic */
@@ -4360,10 +4377,12 @@ static const struct cxt_pincfg cxt_pincfg_lenovo_x200[] = {
 
 static const struct cxt_pincfg *cxt_pincfg_tbl[] = {
 	[CXT_PINCFG_LENOVO_X200] = cxt_pincfg_lenovo_x200,
+	[CXT_FIXUP_STEREO_DMIC] = NULL,
 };
 
 static const struct snd_pci_quirk cxt_fixups[] = {
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo X200", CXT_PINCFG_LENOVO_X200),
+	SND_PCI_QUIRK(0x17aa, 0x3975, "Lenovo U300s", CXT_FIXUP_STEREO_DMIC),
 	{}
 };
 
@@ -4387,7 +4406,7 @@ static int patch_conexant_auto(struct hda_codec *codec)
 		break;
 	}
 
-	apply_pin_fixup(codec, cxt_fixups, cxt_pincfg_tbl);
+	apply_fixup(codec, cxt_fixups, cxt_pincfg_tbl);
 
 	err = cx_auto_search_adcs(codec);
 	if (err < 0)
-- 
1.7.9


--------------080406020609030400030200
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080406020609030400030200--
