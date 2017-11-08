From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Optimize UUID handling
	to fill pin info" to the asoc tree
Date: Wed, 08 Nov 2017 21:33:03 +0000
Message-ID: <E1eCXy3-0005Vo-O5@debutante>
References: <20171107104626.25800-8-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D3CA2676A6
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:33:48 +0100 (CET)
In-Reply-To: <20171107104626.25800-8-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Optimize UUID handling to fill pin info

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 22ebd6666efd8663a06715a052f74b6a7e904dc3 Mon Sep 17 00:00:00 2001
From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Date: Tue, 7 Nov 2017 16:16:22 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Optimize UUID handling to fill pin info

Modify skl_tplg_get_uuid() to copy just UUID rather than only
for module UUID and skl_tplg_fill_pin() to fill the pin info
which can include UUID token also.

Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 46 +++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 1200b7c6af56..90f8c839bcef 100644
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
2.15.0
