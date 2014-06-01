From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] sound: synth: emux: soundfont.c:  Cleaning up memory leak
Date: Sun,  1 Jun 2014 13:35:24 +0200
Message-ID: <1401622524-13636-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

There is a risk for memory leak in when something unexpected happens
and the function returns.

This was largely found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 sound/synth/emux/soundfont.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/synth/emux/soundfont.c b/sound/synth/emux/soundfont.c
index 1137b85..09c5eeb 100644
--- a/sound/synth/emux/soundfont.c
+++ b/sound/synth/emux/soundfont.c
@@ -1021,6 +1021,7 @@ load_guspatch(struct snd_sf_list *sflist, const char __user *data,
 			 data, count);
 		if (rc < 0) {
 			sf_sample_delete(sflist, sf, smp);
+			free(zone);
 			return rc;
 		}
 		/* memory offset is updated after */
-- 
1.7.10.4
