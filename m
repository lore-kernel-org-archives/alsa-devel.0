From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add dynamic module id
	support" to the asoc tree
Date: Wed, 08 Nov 2017 21:32:56 +0000
Message-ID: <E1eCXxw-0005Uc-NZ@debutante>
References: <20171107104626.25800-9-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D738D2676A5
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 22:33:46 +0100 (CET)
In-Reply-To: <20171107104626.25800-9-guneshwor.o.singh@intel.com>
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

   ASoC: Intel: Skylake: Add dynamic module id support

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

>From d956147473ec1843c2660a89ef0fba80b66c6657 Mon Sep 17 00:00:00 2001
From: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Date: Tue, 7 Nov 2017 16:16:23 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add dynamic module id support

Module id is a property of firmware manifest and can vary between
platforms so use the uuid instead of module id for pins.

Signed-off-by: Sriram Periyasamy <sriramx.periyasamy@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 90f8c839bcef..b590742c5a7a 100644
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
2.15.0
