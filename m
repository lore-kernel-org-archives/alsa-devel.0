From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Add missing capture_hook calls for
	dyn-ADC PCM streams
Date: Tue, 12 Apr 2016 15:34:29 +0200
Message-ID: <1460468069-11001-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A9C42651B4
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 15:34:31 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 40E0EABB2
 for <alsa-devel@alsa-project.org>; Tue, 12 Apr 2016 13:34:30 +0000 (UTC)
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

The calls for capture_hook were missing in dyn_adc_capture_pcm_prepare
and cleanup callbacks.  Luckily there are no users of the capture
hooks with dyn-adc PCM, so far, thus this doesn't change the behavior
of existing devices, but it's a fix for a future usage.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 7ca5b89f088a..dc2c13687118 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -5432,6 +5432,7 @@ static int dyn_adc_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
 	spec->cur_adc_stream_tag = stream_tag;
 	spec->cur_adc_format = format;
 	snd_hda_codec_setup_stream(codec, spec->cur_adc, stream_tag, 0, format);
+	call_pcm_capture_hook(hinfo, codec, substream, HDA_GEN_PCM_ACT_PREPARE);
 	return 0;
 }
 
@@ -5442,6 +5443,7 @@ static int dyn_adc_capture_pcm_cleanup(struct hda_pcm_stream *hinfo,
 	struct hda_gen_spec *spec = codec->spec;
 	snd_hda_codec_cleanup_stream(codec, spec->cur_adc);
 	spec->cur_adc = 0;
+	call_pcm_capture_hook(hinfo, codec, substream, HDA_GEN_PCM_ACT_CLEANUP);
 	return 0;
 }
 
-- 
2.8.1
