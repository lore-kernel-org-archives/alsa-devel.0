From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2] ASoC: mid-x86 - add support for meaadata
	apis
Date: Fri, 29 Mar 2013 23:41:42 +0530
Message-ID: <1364580702-21096-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id EBFC02602C7
 for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2013 19:38:30 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, broonie@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

while at it, update the copyright timeline too

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
v2: fix the missing header inclusion in patch

 sound/soc/mid-x86/sst_platform.c |   12 +++++++++++-
 sound/soc/mid-x86/sst_platform.h |    2 ++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/sound/soc/mid-x86/sst_platform.c b/sound/soc/mid-x86/sst_platform.c
index a263cbe..968656c 100644
--- a/sound/soc/mid-x86/sst_platform.c
+++ b/sound/soc/mid-x86/sst_platform.c
@@ -1,7 +1,7 @@
 /*
  *  sst_platform.c - Intel MID Platform driver
  *
- *  Copyright (C) 2010-2012 Intel Corp
+ *  Copyright (C) 2010-2013 Intel Corp
  *  Author: Vinod Koul <vinod.koul@intel.com>
  *  Author: Harsha Priya <priya.harsha@intel.com>
  *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -652,11 +652,21 @@ static int sst_platform_compr_get_codec_caps(struct snd_compr_stream *cstream,
 	return stream->compr_ops->get_codec_caps(codec);
 }
 
+static int sst_platform_compr_set_metadata(struct snd_compr_stream *cstream,
+					struct snd_compr_metadata *metadata)
+{
+	struct sst_runtime_stream *stream  =
+		 cstream->runtime->private_data;
+
+	return stream->compr_ops->set_metadata(stream->id, metadata);
+}
+
 static struct snd_compr_ops sst_platform_compr_ops = {
 
 	.open = sst_platform_compr_open,
 	.free = sst_platform_compr_free,
 	.set_params = sst_platform_compr_set_params,
+	.set_metadata = sst_platform_compr_set_metadata,
 	.trigger = sst_platform_compr_trigger,
 	.pointer = sst_platform_compr_pointer,
 	.ack = sst_platform_compr_ack,
diff --git a/sound/soc/mid-x86/sst_platform.h b/sound/soc/mid-x86/sst_platform.h
index d61c5d5..cacc906 100644
--- a/sound/soc/mid-x86/sst_platform.h
+++ b/sound/soc/mid-x86/sst_platform.h
@@ -124,6 +124,8 @@ struct compress_sst_ops {
 	int (*close) (unsigned int str_id);
 	int (*get_caps) (struct snd_compr_caps *caps);
 	int (*get_codec_caps) (struct snd_compr_codec_caps *codec);
+	int (*set_metadata) (unsigned int str_id,
+			struct snd_compr_metadata *mdata);
 
 };
 
-- 
1.7.0.4
