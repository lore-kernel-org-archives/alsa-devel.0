From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/38] ALSA: hda - Add suffix argument to
	snd_hda_add_vmaster()
Date: Fri, 24 Feb 2012 17:35:54 +0100
Message-ID: <1330101391-8788-2-git-send-email-tiwai@suse.de>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id C11C71042FA
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 5A43F8FE69
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 17:36:33 +0100 (CET)
In-Reply-To: <1330101391-8788-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

In most cases, the slave strings for vmaster are identical between
volumes and switches except for "xxx Volume" and "xxx Switch" suffix.
Now snd_hda_add_vmaster() takes the optional suffix argument so that
each string can be composed with the given suffix, and we can share the
slave name strings in both volume and switch calls nicely.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |   40 ++++++++--------------------------------
 1 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 33b6077..42f1844 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1845,36 +1845,10 @@ DEFINE_CAPMIX_NOSRC(3);
 /*
  * slave controls for virtual master
  */
-static const char * const alc_slave_vols[] = {
-	"Front Playback Volume",
-	"Surround Playback Volume",
-	"Center Playback Volume",
-	"LFE Playback Volume",
-	"Side Playback Volume",
-	"Headphone Playback Volume",
-	"Speaker Playback Volume",
-	"Mono Playback Volume",
-	"Line-Out Playback Volume",
-	"CLFE Playback Volume",
-	"Bass Speaker Playback Volume",
-	"PCM Playback Volume",
-	NULL,
-};
-
-static const char * const alc_slave_sws[] = {
-	"Front Playback Switch",
-	"Surround Playback Switch",
-	"Center Playback Switch",
-	"LFE Playback Switch",
-	"Side Playback Switch",
-	"Headphone Playback Switch",
-	"Speaker Playback Switch",
-	"Mono Playback Switch",
-	"IEC958 Playback Switch",
-	"Line-Out Playback Switch",
-	"CLFE Playback Switch",
-	"Bass Speaker Playback Switch",
-	"PCM Playback Switch",
+static const char * const alc_slave_pfxs[] = {
+	"Front", "Surround", "Center", "LFE", "Side",
+	"Headphone", "Speaker", "Mono", "Line-Out",
+	"CLFE", "Bass Speaker", "PCM",
 	NULL,
 };
 
@@ -1965,14 +1939,16 @@ static int __alc_build_controls(struct hda_codec *codec)
 		snd_hda_set_vmaster_tlv(codec, spec->vmaster_nid,
 					HDA_OUTPUT, vmaster_tlv);
 		err = snd_hda_add_vmaster(codec, "Master Playback Volume",
-					  vmaster_tlv, alc_slave_vols);
+					  vmaster_tlv, alc_slave_pfxs,
+					  "Playback Volume");
 		if (err < 0)
 			return err;
 	}
 	if (!spec->no_analog &&
 	    !snd_hda_find_mixer_ctl(codec, "Master Playback Switch")) {
 		err = snd_hda_add_vmaster(codec, "Master Playback Switch",
-					  NULL, alc_slave_sws);
+					  NULL, alc_slave_pfxs,
+					  "Playback Switch");
 		if (err < 0)
 			return err;
 	}
-- 
1.7.9
