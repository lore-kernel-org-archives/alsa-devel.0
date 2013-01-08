From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 074/112] ALSA: hda - Drop spec->channel_mode
	field from hda_gen_spec
Date: Tue,  8 Jan 2013 12:39:07 +0100
Message-ID: <1357645185-7645-75-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 78CF8265208
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 7D22AA532B
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

It's never used in the generic parser.  It was there from the old
Realtek code, which has been dropped quite ago, too.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 10 ----------
 sound/pci/hda/hda_generic.h |  2 --
 2 files changed, 12 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index d4cb9df..43acf3d 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3258,7 +3258,6 @@ int snd_hda_gen_build_pcms(struct hda_codec *codec)
 	struct hda_pcm *info = spec->pcm_rec;
 	const struct hda_pcm_stream *p;
 	bool have_multi_adcs;
-	int i;
 
 	codec->num_pcms = 1;
 	codec->pcm_info = info;
@@ -3296,15 +3295,6 @@ int snd_hda_gen_build_pcms(struct hda_codec *codec)
 		info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adc_nids[0];
 	}
 
-	if (spec->channel_mode) {
-		info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max = 0;
-		for (i = 0; i < spec->num_channel_mode; i++) {
-			if (spec->channel_mode[i].channels > info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max) {
-				info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max = spec->channel_mode[i].channels;
-			}
-		}
-	}
-
  skip_analog:
 	/* SPDIF for stream index #1 */
 	if (spec->multiout.dig_out_nid || spec->dig_in_nid) {
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index a406cd4..6365140 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -101,8 +101,6 @@ struct hda_gen_spec {
 	unsigned int cur_mux[3];
 
 	/* channel model */
-	const struct hda_channel_mode *channel_mode;
-	int num_channel_mode;
 	int const_channel_count;	/* min. channel count (for speakers) */
 	int ext_channel_count;		/* current channel count for multi-io */
 
-- 
1.8.0.1
