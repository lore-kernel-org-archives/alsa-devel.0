From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH v3 2/4] ASoC: Intel: Skylake: Debugfs facility
	to dump module config
Date: Thu, 29 Jun 2017 18:06:05 +0530
Message-ID: <20170629123608.5498-3-guneshwor.o.singh@intel.com>
References: <20170629123608.5498-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C595267354
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 14:37:04 +0200 (CEST)
In-Reply-To: <20170629123608.5498-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Patches Audio <patches.audio@intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, Vunny Sodhi <vunnyx.sodhi@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

Driver modules have lot of information represented in struct
skl_module_cfg. Knowing this is useful for debug, so enable
debugfs for this structure.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Vunny Sodhi <vunnyx.sodhi@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-debug.c    | 156 +++++++++++++++++++++++++++++++++
 sound/soc/intel/skylake/skl-topology.c |   3 +
 sound/soc/intel/skylake/skl.h          |  10 +++
 3 files changed, 169 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
index 1de300ded4e3..42d58295051e 100644
--- a/sound/soc/intel/skylake/skl-debug.c
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -16,14 +16,159 @@
 #include <linux/pci.h>
 #include <linux/debugfs.h>
 #include "skl.h"
+#include "skl-tplg-interface.h"
+#include "skl-topology.h"
+
+#define MOD_BUF		PAGE_SIZE
 
 struct skl_debug {
 	struct skl *skl;
 	struct device *dev;
 
 	struct dentry *fs;
+	struct dentry *modules;
 };
 
