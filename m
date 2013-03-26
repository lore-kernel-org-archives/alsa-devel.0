From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/2] ASoC: compress - add support for metadata
	apis
Date: Tue, 26 Mar 2013 21:22:28 +0530
Message-ID: <1364313149-18569-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E8822650DE
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2013 17:18:50 +0100 (CET)
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

From: Jeeja KP <jeeja.kp@intel.com>

Compress core added metadata apis in 9727b4, so add same in ASoC

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
Rebased on asoc-next

 sound/soc/soc-compress.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index b5b3db7..f9b2197 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -322,11 +322,38 @@ static int soc_compr_copy(struct snd_compr_stream *cstream,
 	return ret;
 }
 
+static int sst_compr_set_metadata(struct snd_compr_stream *cstream,
+				struct snd_compr_metadata *metadata)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+	int ret = 0;
+
+	if (platform->driver->compr_ops && platform->driver->compr_ops->set_metadata)
+		ret = platform->driver->compr_ops->set_metadata(cstream, metadata);
+
+	return ret;
+}
+
+static int sst_compr_get_metadata(struct snd_compr_stream *cstream,
+				struct snd_compr_metadata *metadata)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+	int ret = 0;
+
+	if (platform->driver->compr_ops && platform->driver->compr_ops->get_metadata)
+		ret = platform->driver->compr_ops->get_metadata(cstream, metadata);
+
+	return ret;
+}
 /* ASoC Compress operations */
 static struct snd_compr_ops soc_compr_ops = {
 	.open		= soc_compr_open,
 	.free		= soc_compr_free,
 	.set_params	= soc_compr_set_params,
+	.set_metadata   = sst_compr_set_metadata,
+	.get_metadata	= sst_compr_get_metadata,
 	.get_params	= soc_compr_get_params,
 	.trigger	= soc_compr_trigger,
 	.pointer	= soc_compr_pointer,
-- 
1.7.0.4
