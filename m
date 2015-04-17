From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/2] ASoC: intel - use
	SNDRV_CTL_ELEM_ID_NAME_MAXLEN
Date: Fri, 17 Apr 2015 22:53:33 +0530
Message-ID: <1429291413-30668-2-git-send-email-vinod.koul@intel.com>
References: <1429291413-30668-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E2DB026060B
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 19:28:40 +0200 (CEST)
In-Reply-To: <1429291413-30668-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

we have defined SNDRV_CTL_ELEM_ID_NAME_MAXLEN as size of name array so use
this define instead of numeric value

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/atom/sst-atom-controls.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.h b/sound/soc/intel/atom/sst-atom-controls.h
index daecc58f28af..c55f76a535b3 100644
--- a/sound/soc/intel/atom/sst-atom-controls.h
+++ b/sound/soc/intel/atom/sst-atom-controls.h
@@ -695,7 +695,7 @@ struct sst_gain_mixer_control {
 	u16 module_id;
 	u16 pipe_id;
 	u16 task_id;
-	char pname[44];
+	char pname[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	struct snd_soc_dapm_widget *w;
 };
 
-- 
1.7.9.5
