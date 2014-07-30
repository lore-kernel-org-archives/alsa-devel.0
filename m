From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: [v3 03/13] ASoC: intel: mfld-pcm: don't call trigger
	ops to DSP for internal streams
Date: Wed, 30 Jul 2014 18:32:20 +0530
Message-ID: <1406725350-23275-4-git-send-email-subhransu.s.prusty@intel.com>
References: <1406725350-23275-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id B701D261683
 for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2014 15:23:58 +0200 (CEST)
In-Reply-To: <1406725350-23275-1-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: vinod.koul@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

For internal stream i.e. BE we have don't need trigger ops as that would be
handled by DAPM for us in subsequent patches

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index f0923561226e..e5607cf198dc 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -527,6 +527,8 @@ static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 	int str_cmd, status;
 
 	pr_debug("sst_platform_pcm_trigger called\n");
+	if (substream->pcm->internal)
+		return 0;
 	stream = substream->runtime->private_data;
 	str_id = stream->stream_info.str_id;
 	switch (cmd) {
-- 
1.9.0
