From: Dylan Reid <dgreid@chromium.org>
Subject: [PATCH] ALSA: hda - Send CONNECT_SEL on capture start
Date: Wed, 16 Nov 2011 00:25:49 -0800
Message-ID: <1321431949-9065-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f201.google.com (mail-gx0-f201.google.com
	[209.85.161.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 25C73243A5
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 09:26:30 +0100 (CET)
Received: by ggnq2 with SMTP id q2so727119ggn.2
	for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2011 00:26:28 -0800 (PST)
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
Cc: tiwai@suse.de, Dylan Reid <dgreid@chromium.org>, tim.howe@cirrus.com
List-Id: alsa-devel@alsa-project.org

cur_adc is set to zero in cs_capture_pcm_prepare.  This causes the
SET_CONNECT_SEL verb to be sent to node zero when doing automic after
recording.  Delay sending the command until we are about to start
capture and cur_adc is set to the correct NID.

Signed-off-by: Dylan Reid <dgreid@chromium.org>
---
 sound/pci/hda/patch_cirrus.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
index 2a2d864..30f2f6a 100644
--- a/sound/pci/hda/patch_cirrus.c
+++ b/sound/pci/hda/patch_cirrus.c
@@ -250,6 +250,9 @@ static int cs_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
 	spec->cur_adc = spec->adc_nid[spec->cur_input];
 	spec->cur_adc_stream_tag = stream_tag;
 	spec->cur_adc_format = format;
+	snd_hda_codec_write(codec, spec->cur_adc, 0,
+			    AC_VERB_SET_CONNECT_SEL,
+			    spec->adc_idx[spec->cur_input]);
 	snd_hda_codec_setup_stream(codec, spec->cur_adc, stream_tag, 0, format);
 	return 0;
 }
@@ -685,13 +688,13 @@ static int change_cur_input(struct hda_codec *codec, unsigned int idx,
 		/* stream is running, let's swap the current ADC */
 		__snd_hda_codec_cleanup_stream(codec, spec->cur_adc, 1);
 		spec->cur_adc = spec->adc_nid[idx];
+		snd_hda_codec_write(codec, spec->cur_adc, 0,
+				    AC_VERB_SET_CONNECT_SEL,
+				    spec->adc_idx[idx]);
 		snd_hda_codec_setup_stream(codec, spec->cur_adc,
 					   spec->cur_adc_stream_tag, 0,
 					   spec->cur_adc_format);
 	}
-	snd_hda_codec_write(codec, spec->cur_adc, 0,
-			    AC_VERB_SET_CONNECT_SEL,
-			    spec->adc_idx[idx]);
 	spec->cur_input = idx;
 	return 1;
 }
@@ -974,9 +977,10 @@ static void cs_automic(struct hda_codec *codec)
 			spec->cur_input = spec->last_input;
 		}
 
-		snd_hda_codec_write_cache(codec, spec->cur_adc, 0,
-					AC_VERB_SET_CONNECT_SEL,
-					spec->adc_idx[spec->cur_input]);
+		if (spec->cur_adc)
+			snd_hda_codec_write_cache(codec, spec->cur_adc, 0,
+				AC_VERB_SET_CONNECT_SEL,
+				spec->adc_idx[spec->cur_input]);
 	} else {
 		if (present)
 			change_cur_input(codec, spec->automic_idx, 0);
-- 
1.7.5.185.g0b9dee
