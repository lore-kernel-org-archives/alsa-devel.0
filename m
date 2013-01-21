From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 12/12] ALSA: hda - Set individual name to
	secondary analog PCM stream
Date: Mon, 21 Jan 2013 17:06:17 +0100
Message-ID: <1358784377-26102-13-git-send-email-tiwai@suse.de>
References: <1358784377-26102-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A34D26260F
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 17:06:19 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 35979A51FE
 for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2013 17:06:19 +0100 (CET)
In-Reply-To: <1358784377-26102-1-git-send-email-tiwai@suse.de>
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

It'd be better to give another name to the secondary (alt) analog PCM
stream, which is dedicated for the independent HP out and extra
inputs.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 5 ++++-
 sound/pci/hda/hda_generic.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 6d1e843..63d12ef 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -4531,9 +4531,12 @@ int snd_hda_gen_build_pcms(struct hda_codec *codec)
 		!spec->dyn_adc_switch && !spec->auto_mic;
 	/* Additional Analaog capture for index #2 */
 	if (spec->alt_dac_nid || have_multi_adcs) {
+		fill_pcm_stream_name(spec->stream_name_alt_analog,
+				     sizeof(spec->stream_name_alt_analog),
+			     " Alt Analog", codec->chip_name);
 		codec->num_pcms = 3;
 		info = spec->pcm_rec + 2;
-		info->name = spec->stream_name_analog;
+		info->name = spec->stream_name_alt_analog;
 		if (spec->alt_dac_nid) {
 			p = spec->stream_analog_alt_playback;
 			if (!p)
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 9c63555..980707f 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -80,6 +80,8 @@ struct hda_gen_spec {
 	char stream_name_analog[32];	/* analog PCM stream */
 	const struct hda_pcm_stream *stream_analog_playback;
 	const struct hda_pcm_stream *stream_analog_capture;
+
+	char stream_name_alt_analog[32]; /* alternative analog PCM stream */
 	const struct hda_pcm_stream *stream_analog_alt_playback;
 	const struct hda_pcm_stream *stream_analog_alt_capture;
 
-- 
1.8.1.1
