From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 11/19] ASoC: intel: mfld-pcm: don't call
	trigger ops to DSP for internal streams
Date: Fri, 13 Jun 2014 18:04:00 +0530
Message-ID: <1402662848-24534-12-git-send-email-vinod.koul@intel.com>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 353D6261B1E
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 14:33:06 +0200 (CEST)
In-Reply-To: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
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
Cc: Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, lgirdwood@gmail.com, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

For internal stream i.e BE we have don't need trigger ops as that would be
handled by DAPM for us in subsequent patches

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst-mfld-platform-pcm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/intel/sst-mfld-platform-pcm.c b/sound/soc/intel/sst-mfld-platform-pcm.c
index 8df5aca..0fbb688 100644
--- a/sound/soc/intel/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/sst-mfld-platform-pcm.c
@@ -519,6 +519,8 @@ static int sst_platform_pcm_trigger(struct snd_pcm_substream *substream,
 	int str_cmd, status;
 
 	pr_debug("sst_platform_pcm_trigger called\n");
+	if (substream->pcm->internal)
+		return 0;
 	stream = substream->runtime->private_data;
 	str_id = stream->stream_info.str_id;
 	switch (cmd) {
-- 
1.7.0.4
