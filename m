From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v2 3/5] ASoC: intel: fix the kernldoc comment
Date: Mon, 20 Oct 2014 19:13:46 +0530
Message-ID: <1413812628-13325-4-git-send-email-vinod.koul@intel.com>
References: <1413812628-13325-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 832CB266AD0
 for <alsa-devel@alsa-project.org>; Mon, 20 Oct 2014 16:21:13 +0200 (CEST)
In-Reply-To: <1413812628-13325-1-git-send-email-vinod.koul@intel.com>
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

copypaste error on function sst_get_num_channel caused the comment to be
wrong, so fix it here

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/sst/sst_drv_interface.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/intel/sst/sst_drv_interface.c b/sound/soc/intel/sst/sst_drv_interface.c
index 3a5e920..183b1eb 100644
--- a/sound/soc/intel/sst/sst_drv_interface.c
+++ b/sound/soc/intel/sst/sst_drv_interface.c
@@ -94,7 +94,7 @@ int sst_get_sfreq(struct snd_sst_params *str_param)
 }
 
 /*
- * sst_get_sfreq - this function returns the frequency of the stream
+ * sst_get_num_channel - get number of channels for the stream
  *
  * @str_param : stream params
  */
-- 
1.7.0.4
