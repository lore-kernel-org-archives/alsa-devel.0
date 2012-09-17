From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH 1/2] ALSA: compress - move the buffer check
Date: Mon, 17 Sep 2012 11:51:25 +0530
Message-ID: <1347862886-29396-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D9E8F2615F6
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2012 08:25:39 +0200 (CEST)
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@linux.intel.com>, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

Commit ALSA: compress_core: integer overflow in snd_compr_allocate_buffer()
added a new error check for input params.
this add new routine for input checks and moves buffer overflow check to this
new routine. This allows the error value to be propogated to user space

Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
---
 sound/core/compress_offload.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 68fe02c..bd7f28e 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -407,10 +407,6 @@ static int snd_compr_allocate_buffer(struct snd_compr_stream *stream,
 	unsigned int buffer_size;
 	void *buffer;
 
-	if (params->buffer.fragment_size == 0 ||
-	    params->buffer.fragments > SIZE_MAX / params->buffer.fragment_size)
-		return -EINVAL;
-
 	buffer_size = params->buffer.fragment_size * params->buffer.fragments;
 	if (stream->ops->copy) {
 		buffer = NULL;
@@ -429,6 +425,16 @@ static int snd_compr_allocate_buffer(struct snd_compr_stream *stream,
 	return 0;
 }
 
+static int snd_compress_check_input(struct snd_compr_params *params)
+{
+	/* first let's check the buffer parameter's */
+	if (params->buffer.fragment_size == 0 ||
+			params->buffer.fragments > SIZE_MAX / params->buffer.fragment_size)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int
 snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 {
@@ -447,11 +453,17 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 			retval = -EFAULT;
 			goto out;
 		}
+
+		retval = snd_compress_check_input(params);
+		if (retval)
+			goto out;
+
 		retval = snd_compr_allocate_buffer(stream, params);
 		if (retval) {
 			retval = -ENOMEM;
 			goto out;
 		}
+
 		retval = stream->ops->set_params(stream, params);
 		if (retval)
 			goto out;
-- 
1.7.0.4
