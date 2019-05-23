From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ASoC: Intel: Skylake: Use struct_size() helper
Date: Thu, 23 May 2019 17:23:33 -0500
Message-ID: <20190523222333.GA22695@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace the following form:

uuid_params->num_modules * sizeof(struct skl_mod_inst_map) + sizeof(uuid_params->num_modules)

with:

struct_size(params, u.map, uuid_params->num_modules)

and so on...

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/soc/intel/skylake/skl-topology.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 389f1862bc43..c69d999d7bf1 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -941,9 +941,7 @@ static int skl_tplg_find_moduleid_from_uuid(struct skl *skl,
 
 	if (bc->set_params == SKL_PARAM_BIND && bc->max) {
 		uuid_params = (struct skl_kpb_params *)bc->params;
-		size = uuid_params->num_modules *
-			sizeof(struct skl_mod_inst_map) +
-			sizeof(uuid_params->num_modules);
+		size = struct_size(params, u.map, uuid_params->num_modules);
 
 		params = devm_kzalloc(bus->dev, size, GFP_KERNEL);
 		if (!params)
@@ -3315,7 +3313,7 @@ static int skl_tplg_get_int_tkn(struct device *dev,
 		struct snd_soc_tplg_vendor_value_elem *tkn_elem,
 		struct skl *skl)
 {
-	int tkn_count = 0, ret, size;
+	int tkn_count = 0, ret;
 	static int mod_idx, res_val_idx, intf_val_idx, dir, pin_idx;
 	struct skl_module_res *res = NULL;
 	struct skl_module_iface *fmt = NULL;
@@ -3323,6 +3321,7 @@ static int skl_tplg_get_int_tkn(struct device *dev,
 	static struct skl_astate_param *astate_table;
 	static int astate_cfg_idx, count;
 	int i;
+	size_t size;
 
 	if (skl->modules) {
 		mod = skl->modules[mod_idx];
@@ -3366,8 +3365,8 @@ static int skl_tplg_get_int_tkn(struct device *dev,
 			return -EINVAL;
 		}
 
-		size = tkn_elem->value * sizeof(struct skl_astate_param) +
-				sizeof(count);
+		size = struct_size(skl->cfg.astate_cfg, astate_table,
+				   tkn_elem->value);
 		skl->cfg.astate_cfg = devm_kzalloc(dev, size, GFP_KERNEL);
 		if (!skl->cfg.astate_cfg)
 			return -ENOMEM;
-- 
2.21.0
