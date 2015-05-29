From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 01/10] ALSA: aloop: Drop unnecessary ifdef
	CONFIG_PROC_FS
Date: Fri, 29 May 2015 08:06:02 +0200
Message-ID: <1432879571-3359-2-git-send-email-tiwai@suse.de>
References: <1432879571-3359-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 532822666D2
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 08:06:14 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1A035AD08
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 06:06:14 +0000 (UTC)
In-Reply-To: <1432879571-3359-1-git-send-email-tiwai@suse.de>
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

Since the compiler can optimize away the unused code, we can reduce
the messy ifdef.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/aloop.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 7f9126efc1e5..54f348a4fb78 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -1053,8 +1053,6 @@ static int loopback_mixer_new(struct loopback *loopback, int notify)
 	return 0;
 }
 
-#ifdef CONFIG_PROC_FS
-
 static void print_dpcm_info(struct snd_info_buffer *buffer,
 			    struct loopback_pcm *dpcm,
 			    const char *id)
@@ -1128,12 +1126,6 @@ static int loopback_proc_new(struct loopback *loopback, int cidx)
 	return 0;
 }
 
-#else /* !CONFIG_PROC_FS */
-
-#define loopback_proc_new(loopback, cidx) do { } while (0)
-
-#endif
-
 static int loopback_probe(struct platform_device *devptr)
 {
 	struct snd_card *card;
-- 
2.4.2
