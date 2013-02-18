From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/2] ASoC: compress - add support for metadata
	apis
Date: Mon, 18 Feb 2013 15:59:40 +0530
Message-ID: <1361183381-30010-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 32E9B264F07
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 11:30:34 +0100 (CET)
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
Cc: tiwai@suse.de, Jeeja KP <jeeja.kp@intel.com>, broonie@opensource.wolfsonmicro.com, Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

Compress core added metadata apis in 9727b4, so add same in ASoC

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
Mark, Takashi:
How do you guys wnat to take this one, Ideally this should go to mark's tree but
the dependent apis are in takashi's tree, either way is fine with me :)
---
 sound/soc/soc-compress.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 3ea7956..4730789 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -302,11 +302,38 @@ static int soc_compr_pointer(struct snd_compr_stream *cstream,
 	return 0;
 }
 
+static int sst_compr_set_metadata(struct snd_compr_stream *cstream,
+				struct snd_compr_metadata *metadata)
+{
+	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
+	struct snd_soc_platform *platform = rtd->platform;
+	int ret = 0;
+
+	if (platform->driver->compr_ops && platform->driver->compr_ops->pointer)
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
+	if (platform->driver->compr_ops && platform->driver->compr_ops->pointer)
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
