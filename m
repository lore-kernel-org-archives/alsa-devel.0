From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: compress: use soc_xxx handlers for
	metadata
Date: Sun, 28 Jul 2013 20:06:15 +0530
Message-ID: <1375022175-31616-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E742C261738
 for <alsa-devel@alsa-project.org>; Sun, 28 Jul 2013 17:15:13 +0200 (CEST)
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

the compress metadata handlers were wrongly named sst_xxx

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/soc-compress.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 06a8000..d220150 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -334,7 +334,7 @@ static int soc_compr_copy(struct snd_compr_stream *cstream,
 	return ret;
 }
 
-static int sst_compr_set_metadata(struct snd_compr_stream *cstream,
+static int soc_compr_set_metadata(struct snd_compr_stream *cstream,
 				struct snd_compr_metadata *metadata)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
@@ -347,7 +347,7 @@ static int sst_compr_set_metadata(struct snd_compr_stream *cstream,
 	return ret;
 }
 
-static int sst_compr_get_metadata(struct snd_compr_stream *cstream,
+static int soc_compr_get_metadata(struct snd_compr_stream *cstream,
 				struct snd_compr_metadata *metadata)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
@@ -364,8 +364,8 @@ static struct snd_compr_ops soc_compr_ops = {
 	.open		= soc_compr_open,
 	.free		= soc_compr_free,
 	.set_params	= soc_compr_set_params,
-	.set_metadata   = sst_compr_set_metadata,
-	.get_metadata	= sst_compr_get_metadata,
+	.set_metadata   = soc_compr_set_metadata,
+	.get_metadata	= soc_compr_get_metadata,
 	.get_params	= soc_compr_get_params,
 	.trigger	= soc_compr_trigger,
 	.pointer	= soc_compr_pointer,
-- 
1.7.0.4
