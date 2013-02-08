From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH] ALSA: hda - Fix the workaround for conflicting
	IEC958 controls
Date: Sat,  9 Feb 2013 00:44:39 +0200
Message-ID: <1360363479-15678-1-git-send-email-anssi.hannula@iki.fi>
References: <s5hobk7k918.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sypressi.dnainternet.net (sypressi.dnainternet.net
 [83.102.40.135])
 by alsa0.perex.cz (Postfix) with ESMTP id A9E42261631
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2013 23:44:52 +0100 (CET)
In-Reply-To: <s5hobk7k918.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Commit dcda5806165c155d90b9aa466a1602cf4726012b ("ALSA: hda - Add
workaround for conflicting IEC958 controls") added a workaround for
cards that have both an S/PDIF and an HDMI device, so that S/PDIF IEC958
controls will be moved to device=1 on such cards.

However, the workaround did not take it into account that the S/PDIF and
HDMI devices may be on different codecs of the same card. Currently this
is always the case, and the workaround therefore fails to work.

Fix the workaround to handle card-wide IEC958 conflicts.

Reported-by: Stephan Raue <stephan@openelec.tv>
Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---

Unfortunately this seems to cause a nasty issue with alsa-lib 1.0.26:
$ amixer scontrols -c 0
ALSA lib simple_none.c:1551:(simple_add1) helem (MIXER,'IEC958 Playback Switch',0,1,0) appears twice or more
amixer: Mixer hw:0 load error: Invalid argument

The non-simple-mode "amixer controls -c 0" works fine, though.

Not really sure what to do now then, do we revert the workaround
completely and devise a different workaround/fix for this, or do you
have some other good ideas?


 sound/pci/hda/hda_codec.c |   27 +++++++++++++++------------
 sound/pci/hda/hda_codec.h |    4 +++-
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 822df97..fe5d6fc 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3135,25 +3135,28 @@ int snd_hda_create_dig_out_ctls(struct hda_codec *codec,
 	int idx, dev = 0;
 	const int spdif_pcm_dev = 1;
 	struct hda_spdif_out *spdif;
+	struct hda_codec *c;
 
-	if (codec->primary_dig_out_type == HDA_PCM_TYPE_HDMI &&
+	if (codec->bus->primary_dig_out_type == HDA_PCM_TYPE_HDMI &&
 	    type == HDA_PCM_TYPE_SPDIF) {
 		dev = spdif_pcm_dev;
-	} else if (codec->primary_dig_out_type == HDA_PCM_TYPE_SPDIF &&
+	} else if (codec->bus->primary_dig_out_type == HDA_PCM_TYPE_SPDIF &&
 		   type == HDA_PCM_TYPE_HDMI) {
-		for (idx = 0; idx < codec->spdif_out.used; idx++) {
-			spdif = snd_array_elem(&codec->spdif_out, idx);
-			for (dig_mix = dig_mixes; dig_mix->name; dig_mix++) {
-				kctl = find_mixer_ctl(codec, dig_mix->name, 0, idx);
-				if (!kctl)
-					break;
-				kctl->id.device = spdif_pcm_dev;
+		list_for_each_entry(c, &codec->bus->codec_list, list) {
+			for (idx = 0; idx < c->spdif_out.used; idx++) {
+				spdif = snd_array_elem(&c->spdif_out, idx);
+				for (dig_mix = dig_mixes; dig_mix->name; dig_mix++) {
+					kctl = find_mixer_ctl(c, dig_mix->name, 0, idx);
+					if (!kctl)
+						break;
+					kctl->id.device = spdif_pcm_dev;
+				}
 			}
 		}
-		codec->primary_dig_out_type = HDA_PCM_TYPE_HDMI;
+		codec->bus->primary_dig_out_type = HDA_PCM_TYPE_HDMI;
 	}
-	if (!codec->primary_dig_out_type)
-		codec->primary_dig_out_type = type;
+	if (!codec->bus->primary_dig_out_type)
+		codec->bus->primary_dig_out_type = type;
 
 	idx = find_empty_mixer_ctl_idx(codec, "IEC958 Playback Switch", dev);
 	if (idx < 0) {
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 8665540..ab807f7 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -671,6 +671,9 @@ struct hda_bus {
 	unsigned int response_reset:1;	/* controller was reset */
 	unsigned int in_reset:1;	/* during reset operation */
 	unsigned int power_keep_link_on:1; /* don't power off HDA link */
+
+	/* primary digital out PCM type */
+	int primary_dig_out_type;
 };
 
 /*
@@ -837,7 +840,6 @@ struct hda_codec {
 	struct mutex hash_mutex;
 	struct snd_array spdif_out;
 	unsigned int spdif_in_enable;	/* SPDIF input enable? */
-	int primary_dig_out_type;	/* primary digital out PCM type */
 	const hda_nid_t *slave_dig_outs; /* optional digital out slave widgets */
 	struct snd_array init_pins;	/* initial (BIOS) pin configurations */
 	struct snd_array driver_pins;	/* pin configs set by codec parser */
-- 
1.7.10
