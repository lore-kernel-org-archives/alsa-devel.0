From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH 07/11] ASoC: Intel: Skylake: Optimize UUID
	handling to fill pin info
Date: Tue,  7 Nov 2017 16:16:22 +0530
Message-ID: <20171107104626.25800-8-guneshwor.o.singh@intel.com>
References: <20171107104626.25800-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id D55CE267399
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 11:47:30 +0100 (CET)
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

Modify skl_tplg_get_uuid() to copy just UUID rather than only
for module UUID and skl_tplg_fill_pin() to fill the pin info
which can include UUID token also.

Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 46 +++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 036779fb5807..342943f6069b 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2036,21 +2036,35 @@ static int skl_tplg_add_pipe(struct device *dev,
 	return 0;
 }
 
-static int skl_tplg_fill_pin(struct device *dev, u32 tkn,
+static int skl_tplg_get_uuid(struct device *dev, u8 *guid,
+	      struct snd_soc_tplg_vendor_uuid_elem *uuid_tkn)
+{
+	if (uuid_tkn->token == SKL_TKN_UUID) {
+		memcpy(guid, &uuid_tkn->uuid, 16);
+		return 0;
+	}
+
+	dev_err(dev, "Not an UUID token %d\n", uuid_tkn->token);
+
+	return -EINVAL;
+}
+
+static int skl_tplg_fill_pin(struct device *dev,
+			struct snd_soc_tplg_vendor_value_elem *tkn_elem,
 			struct skl_module_pin *m_pin,
-			int pin_index, u32 value)
+			int pin_index)
 {
-	switch (tkn) {
+	switch (tkn_elem->token) {
 	case SKL_TKN_U32_PIN_MOD_ID:
-		m_pin[pin_index].id.module_id = value;
+		m_pin[pin_index].id.module_id = tkn_elem->value;
 		break;
 
 	case SKL_TKN_U32_PIN_INST_ID:
-		m_pin[pin_index].id.instance_id = value;
+		m_pin[pin_index].id.instance_id = tkn_elem->value;
 		break;
 
 	default:
-		dev_err(dev, "%d Not a pin token\n", value);
+		dev_err(dev, "%d Not a pin token\n", tkn_elem->token);
 		return -EINVAL;
 	}
 
@@ -2083,9 +2097,7 @@ static int skl_tplg_fill_pins_info(struct device *dev,
 		return -EINVAL;
 	}
 
-	ret = skl_tplg_fill_pin(dev, tkn_elem->token,
-			m_pin, pin_count, tkn_elem->value);
-
+	ret = skl_tplg_fill_pin(dev, tkn_elem, m_pin, pin_count);
 	if (ret < 0)
 		return ret;
 
@@ -2170,19 +2182,6 @@ static int skl_tplg_widget_fill_fmt(struct device *dev,
 	return skl_tplg_fill_fmt(dev, dst_fmt, tkn, val);
 }
 
-static int skl_tplg_get_uuid(struct device *dev, struct skl_module_cfg *mconfig,
-	      struct snd_soc_tplg_vendor_uuid_elem *uuid_tkn)
-{
-	if (uuid_tkn->token == SKL_TKN_UUID)
-		memcpy(&mconfig->guid, &uuid_tkn->uuid, 16);
-	else {
-		dev_err(dev, "Not an UUID token tkn %d\n", uuid_tkn->token);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static void skl_tplg_fill_pin_dynamic_val(
 		struct skl_module_pin *mpin, u32 pin_count, u32 value)
 {
@@ -2565,7 +2564,8 @@ static int skl_tplg_get_tokens(struct device *dev,
 			continue;
 
 		case SND_SOC_TPLG_TUPLE_TYPE_UUID:
-			ret = skl_tplg_get_uuid(dev, mconfig, array->uuid);
+			ret = skl_tplg_get_uuid(dev, mconfig->guid,
+					array->uuid);
 			if (ret < 0)
 				return ret;
 
-- 
2.14.2
