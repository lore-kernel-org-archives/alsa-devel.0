From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 8/8] ASoC: Intel: move component
	registration blob
Date: Mon,  5 May 2014 22:19:25 +0530
Message-ID: <1399308565-14620-9-git-send-email-vinod.koul@intel.com>
References: <1399308565-14620-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id BFF922619FA
 for <alsa-devel@alsa-project.org>; Mon,  5 May 2014 19:03:02 +0200 (CEST)
In-Reply-To: <1399308565-14620-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, jeeja.kp@intel.com, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

to the place near it is used

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 380802a..7c790f5 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -122,10 +122,6 @@ static struct snd_soc_dai_driver sst_platform_dai[] = {
 },
 };
 
-static const struct snd_soc_component_driver sst_component = {
-	.name		= "sst",
-};
-
 /* helper functions */
 void sst_set_stream_status(struct sst_runtime_stream *stream,
 					int state)
@@ -442,6 +438,11 @@ static struct snd_soc_platform_driver sst_soc_platform_drv = {
 	.pcm_free	= sst_pcm_free,
 };
 
+static const struct snd_soc_component_driver sst_component = {
+	.name		= "sst",
+};
+
+
 static int sst_platform_probe(struct platform_device *pdev)
 {
 	int ret;
-- 
1.7.0.4
