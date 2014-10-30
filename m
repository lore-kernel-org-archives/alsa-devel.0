From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/4] ASoC: mfld-compress: implement .power
	callback
Date: Thu, 30 Oct 2014 16:20:58 +0530
Message-ID: <1414666259-4450-4-git-send-email-vinod.koul@intel.com>
References: <1414666259-4450-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id AACEC2605E3
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 12:31:53 +0100 (CET)
In-Reply-To: <1414666259-4450-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>

.power callback is required to invoked for compressed audio as well to turn
on/off sst, so invoke them

Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-compress.c |    8 +++++++-
 sound/soc/intel/sst-mfld-platform.h          |    1 +
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-compress.c b/sound/soc/intel/sst-mfld-platform-compress.c
index 5946777..3951689 100644
--- a/sound/soc/intel/sst-mfld-platform-compress.c
+++ b/sound/soc/intel/sst-mfld-platform-compress.c
@@ -67,8 +67,11 @@ static int sst_platform_compr_open(struct snd_compr_stream *cstream)
 		goto out_ops;
 	}
 	stream->compr_ops = sst->compr_ops;
-
 	stream->id = 0;
+
+	/* Turn on LPE */
+	sst->compr_ops->power(sst->dev, true);
+
 	sst_set_stream_status(stream, SST_PLATFORM_INIT);
 	runtime->private_data = stream;
 	return 0;
@@ -83,6 +86,9 @@ static int sst_platform_compr_free(struct snd_compr_stream *cstream)
 	int ret_val = 0, str_id;
 
 	stream = cstream->runtime->private_data;
+	/* Turn off LPE */
+	sst->compr_ops->power(sst->dev, false);
+
 	/*need to check*/
 	str_id = stream->id;
 	if (str_id)
diff --git a/sound/soc/intel/sst-mfld-platform.h b/sound/soc/intel/sst-mfld-platform.h
index d41d1c3..79c8d12 100644
--- a/sound/soc/intel/sst-mfld-platform.h
+++ b/sound/soc/intel/sst-mfld-platform.h
@@ -117,6 +117,7 @@ struct compress_sst_ops {
 	int (*get_codec_caps)(struct snd_compr_codec_caps *codec);
 	int (*set_metadata)(struct device *dev,	unsigned int str_id,
 			struct snd_compr_metadata *mdata);
+	int (*power)(struct device *dev, bool state);
 };
 
 struct sst_ops {
-- 
1.7.0.4
