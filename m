From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 08/11] ASoC: Intel: Skylake: Add dynamic module
	id support
Date: Tue,  7 Nov 2017 16:16:23 +0530
Message-ID: <20171107104626.25800-9-guneshwor.o.singh@intel.com>
References: <20171107104626.25800-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A9E06267386
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 11:47:34 +0100 (CET)
In-Reply-To: <20171107104626.25800-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA ML <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Sriram Periyasamy <sriramx.periyasamy@intel.com>

Module id is a property of firmware manifest and can vary between
platforms so use the uuid instead of module id for pins.

Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 342943f6069b..a072bcf209d2 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2054,6 +2054,8 @@ static int skl_tplg_fill_pin(struct device *dev,
 			struct skl_module_pin *m_pin,
 			int pin_index)
 {
+	int ret;
+
 	switch (tkn_elem->token) {
 	case SKL_TKN_U32_PIN_MOD_ID:
 		m_pin[pin_index].id.module_id = tkn_elem->value;
@@ -2063,6 +2065,14 @@ static int skl_tplg_fill_pin(struct device *dev,
 		m_pin[pin_index].id.instance_id = tkn_elem->value;
 		break;
 
+	case SKL_TKN_UUID:
+		ret = skl_tplg_get_uuid(dev, m_pin[pin_index].id.mod_uuid.b,
+			(struct snd_soc_tplg_vendor_uuid_elem *)tkn_elem);
+		if (ret < 0)
+			return ret;
+
+		break;
+
 	default:
 		dev_err(dev, "%d Not a pin token\n", tkn_elem->token);
 		return -EINVAL;
@@ -2487,6 +2497,7 @@ static int skl_tplg_get_token(struct device *dev,
 
 	case SKL_TKN_U32_PIN_MOD_ID:
 	case SKL_TKN_U32_PIN_INST_ID:
+	case SKL_TKN_UUID:
 		ret = skl_tplg_fill_pins_info(dev,
 				mconfig, tkn_elem, dir,
 				pin_index);
@@ -2549,6 +2560,7 @@ static int skl_tplg_get_tokens(struct device *dev,
 	struct snd_soc_tplg_vendor_value_elem *tkn_elem;
 	int tkn_count = 0, ret;
 	int off = 0, tuple_size = 0;
+	bool is_module_guid = true;
 
 	if (block_size <= 0)
 		return -EINVAL;
@@ -2564,8 +2576,15 @@ static int skl_tplg_get_tokens(struct device *dev,
 			continue;
 
 		case SND_SOC_TPLG_TUPLE_TYPE_UUID:
-			ret = skl_tplg_get_uuid(dev, mconfig->guid,
-					array->uuid);
+			if (is_module_guid) {
+				ret = skl_tplg_get_uuid(dev, mconfig->guid,
+							array->uuid);
+				is_module_guid = false;
+			} else {
+				ret = skl_tplg_get_token(dev, array->value, skl,
+							 mconfig);
+			}
+
 			if (ret < 0)
 				return ret;
 
-- 
2.14.2
