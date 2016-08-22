From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2 1/2] ALSA: compress: Restructure source code around an if
 statement in snd_compr_set_params()
Date: Mon, 22 Aug 2016 10:38:25 +0200
Message-ID: <89765506-60f0-8319-5806-29476a36f9f3@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <7233eb00-a941-4935-dce2-7cb907272d41@users.sourceforge.net>
 <03eac1fe-ff33-1759-9c2a-7914f1c6de45@users.sourceforge.net>
 <1471809094.3746.17.camel@perches.com>
 <14b1efe1-3c1c-4c36-bfc2-19947c190412@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <14b1efe1-3c1c-4c36-bfc2-19947c190412@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Joe Perches <joe@perches.com>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 22 Aug 2016 10:01:52 +0200

* Reverse a condition check.

* Reduce the indentation one level then for some source code
  from a previous if branch.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/core/compress_offload.c | 62 +++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 2c49848..a10d139 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -548,43 +548,41 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 	struct snd_compr_params *params;
 	int retval;
 
-	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
-		/*
-		 * we should allow parameter change only when stream has been
-		 * opened not in other cases
-		 */
-		params = kmalloc(sizeof(*params), GFP_KERNEL);
-		if (!params)
-			return -ENOMEM;
-		if (copy_from_user(params, (void __user *)arg, sizeof(*params))) {
-			retval = -EFAULT;
-			goto out;
-		}
+	if (stream->runtime->state != SNDRV_PCM_STATE_OPEN)
+		return -EPERM;
+	/*
+	 * we should allow parameter change only when stream has been
+	 * opened not in other cases
+	 */
+	params = kmalloc(sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return -ENOMEM;
+	if (copy_from_user(params, (void __user *)arg, sizeof(*params))) {
+		retval = -EFAULT;
+		goto out;
+	}
 
-		retval = snd_compress_check_input(params);
-		if (retval)
-			goto out;
+	retval = snd_compress_check_input(params);
+	if (retval)
+		goto out;
 
-		retval = snd_compr_allocate_buffer(stream, params);
-		if (retval) {
-			retval = -ENOMEM;
-			goto out;
-		}
+	retval = snd_compr_allocate_buffer(stream, params);
+	if (retval) {
+		retval = -ENOMEM;
+		goto out;
+	}
 
-		retval = stream->ops->set_params(stream, params);
-		if (retval)
-			goto out;
+	retval = stream->ops->set_params(stream, params);
+	if (retval)
+		goto out;
 
-		stream->metadata_set = false;
-		stream->next_track = false;
+	stream->metadata_set = false;
+	stream->next_track = false;
 
-		if (stream->direction == SND_COMPRESS_PLAYBACK)
-			stream->runtime->state = SNDRV_PCM_STATE_SETUP;
-		else
-			stream->runtime->state = SNDRV_PCM_STATE_PREPARED;
-	} else {
-		return -EPERM;
-	}
+	if (stream->direction == SND_COMPRESS_PLAYBACK)
+		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
+	else
+		stream->runtime->state = SNDRV_PCM_STATE_PREPARED;
 out:
 	kfree(params);
 	return retval;
-- 
2.9.3
