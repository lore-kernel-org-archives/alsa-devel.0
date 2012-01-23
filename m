From: Jesper Juhl <jj@chaosbits.net>
Subject: [PATCH] sound: Fix memory leak on error in snd_compr_set_params()
Date: Mon, 23 Jan 2012 21:02:57 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1201232059540.8772@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

If copy_from_user() does not return 0 we'll leak the memory we
allocated for 'params' when that variable goes out of scope.

Also a small CodingStyle cleanup: Use braces on both branches of
if/else when one branch needs it.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 sound/core/compress_offload.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index dac3633..a68aed7 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -441,19 +441,22 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 		params = kmalloc(sizeof(*params), GFP_KERNEL);
 		if (!params)
 			return -ENOMEM;
-		if (copy_from_user(params, (void __user *)arg, sizeof(*params)))
-			return -EFAULT;
+		if (copy_from_user(params, (void __user *)arg, sizeof(*params))) {
+			retval = -EFAULT;
+			goto out;
+		}
 		retval = snd_compr_allocate_buffer(stream, params);
 		if (retval) {
-			kfree(params);
-			return -ENOMEM;
+			retval = -ENOMEM;
+			goto out;
 		}
 		retval = stream->ops->set_params(stream, params);
 		if (retval)
 			goto out;
 		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
-	} else
+	} else {
 		return -EPERM;
+	}
 out:
 	kfree(params);
 	return retval;
-- 
1.7.8.4


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
