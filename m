From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: mixart: silence unitialized variable warnings
Date: Tue, 15 Mar 2016 10:09:17 +0300
Message-ID: <20160315070917.GE13560@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

We print can print the uninitialized memory on error.  Which is an info
leak, I suppose but it's basically harmless.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/mixart/mixart_mixer.c b/sound/pci/mixart/mixart_mixer.c
index 24a1955..58fd79eb 100644
--- a/sound/pci/mixart/mixart_mixer.c
+++ b/sound/pci/mixart/mixart_mixer.c
@@ -726,7 +726,7 @@ int mixart_update_playback_stream_level(struct snd_mixart* chip, int is_aes, int
 	int volume[2];
 	struct mixart_msg request;
 	struct mixart_set_out_stream_level_req set_level;
-	u32 status;
+	u32 status = 0;
 	struct mixart_pipe *pipe;
 
 	memset(&set_level, 0, sizeof(set_level));
@@ -778,7 +778,7 @@ int mixart_update_capture_stream_level(struct snd_mixart* chip, int is_aes)
 	struct mixart_pipe *pipe;
 	struct mixart_msg request;
 	struct mixart_set_in_audio_level_req set_level;
-	u32 status;
+	u32 status = 0;
 
 	if(is_aes) {
 		idx = 1;
