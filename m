From: zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH 2/2] sound: skl-topology: Use kmemdup to replace kzalloc + memcpy
Date: Sat, 8 Sep 2018 16:36:20 +0800
Message-ID: <1536395780-18725-3-git-send-email-zhongjiang@huawei.com>
References: <1536395780-18725-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536395780-18725-1-git-send-email-zhongjiang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com, perex@perex.cz, broonie@kernel.org
Cc: lgirdwood@gmail.com, bgoswami@codeaurora.org, plai@codeaurora.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

kmemdup has implemented the function that kzalloc() + memcpy() will
do. and we prefer to kmemdup rather than the open coded implementation.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 sound/soc/intel/skylake/skl-topology.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 2620d77..52a9915 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -898,11 +898,10 @@ static int skl_tplg_set_module_bind_params(struct snd_soc_dapm_widget *w,
 			bc = (struct skl_algo_data *)sb->dobj.private;
 
 			if (bc->set_params == SKL_PARAM_BIND) {
-				params = kzalloc(bc->max, GFP_KERNEL);
+				params = kmemdup(bc->params, bc->max, GFP_KERNEL);
 				if (!params)
 					return -ENOMEM;
 
-				memcpy(params, bc->params, bc->max);
 				skl_fill_sink_instance_id(ctx, params, bc->max,
 								mconfig);
 
-- 
1.7.12.4
