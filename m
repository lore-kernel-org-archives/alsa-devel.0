From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/3] ASoC: Intel: Skylake: remove module id
	query at runtime
Date: Wed, 10 Aug 2016 09:40:50 +0530
Message-ID: <1470802250-9232-4-git-send-email-vinod.koul@intel.com>
References: <1470802250-9232-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A5CA265ADE
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 06:03:18 +0200 (CEST)
In-Reply-To: <1470802250-9232-1-git-send-email-vinod.koul@intel.com>
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

Now that we have balanced loading of the topology file and split of init
and fw_init and fill module data during asoc probe.

So remove it from runtime, but keep error check in case things fall apart.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index c09e2c7608a3..4bc8f9c269db 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -475,12 +475,10 @@ skl_tplg_init_pipe_modules(struct skl *skl, struct skl_pipe *pipe)
 
 		/* check if module ids are populated */
 		if (mconfig->id.module_id < 0) {
-			ret = snd_skl_get_module_info(skl->skl_sst, mconfig);
-			if (ret < 0) {
-				dev_err(skl->skl_sst->dev,
-					"query module info failed: %d\n", ret);
-				return ret;
-			}
+			dev_err(skl->skl_sst->dev,
+					"module %pUL id not populated\n",
+					(uuid_le *)mconfig->guid);
+			return -EIO;
 		}
 
 		/* check resource available */
-- 
1.9.1
