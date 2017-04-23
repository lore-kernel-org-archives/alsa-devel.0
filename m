From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/4] ALSA: hda - Allow to enable/disable
	vmaster build explicitly
Date: Sun, 23 Apr 2017 21:00:23 +0200
Message-ID: <20170423190025.28911-3-tiwai@suse.de>
References: <20170423190025.28911-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A7AE8266ABB
 for <alsa-devel@alsa-project.org>; Sun, 23 Apr 2017 21:00:32 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 9FDF0AB46
 for <alsa-devel@alsa-project.org>; Sun, 23 Apr 2017 19:00:32 +0000 (UTC)
In-Reply-To: <20170423190025.28911-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Another preliminary patch for the dual-codec support: since the
support of vmaster over multiple codecs is difficult, simply disable
it by a new flag to hda_codec struct.  A new user hint is added as
well for consistency.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/hd-audio/notes.rst | 2 ++
 sound/pci/hda/hda_generic.c            | 7 +++++--
 sound/pci/hda/hda_generic.h            | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/hd-audio/notes.rst b/Documentation/sound/hd-audio/notes.rst
index 9eeb9b468706..f59c3cdbfaf4 100644
--- a/Documentation/sound/hd-audio/notes.rst
+++ b/Documentation/sound/hd-audio/notes.rst
@@ -494,6 +494,8 @@ add_hp_mic (bool)
 hp_mic_detect (bool)
     enable/disable the hp/mic shared input for a single built-in mic
     case; default true
+vmaster (bool)
+    enable/disable the virtual Master control; default true
 mixer_nid (int)
     specifies the widget NID of the analog-loopback mixer
 
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 443832870a44..2842c82363c0 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -196,6 +196,9 @@ static void parse_user_hints(struct hda_codec *codec)
 	val = snd_hda_get_bool_hint(codec, "hp_mic_detect");
 	if (val >= 0)
 		spec->suppress_hp_mic_detect = !val;
+	val = snd_hda_get_bool_hint(codec, "vmaster");
+	if (val >= 0)
+		spec->suppress_vmaster = !val;
 
 	if (!snd_hda_get_int_hint(codec, "mixer_nid", &val))
 		spec->mixer_nid = val;
@@ -5033,7 +5036,7 @@ int snd_hda_gen_build_controls(struct hda_codec *codec)
 	}
 
 	/* if we have no master control, let's create it */
-	if (!spec->no_analog &&
+	if (!spec->no_analog && !spec->suppress_vmaster &&
 	    !snd_hda_find_mixer_ctl(codec, "Master Playback Volume")) {
 		err = snd_hda_add_vmaster(codec, "Master Playback Volume",
 					  spec->vmaster_tlv, slave_pfxs,
@@ -5041,7 +5044,7 @@ int snd_hda_gen_build_controls(struct hda_codec *codec)
 		if (err < 0)
 			return err;
 	}
-	if (!spec->no_analog &&
+	if (!spec->no_analog && !spec->suppress_vmaster &&
 	    !snd_hda_find_mixer_ctl(codec, "Master Playback Switch")) {
 		err = __snd_hda_add_vmaster(codec, "Master Playback Switch",
 					    NULL, slave_pfxs,
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index f66fc7e25e07..61772317de46 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -229,6 +229,7 @@ struct hda_gen_spec {
 	unsigned int add_jack_modes:1; /* add i/o jack mode enum ctls */
 	unsigned int power_down_unused:1; /* power down unused widgets */
 	unsigned int dac_min_mute:1; /* minimal = mute for DACs */
+	unsigned int suppress_vmaster:1; /* don't create vmaster kctls */
 
 	/* other internal flags */
 	unsigned int no_analog:1; /* digital I/O only */
-- 
2.11.1
