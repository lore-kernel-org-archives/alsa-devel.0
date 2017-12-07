From: Naveen Manohar <naveen.m@intel.com>
Subject: [PATCH] ASoC: Change kern log level to avoid unwanted
	messages
Date: Thu,  7 Dec 2017 22:32:40 +0530
Message-ID: <1512666160-30729-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 21B872671B1
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 18:03:22 +0100 (CET)
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
Cc: vinod.koul@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, naveen.m@intel.com, harshapriya.n@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

patch suppresses the warning message "control load not supported"
as this is a debug information to help debug issues in topology.

Signed-off-by: Naveen Manohar <naveen.m@intel.com>

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index a072bcf..81923da 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2908,7 +2908,7 @@ static int skl_tplg_control_load(struct snd_soc_component *cmpnt,
 		break;
 
 	default:
-		dev_warn(bus->dev, "Control load not supported %d:%d:%d\n",
+		dev_dbg(bus->dev, "Control load not supported %d:%d:%d\n",
 			hdr->ops.get, hdr->ops.put, hdr->ops.info);
 		break;
 	}
-- 
1.9.1
