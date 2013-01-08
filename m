From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 081/112] ALSA: hda - Add codec->inv_jack_detect
	flag
Date: Tue,  8 Jan 2013 12:39:14 +0100
Message-ID: <1357645185-7645-82-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AF2E8265213
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 8DDB1A5357
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

Yet another broken hardware workaround: there are hardware indicating
the inverted jack detection bit result.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.h | 1 +
 sound/pci/hda/hda_jack.c  | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 369ffaf..9f241d1 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -867,6 +867,7 @@ struct hda_codec {
 	unsigned int no_trigger_sense:1; /* don't trigger at pin-sensing */
 	unsigned int no_jack_detect:1;	/* Machine has no jack-detection */
 	unsigned int inv_eapd:1; /* broken h/w: inverted EAPD control */
+	unsigned int inv_jack_detect:1;	/* broken h/w: inverted detection bit */
 	unsigned int pcm_format_first:1; /* PCM format must be set first */
 	unsigned int epss:1;		/* supporting EPSS? */
 	unsigned int cached_write:1;	/* write only to caches */
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 6e9f57b..6479b65 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -39,6 +39,7 @@ EXPORT_SYMBOL_HDA(is_jack_detectable);
 static u32 read_pin_sense(struct hda_codec *codec, hda_nid_t nid)
 {
 	u32 pincap;
+	u32 val;
 
 	if (!codec->no_trigger_sense) {
 		pincap = snd_hda_query_pin_caps(codec, nid);
@@ -46,8 +47,11 @@ static u32 read_pin_sense(struct hda_codec *codec, hda_nid_t nid)
 			snd_hda_codec_read(codec, nid, 0,
 					AC_VERB_SET_PIN_SENSE, 0);
 	}
-	return snd_hda_codec_read(codec, nid, 0,
+	val = snd_hda_codec_read(codec, nid, 0,
 				  AC_VERB_GET_PIN_SENSE, 0);
+	if (codec->inv_jack_detect)
+		val ^= AC_PINSENSE_PRESENCE;
+	return val;
 }
 
 /**
-- 
1.8.0.1
