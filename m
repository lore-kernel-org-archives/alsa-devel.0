From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ASoC: Intel: Skylake: Modify the log level
Date: Wed,  7 Oct 2015 16:39:38 +0100
Message-ID: <1444232378-8898-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 33AF52614DD
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2015 17:40:24 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

dev_info is too noisy for tplg wiget loading, so move it to
debug level

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index b1bffa52cbcd..a5d8420ce69a 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1178,7 +1178,7 @@ static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
 
 bind_event:
 	if (tplg_w->event_type == 0) {
-		dev_info(bus->dev, "ASoC: No event handler required\n");
+		dev_dbg(bus->dev, "ASoC: No event handler required\n");
 		return 0;
 	}
 
-- 
2.4.3