+static ssize_t skl_print_pins(struct skl_module_pin *m_pin, char *buf,
+				int max_pin, ssize_t size, bool direction)
+{
+	int i;
+	ssize_t ret = 0;
+
+	for (i = 0; i < max_pin; i++)
+		ret += snprintf(buf + size, MOD_BUF - size,
+				"%s %d\n\tModule %d\n\tInstance %d\n\t"
+				"In-used %s\n\tType %s\n"
+				"\tState %d\n\tIndex %d\n",
+				direction ? "Input Pin:" : "Output Pin:",
+				i, m_pin[i].id.module_id,
+				m_pin[i].id.instance_id,
+				m_pin[i].in_use ? "Used" : "Unused",
+				m_pin[i].is_dynamic ? "Dynamic" : "Static",
+				m_pin[i].pin_state, i);
+	return ret;
+}
+
+static ssize_t skl_print_fmt(struct skl_module_fmt *fmt, char *buf,
+					ssize_t size, bool direction)
+{
+	return snprintf(buf + size, MOD_BUF - size,
+			"%s\n\tCh %d\n\tFreq %d\n\tBit depth %d\n\t"
+			"Valid bit depth %d\n\tCh config %#x\n\tInterleaving %d\n\t"
+			"Sample Type %d\n\tCh Map %#x\n",
+			direction ? "Input Format:" : "Output Format:",
+			fmt->channels, fmt->s_freq, fmt->bit_depth,
+			fmt->valid_bit_depth, fmt->ch_cfg,
+			fmt->interleaving_style, fmt->sample_type,
+			fmt->ch_map);
+}
+
+static ssize_t module_read(struct file *file, char __user *user_buf,
+			   size_t count, loff_t *ppos)
+{
+	struct skl_module_cfg *mconfig = file->private_data;
+	char *buf;
+	ssize_t ret;
+
+	buf = kzalloc(MOD_BUF, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = snprintf(buf, MOD_BUF, "Module:\n\tUUID %pUL\n\tModule id %d\n"
+			"\tInstance id %d\n\tPvt_id %d\n", mconfig->guid,
+			mconfig->id.module_id, mconfig->id.instance_id,
+			mconfig->id.pvt_id);
+
+	ret += snprintf(buf + ret, MOD_BUF - ret,
+			"Resources:\n\tMCPS %#x\n\tIBS %#x\n\tOBS %#x\t\n",
+			mconfig->mcps, mconfig->ibs, mconfig->obs);
+
+	ret += snprintf(buf + ret, MOD_BUF - ret,
+			"Module data:\n\tCore %d\n\tIn queue %d\n\t"
+			"Out queue %d\n\tType %s\n",
+			mconfig->core_id, mconfig->max_in_queue,
+			mconfig->max_out_queue,
+			mconfig->is_loadable ? "loadable" : "inbuilt");
+
+	ret += skl_print_fmt(mconfig->in_fmt, buf, ret, true);
+	ret += skl_print_fmt(mconfig->out_fmt, buf, ret, false);
+
+	ret += snprintf(buf + ret, MOD_BUF - ret,
+			"Fixup:\n\tParams %#x\n\tConverter %#x\n",
+			mconfig->params_fixup, mconfig->converter);
+
+	ret += snprintf(buf + ret, MOD_BUF - ret,
+			"Module Gateway:\n\tType %#x\n\tVbus %#x\n\tHW conn %#x\n\tSlot %#x\n",
+			mconfig->dev_type, mconfig->vbus_id,
+			mconfig->hw_conn_type, mconfig->time_slot);
+
+	ret += snprintf(buf + ret, MOD_BUF - ret,
+			"Pipeline:\n\tID %d\n\tPriority %d\n\tConn Type %d\n\t"
+			"Pages %#x\n", mconfig->pipe->ppl_id,
+			mconfig->pipe->pipe_priority, mconfig->pipe->conn_type,
+			mconfig->pipe->memory_pages);
+
+	ret += snprintf(buf + ret, MOD_BUF - ret,
+			"\tParams:\n\t\tHost DMA %d\n\t\tLink DMA %d\n",
+			mconfig->pipe->p_params->host_dma_id,
+			mconfig->pipe->p_params->link_dma_id);
+
+	ret += snprintf(buf + ret, MOD_BUF - ret,
+			"\tPCM params:\n\t\tCh %d\n\t\tFreq %d\n\t\tFormat %d\n",
+			mconfig->pipe->p_params->ch,
+			mconfig->pipe->p_params->s_freq,
+			mconfig->pipe->p_params->s_fmt);
+
+	ret += snprintf(buf + ret, MOD_BUF - ret,
+			"\tLink %#x\n\tStream %#x\n",
+			mconfig->pipe->p_params->linktype,
+			mconfig->pipe->p_params->stream);
+
+	ret += snprintf(buf + ret, MOD_BUF - ret,
+			"\tState %d\n\tPassthru %s\n",
+			mconfig->pipe->state,
+			mconfig->pipe->passthru ? "true" : "false");
+
+	ret += skl_print_pins(mconfig->m_in_pin, buf,
+			mconfig->max_in_queue, ret, true);
+	ret += skl_print_pins(mconfig->m_out_pin, buf,
+			mconfig->max_out_queue, ret, false);
+
+	ret += snprintf(buf + ret, MOD_BUF - ret,
+			"Other:\n\tDomain %d\n\tHomogenous Input %s\n\t"
+			"Homogenous Output %s\n\tIn Queue Mask %d\n\t"
+			"Out Queue Mask %d\n\tDMA ID %d\n\tMem Pages %d\n\t"
+			"Module Type %d\n\tModule State %d\n",
+			mconfig->domain,
+			mconfig->homogenous_inputs ? "true" : "false",
+			mconfig->homogenous_outputs ? "true" : "false",
+			mconfig->in_queue_mask, mconfig->out_queue_mask,
+			mconfig->dma_id, mconfig->mem_pages, mconfig->m_state,
+			mconfig->m_type);
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+
+	kfree(buf);
+	return ret;
+}
+
+static const struct file_operations mcfg_fops = {
+	.open = simple_open,
+	.read = module_read,
+	.llseek = default_llseek,
+};
+
+
+void skl_debug_init_module(struct skl_debug *d,
+			struct snd_soc_dapm_widget *w,
+			struct skl_module_cfg *mconfig)
+{
+	if (!debugfs_create_file(w->name, 0444,
+				d->modules, mconfig,
+				&mcfg_fops))
+		dev_err(d->dev, "%s: module debugfs init failed\n", w->name);
+}
+
 struct skl_debug *skl_debugfs_init(struct skl *skl)
 {
 	struct skl_debug *d;
@@ -43,7 +188,18 @@ struct skl_debug *skl_debugfs_init(struct skl *skl)
 	d->skl = skl;
 	d->dev = &skl->pci->dev;
 
+	/* now create the module dir */
+	d->modules = debugfs_create_dir("modules", d->fs);
+	if (IS_ERR(d->modules) || !d->modules) {
+		dev_err(&skl->pci->dev, "modules debugfs create failed\n");
+		goto err;
+	}
+
 	return d;
+
+err:
+	debugfs_remove_recursive(d->fs);
+	return NULL;
 }
 
 void skl_debugfs_exit(struct skl_debug *d)
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 9569f118e97e..c02da16fdfd6 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -2472,6 +2472,9 @@ static int skl_tplg_widget_load(struct snd_soc_component *cmpnt,
 	ret = skl_tplg_get_pvt_data(tplg_w, skl, bus->dev, mconfig);
 	if (ret < 0)
 		return ret;
+
+	skl_debug_init_module(skl->debugfs, w, mconfig);
+
 bind_event:
 	if (tplg_w->event_type == 0) {
 		dev_dbg(bus->dev, "ASoC: No event handler required\n");
diff --git a/sound/soc/intel/skylake/skl.h b/sound/soc/intel/skylake/skl.h
index a47779c819d5..14e7778d7f80 100644
--- a/sound/soc/intel/skylake/skl.h
+++ b/sound/soc/intel/skylake/skl.h
@@ -23,6 +23,7 @@
 
 #include <sound/hda_register.h>
 #include <sound/hdaudio_ext.h>
+#include <sound/soc.h>
 #include "skl-nhlt.h"
 
 #define SKL_SUSPEND_DELAY 2000
@@ -120,9 +121,14 @@ void skl_update_d0i3c(struct device *dev, bool enable);
 int skl_nhlt_create_sysfs(struct skl *skl);
 void skl_nhlt_remove_sysfs(struct skl *skl);
 
+struct skl_module_cfg;
+
 #ifdef CONFIG_DEBUG_FS
 struct skl_debug *skl_debugfs_init(struct skl *skl);
 void skl_debugfs_exit(struct skl_debug *d);
+void skl_debug_init_module(struct skl_debug *d,
+			struct snd_soc_dapm_widget *w,
+			struct skl_module_cfg *mconfig);
 #else
 static inline struct skl_debug *skl_debugfs_init(struct skl *skl)
 {
@@ -130,6 +136,10 @@ static inline struct skl_debug *skl_debugfs_init(struct skl *skl)
 }
 static inline void skl_debugfs_exit(struct skl_debug *d)
 {}
+static inline void skl_debug_init_module(struct skl_debug *d,
+					 struct snd_soc_dapm_widget *w,
+					 struct skl_module_cfg *mconfig)
+{}
 #endif
 
 #endif /* __SOUND_SOC_SKL_H */
-- 
2.13.0
