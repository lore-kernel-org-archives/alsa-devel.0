From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: pcm - Remove BKL from async callback
Date: Wed, 14 Apr 2010 10:14:20 +0200
Message-ID: <1271232862-16183-2-git-send-email-tiwai@suse.de>
References: <1271232862-16183-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FD9A24478
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 10:14:44 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id F398786A2E
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 10:14:43 +0200 (CEST)
In-Reply-To: <1271232862-16183-1-git-send-email-tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

It's simply calling fasync_helper().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 8728876..cadba30 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3303,18 +3303,13 @@ static int snd_pcm_fasync(int fd, struct file * file, int on)
 	struct snd_pcm_file * pcm_file;
 	struct snd_pcm_substream *substream;
 	struct snd_pcm_runtime *runtime;
-	int err = -ENXIO;
 
-	lock_kernel();
 	pcm_file = file->private_data;
 	substream = pcm_file->substream;
 	if (PCM_RUNTIME_CHECK(substream))
-		goto out;
+		return -ENXIO;
 	runtime = substream->runtime;
-	err = fasync_helper(fd, file, on, &runtime->fasync);
-out:
-	unlock_kernel();
-	return err;
+	return fasync_helper(fd, file, on, &runtime->fasync);
 }
 
 /*
-- 
1.7.0.4
