From: Xiuli Pan <xiuli.pan@linux.intel.com>
Subject: [FIX][PATCH] ASoC: topology: Fix logical inversion in
	set_link_hw_format()
Date: Fri, 23 Feb 2018 06:01:28 +0800
Message-ID: <1519336888-71831-1-git-send-email-xiuli.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 17443267871
 for <alsa-devel@alsa-project.org>; Fri, 23 Feb 2018 08:43:06 +0100 (CET)
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
Cc: Mark Brown <broonie@kernel.org>, Pan Xiuli <xiuli.pan@linux.intel.com>, xiuli.pan@intel.com
List-Id: alsa-devel@alsa-project.org

From: Pan Xiuli <xiuli.pan@linux.intel.com>

The master/slave conventions are wrt. the codec. The topology code
contains a logical inversion, fix to follow ASoC usage.

Signed-off-by: Pan Xiuli <xiuli.pan@linux.intel.com>
---
 sound/soc/soc-topology.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 561f74d..2931248 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2030,11 +2030,11 @@ static void set_link_hw_format(struct snd_soc_dai_link *link,
 		/* clock masters */
 		bclk_master = hw_config->bclk_master;
 		fsync_master = hw_config->fsync_master;
-		if (!bclk_master && !fsync_master)
+		if (bclk_master && fsync_master)
 			link->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
-		else if (bclk_master && !fsync_master)
-			link->dai_fmt |= SND_SOC_DAIFMT_CBS_CFM;
 		else if (!bclk_master && fsync_master)
+			link->dai_fmt |= SND_SOC_DAIFMT_CBS_CFM;
+		else if (bclk_master && !fsync_master)
 			link->dai_fmt |= SND_SOC_DAIFMT_CBM_CFS;
 		else
 			link->dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
-- 
2.7.4
