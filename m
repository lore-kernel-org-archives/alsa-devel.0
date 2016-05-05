From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/2] ASoC: topology: Fix memory leak in widget
	creation
Date: Thu,  5 May 2016 11:19:18 +0530
Message-ID: <1462427359-30402-2-git-send-email-vinod.koul@intel.com>
References: <1462427359-30402-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id AE7372652D7
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 07:43:21 +0200 (CEST)
In-Reply-To: <1462427359-30402-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Jeeja KP <jeeja.kp@intel.com>

name and sname allocated in widget create are not freed when
creation is successful, so free them.

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/soc-topology.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 1cf94d7fb9f4..ff95c3a7b8a3 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1476,6 +1476,8 @@ widget:
 	widget->dobj.type = SND_SOC_DOBJ_WIDGET;
 	widget->dobj.ops = tplg->ops;
 	widget->dobj.index = tplg->index;
+	kfree(template.sname);
+	kfree(template.name);
 	list_add(&widget->dobj.list, &tplg->comp->dobj_list);
 	return 0;
 
-- 
1.9.1
