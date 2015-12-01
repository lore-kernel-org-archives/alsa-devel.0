From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add tlv byte kcontrols"
	to the asoc tree
Date: Tue, 01 Dec 2015 22:59:36 +0000
Message-ID: <E1a3ttY-00061e-Vl@debutante>
References: <1448703121-5831-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C87DA2663E1
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 23:59:45 +0100 (CET)
In-Reply-To: <1448703121-5831-6-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mythri P K <mythri.p.k@intel.com>, Divya Prakash <divya1.prakash@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add tlv byte kcontrols

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 140adfba5280617487a848a0fa84f7523d999cf3 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Sat, 28 Nov 2015 15:01:50 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add tlv byte kcontrols

This adds tlv bytes topology control creation and control load to
initialize kcontrol data. And this also adds the callbacks for
the these tlv byte kcontrols

Signed-off-by: Mythri P K <mythri.p.k@intel.com>
Signed-off-by: Divya Prakash <divya1.prakash@intel.com>
Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-topology.c       | 121 +++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-tplg-interface.h |   7 +-
 2 files changed, 123 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index bfc138df56bc..622f7430e100 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -875,6 +875,60 @@ static int skl_tplg_pga_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static int skl_tplg_tlv_control_get(struct snd_kcontrol *kcontrol,
+			unsigned int __user *data, unsigned int size)
+{
+	struct soc_bytes_ext *sb =
+			(struct soc_bytes_ext *)kcontrol->private_value;
+	struct skl_algo_data *bc = (struct skl_algo_data *)sb->dobj.private;
+
+	if (bc->params) {
+		if (copy_to_user(data, &bc->param_id, sizeof(u32)))
+			return -EFAULT;
+		if (copy_to_user(data + sizeof(u32), &size, sizeof(u32)))
+			return -EFAULT;
+		if (copy_to_user(data + 2 * sizeof(u32), bc->params, size))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+#define SKL_PARAM_VENDOR_ID 0xff
+
+static int skl_tplg_tlv_control_set(struct snd_kcontrol *kcontrol,
+			const unsigned int __user *data, unsigned int size)
+{
+	struct snd_soc_dapm_widget *w = snd_soc_dapm_kcontrol_widget(kcontrol);
+	struct skl_module_cfg *mconfig = w->priv;
+	struct soc_bytes_ext *sb =
+			(struct soc_bytes_ext *)kcontrol->private_value;
+	struct skl_algo_data *ac = (struct skl_algo_data *)sb->dobj.private;
+	struct skl *skl = get_skl_ctx(w->dapm->dev);
+
+	if (ac->params) {
+		/*
+		 * if the param_is is of type Vendor, firmware expects actual
+		 * parameter id and size from the control.
+		 */
+		if (ac->param_id == SKL_PARAM_VENDOR_ID) {
+			if (copy_from_user(ac->params, data, size))
+				return -EFAULT;
+		} else {
+			if (copy_from_user(ac->params,
+					   data + 2 * sizeof(u32), size))
+				return -EFAULT;
+		}
+
+		if (w->power)
+			return skl_set_module_params(skl->skl_sst,
+						(u32 *)ac->params, ac->max,
+						ac->param_id, mconfig);
+	}
+
+	return 0;
+}
+
 /*
  * The FE params are passed by hw_params of the DAI.
  * On hw_params, the params are stored in Gateway module of the FE and we
@@ -1125,6 +1179,11 @@ static const struct snd_soc_tplg_widget_events skl_tplg_widget_ops[] = {
 	{SKL_PGA_EVENT, skl_tplg_pga_event},
 };
 
+static const struct snd_soc_tplg_bytes_ext_ops skl_tlv_ops[] = {
+	{SKL_CONTROL_TYPE_BYTE_TLV, skl_tplg_tlv_control_get,
+					skl_tplg_tlv_control_set},
+};
+
 /*
  * The topology binary passes the pin info for a module so initialize the pin
  * info passed into module instance
@@ -1321,8 +1380,70 @@ bind_event:
 	return 0;
 }
 
+static int skl_init_algo_data(struct device *dev, struct soc_bytes_ext *be,
+					struct snd_soc_tplg_bytes_control *bc)
+{
+	struct skl_algo_data *ac;
+	struct skl_dfw_algo_data *dfw_ac =
+				(struct skl_dfw_algo_data *)bc->priv.data;
+
+	ac = devm_kzalloc(dev, sizeof(*ac), GFP_KERNEL);
+	if (!ac)
+		return -ENOMEM;
+
+	/* Fill private data */
+	ac->max = dfw_ac->max;
+	ac->param_id = dfw_ac->param_id;
+	ac->set_params = dfw_ac->set_params;
+
+	if (ac->max) {
+		ac->params = (char *) devm_kzalloc(dev, ac->max, GFP_KERNEL);
+		if (!ac->params)
+			return -ENOMEM;
+
+		if (dfw_ac->params)
+			memcpy(ac->params, dfw_ac->params, ac->max);
+	}
+
+	be->dobj.private  = ac;
+	return 0;
+}
+
+static int skl_tplg_control_load(struct snd_soc_component *cmpnt,
+				struct snd_kcontrol_new *kctl,
+				struct snd_soc_tplg_ctl_hdr *hdr)
+{
+	struct soc_bytes_ext *sb;
+	struct snd_soc_tplg_bytes_control *tplg_bc;
+	struct hdac_ext_bus *ebus  = snd_soc_component_get_drvdata(cmpnt);
+	struct hdac_bus *bus = ebus_to_hbus(ebus);
+
+	switch (hdr->ops.info) {
+	case SND_SOC_TPLG_CTL_BYTES:
+		tplg_bc = container_of(hdr,
+				struct snd_soc_tplg_bytes_control, hdr);
+		if (kctl->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
+			sb = (struct soc_bytes_ext *)kctl->private_value;
+			if (tplg_bc->priv.size)
+				return skl_init_algo_data(
+						bus->dev, sb, tplg_bc);
+		}
+		break;
+
+	default:
+		dev_warn(bus->dev, "Control load not supported %d:%d:%d\n",
+			hdr->ops.get, hdr->ops.put, hdr->ops.info);
+		break;
+	}
+
+	return 0;
+}
+
 static struct snd_soc_tplg_ops skl_tplg_ops  = {
 	.widget_load = skl_tplg_widget_load,
+	.control_load = skl_tplg_control_load,
+	.bytes_ext_ops = skl_tlv_ops,
+	.bytes_ext_ops_count = ARRAY_SIZE(skl_tlv_ops),
 };
 
 /* This will be read from topology manifest, currently defined here */
diff --git a/sound/soc/intel/skylake/skl-tplg-interface.h b/sound/soc/intel/skylake/skl-tplg-interface.h
index 63c83a3eeb7e..3f1908e3ae80 100644
--- a/sound/soc/intel/skylake/skl-tplg-interface.h
+++ b/sound/soc/intel/skylake/skl-tplg-interface.h
@@ -23,10 +23,7 @@
  * Default types range from 0~12. type can range from 0 to 0xff
  * SST types start at higher to avoid any overlapping in future
  */
-#define SOC_CONTROL_TYPE_HDA_SST_ALGO_PARAMS	0x100
-#define SOC_CONTROL_TYPE_HDA_SST_MUX		0x101
-#define SOC_CONTROL_TYPE_HDA_SST_MIX		0x101
-#define SOC_CONTROL_TYPE_HDA_SST_BYTE		0x103
+#define SKL_CONTROL_TYPE_BYTE_TLV	0x100
 
 #define HDA_SST_CFG_MAX	900 /* size of copier cfg*/
 #define MAX_IN_QUEUE 8
@@ -218,8 +215,8 @@ struct skl_dfw_module {
 struct skl_dfw_algo_data {
 	u32 set_params:1;
 	u32 rsvd:31;
-	u32 param_id;
 	u32 max;
+	u32 param_id;
 	char params[0];
 } __packed;
 
-- 
2.6.2
