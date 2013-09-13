From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] ALSA: compress: Make sure we trigger STOP
	before closing the stream.
Date: Fri, 13 Sep 2013 17:43:16 +0100
Message-ID: <1379090597-7096-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B5B02610A4
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 18:43:44 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Currently we assume that userspace will shut down the compressed stream
correctly. However, if userspcae dies (e.g. cplay & ctrl-C) we dont
stop the stream before freeing it.

This now checks that the stream is stopped before freeing.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/core/compress_offload.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 99db892..a9ae4f3 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -139,6 +139,18 @@ static int snd_compr_open(struct inode *inode, struct file *f)
 static int snd_compr_free(struct inode *inode, struct file *f)
 {
 	struct snd_compr_file *data = f->private_data;
+	struct snd_compr_runtime *runtime = data->stream.runtime;
+
+	switch (runtime->state) {
+	case SNDRV_PCM_STATE_RUNNING:
+	case SNDRV_PCM_STATE_DRAINING:
+	case SNDRV_PCM_STATE_PAUSED:
+		data->stream.ops->trigger(&data->stream, SNDRV_PCM_TRIGGER_STOP);
+		break;
+	default:
+		break;
+	}
+
 	data->stream.ops->free(&data->stream);
 	kfree(data->stream.runtime->buffer);
 	kfree(data->stream.runtime);
-- 
1.8.1.2
