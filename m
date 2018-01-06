From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] ASoC: Intel: sst: Fix the return value of
	'sst_send_byte_stream_mrfld()'
Date: Sat,  6 Jan 2018 21:18:24 +0100
Message-ID: <20180106201824.6081-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.smtpout.orange.fr (smtp10.smtpout.orange.fr
 [80.12.242.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A72A266F2E
 for <alsa-devel@alsa-project.org>; Sat,  6 Jan 2018 21:18:49 +0100 (CET)
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

In some error handling paths, an error code is assiegned to 'ret'.
However, the function always return 0.

Fix it and return the error code if such an error paths is taken.

Fixes: 3d9ff34622ba ("ASoC: Intel: sst: add stream operations")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/intel/atom/sst/sst_stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_stream.c b/sound/soc/intel/atom/sst/sst_stream.c
index 65e257b17a7e..20f5066fefb9 100644
--- a/sound/soc/intel/atom/sst/sst_stream.c
+++ b/sound/soc/intel/atom/sst/sst_stream.c
@@ -220,7 +220,7 @@ int sst_send_byte_stream_mrfld(struct intel_sst_drv *sst_drv_ctx,
 		sst_free_block(sst_drv_ctx, block);
 out:
 	test_and_clear_bit(pvt_id, &sst_drv_ctx->pvt_id);
-	return 0;
+	return ret;
 }
 
 /*
-- 
2.14.1
