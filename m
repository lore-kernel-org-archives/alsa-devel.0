From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: x86: Minor cleanup of reset buffer
	procedure
Date: Sun,  5 Feb 2017 09:04:56 +0100
Message-ID: <20170205080458.15927-2-tiwai@suse.de>
References: <20170205080458.15927-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 82A9E266CFB
 for <alsa-devel@alsa-project.org>; Sun,  5 Feb 2017 09:05:00 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id B52F0AAA3
 for <alsa-devel@alsa-project.org>; Sun,  5 Feb 2017 08:04:59 +0000 (UTC)
In-Reply-To: <20170205080458.15927-1-tiwai@suse.de>
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

The procedure to reset buffer pointers is performed in two places and
still open-coded.  Simplify the helper function and use it
consistently.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/x86/intel_hdmi_audio.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index db437efbb87d..0a9c82aca05f 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -252,10 +252,11 @@ static void snd_intelhad_enable_audio_int(struct snd_intelhad *ctx, bool enable)
 	}
 }
 
-static void snd_intelhad_reset_audio(struct snd_intelhad *intelhaddata,
-				     u8 reset)
+/* Reset buffer pointers */
+static void had_reset_audio(struct snd_intelhad *intelhaddata)
 {
-	had_write_register(intelhaddata, AUD_HDMI_STATUS, reset);
+	had_write_register(intelhaddata, AUD_HDMI_STATUS, 1);
+	had_write_register(intelhaddata, AUD_HDMI_STATUS, 0);
 }
 
 /*
@@ -893,8 +894,7 @@ static void snd_intelhad_handle_underrun(struct snd_intelhad *intelhaddata)
 	/* Handle Underrun interrupt within Audio Unit */
 	had_write_register(intelhaddata, AUD_CONFIG, 0);
 	/* Reset buffer pointers */
-	had_write_register(intelhaddata, AUD_HDMI_STATUS, 1);
-	had_write_register(intelhaddata, AUD_HDMI_STATUS, 0);
+	had_reset_audio(intelhaddata);
 	/*
 	 * The interrupt status 'sticky' bits might not be cleared by
 	 * setting '1' to that bit once...
@@ -1085,8 +1085,7 @@ static int snd_intelhad_pcm_trigger(struct snd_pcm_substream *substream,
 		snd_intelhad_enable_audio_int(intelhaddata, false);
 		snd_intelhad_enable_audio(substream, intelhaddata, false);
 		/* Reset buffer pointers */
-		snd_intelhad_reset_audio(intelhaddata, 1);
-		snd_intelhad_reset_audio(intelhaddata, 0);
+		had_reset_audio(intelhaddata);
 		snd_intelhad_enable_audio_int(intelhaddata, false);
 		break;
 
-- 
2.11.0
