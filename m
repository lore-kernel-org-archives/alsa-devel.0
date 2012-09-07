From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Remove ignore_misc_bit
Date: Fri,  7 Sep 2012 07:25:44 +0200
Message-ID: <1346995544-6754-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 03E3026036E
 for <alsa-devel@alsa-project.org>; Fri,  7 Sep 2012 07:25:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: 939161@bugs.launchpad.net, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

The purpose of this flag is unclear. If the problem is that some machines
have broken misc/NO_PRESENCE bits, they should be fixed by pin fixups.

In addition, this causes jack detection functionality to be flawed on
the M31EI, where there are two jacks without jack detection (which is
properly marked as NO_PRESENCE), but due to ignore_misc_bit, these
jacks are instead being reported as being present but always unplugged.

BugLink: https://bugs.launchpad.net/bugs/939161
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_auto_parser.c |    4 ----
 sound/pci/hda/hda_codec.h       |    1 -
 sound/pci/hda/hda_jack.c        |    5 ++---
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index 4f7d2df..9acd5a9 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -141,7 +141,6 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 	memset(sequences_hp, 0, sizeof(sequences_hp));
 	assoc_line_out = 0;
 
-	codec->ignore_misc_bit = true;
 	end_nid = codec->start_nid + codec->num_nodes;
 	for (nid = codec->start_nid; nid < end_nid; nid++) {
 		unsigned int wid_caps = get_wcaps(codec, nid);
@@ -157,9 +156,6 @@ int snd_hda_parse_pin_defcfg(struct hda_codec *codec,
 			continue;
 
 		def_conf = snd_hda_codec_get_pincfg(codec, nid);
-		if (!(get_defcfg_misc(snd_hda_codec_get_pincfg(codec, nid)) &
-		      AC_DEFCFG_MISC_NO_PRESENCE))
-			codec->ignore_misc_bit = false;
 		conn = get_defcfg_connect(def_conf);
 		if (conn == AC_JACK_PORT_NONE)
 			continue;
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 8fd9f63..ee4ae8e 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -861,7 +861,6 @@ struct hda_codec {
 	unsigned int no_sticky_stream:1; /* no sticky-PCM stream assignment */
 	unsigned int pins_shutup:1;	/* pins are shut up */
 	unsigned int no_trigger_sense:1; /* don't trigger at pin-sensing */
-	unsigned int ignore_misc_bit:1; /* ignore MISC_NO_PRESENCE bit */
 	unsigned int no_jack_detect:1;	/* Machine has no jack-detection */
 	unsigned int pcm_format_first:1; /* PCM format must be set first */
 	unsigned int epss:1;		/* supporting EPSS? */
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index aaccc02..c9333c9 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -26,9 +26,8 @@ bool is_jack_detectable(struct hda_codec *codec, hda_nid_t nid)
 		return false;
 	if (!(snd_hda_query_pin_caps(codec, nid) & AC_PINCAP_PRES_DETECT))
 		return false;
-	if (!codec->ignore_misc_bit &&
-	    (get_defcfg_misc(snd_hda_codec_get_pincfg(codec, nid)) &
-	     AC_DEFCFG_MISC_NO_PRESENCE))
+	if (get_defcfg_misc(snd_hda_codec_get_pincfg(codec, nid)) &
+	     AC_DEFCFG_MISC_NO_PRESENCE)
 		return false;
 	if (!(get_wcaps(codec, nid) & AC_WCAP_UNSOL_CAP))
 		return false;
-- 
1.7.9.5
