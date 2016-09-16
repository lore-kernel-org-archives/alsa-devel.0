From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ALSA: compress: fix some missing and misplaced \n in messages
Date: Fri, 16 Sep 2016 17:46:41 +0100
Message-ID: <20160916164641.11805-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Fix a missing \n in a pr_debug message and move the \n to the end
of a pr_err message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/core/compress_offload.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 583d407..fec1dfd 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -780,7 +780,7 @@ static int snd_compress_wait_for_drain(struct snd_compr_stream *stream)
 	ret = wait_event_interruptible(stream->runtime->sleep,
 			(stream->runtime->state != SNDRV_PCM_STATE_DRAINING));
 	if (ret == -ERESTARTSYS)
-		pr_debug("wait aborted by a signal");
+		pr_debug("wait aborted by a signal\n");
 	else if (ret)
 		pr_debug("wait for drain failed with %d\n", ret);
 
@@ -962,7 +962,7 @@ static int snd_compress_dev_register(struct snd_device *device)
 				  compr->card, compr->device,
 				  &snd_compr_file_ops, compr, &compr->dev);
 	if (ret < 0) {
-		pr_err("snd_register_device failed\n %d", ret);
+		pr_err("snd_register_device failed %d\n", ret);
 		return ret;
 	}
 	return ret;
-- 
2.9.3
