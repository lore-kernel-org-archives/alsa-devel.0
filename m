From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] ASoC: Intel: sst: Fix some style
Date: Sat,  6 Jan 2018 21:18:55 +0100
Message-ID: <20180106201855.6131-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr
 [80.12.242.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 18295266F2E
 for <alsa-devel@alsa-project.org>; Sat,  6 Jan 2018 21:19:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This patch fixes 3 small issues:
 - missing 2nd '*' at the beginning of a doxygen comment
 - extra space after a '\n' in a dev_dbg message
 - extra tab before a 'return" statement

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/intel/atom/sst/sst_stream.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_stream.c b/sound/soc/intel/atom/sst/sst_stream.c
index 20f5066fefb9..7ee6aeb7e0af 100644
--- a/sound/soc/intel/atom/sst/sst_stream.c
+++ b/sound/soc/intel/atom/sst/sst_stream.c
@@ -223,7 +223,7 @@ int sst_send_byte_stream_mrfld(struct intel_sst_drv *sst_drv_ctx,
 	return ret;
 }
 
-/*
+/**
  * sst_pause_stream - Send msg for a pausing stream
  * @str_id:	 stream ID
  *
@@ -261,7 +261,7 @@ int sst_pause_stream(struct intel_sst_drv *sst_drv_ctx, int str_id)
 		}
 	} else {
 		retval = -EBADRQC;
-		dev_dbg(sst_drv_ctx->dev, "SST DBG:BADRQC for stream\n ");
+		dev_dbg(sst_drv_ctx->dev, "SST DBG:BADRQC for stream\n");
 	}
 
 	return retval;
@@ -284,7 +284,7 @@ int sst_resume_stream(struct intel_sst_drv *sst_drv_ctx, int str_id)
 	if (!str_info)
 		return -EINVAL;
 	if (str_info->status == STREAM_RUNNING)
-			return 0;
+		return 0;
 	if (str_info->status == STREAM_PAUSED) {
 		retval = sst_prepare_and_post_msg(sst_drv_ctx, str_info->task_id,
 				IPC_CMD, IPC_IA_RESUME_STREAM_MRFLD,
-- 
2.14.1
