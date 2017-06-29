From: Guneshwor Singh <guneshwor.o.singh@intel.com>
Subject: [PATCH v3 4/4] ASoC: Intel: Skylake: Add support to
	read firmware registers
Date: Thu, 29 Jun 2017 18:06:08 +0530
Message-ID: <20170629123608.5498-6-guneshwor.o.singh@intel.com>
References: <20170629123608.5498-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 21AAB26736B
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 14:37:20 +0200 (CEST)
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
Cc: Sodhi@alsa-project.org, Patches Audio <patches.audio@intel.com>, Babu@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Pardha Saradhi <pardha.saradhi.kesapragada@intel.com>, Jayachandran <jayachandran.b@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Ramesh <ramesh.babu@intel.com>, Mousumi Jana <mousumix.jana@intel.com>, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, Kesapragada@alsa-project.org, "Sodhi,
 VunnyX" <vunnyx.sodhi@intel.com>, B@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: "Sodhi, VunnyX" <vunnyx.sodhi@intel.com>

This patch adds debugfs support to read fw registers, mailbox
offsets and sram address.

Signed-off-by: Mousumi Jana <mousumix.jana@intel.com>
Signed-off-by: Babu, Ramesh <ramesh.babu@intel.com>
Signed-off-by: B, Jayachandran <jayachandran.b@intel.com>
Signed-off-by: Kesapragada, Pardha Saradhi <pardha.saradhi.kesapragada@intel.com>
Signed-off-by: Sodhi, VunnyX <vunnyx.sodhi@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 sound/soc/intel/skylake/skl-debug.c | 57 +++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
index 42d58295051e..4d2f77f6f5dd 100644
--- a/sound/soc/intel/skylake/skl-debug.c
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -16,10 +16,15 @@
 #include <linux/pci.h>
 #include <linux/debugfs.h>
 #include "skl.h"
+#include "skl-sst-dsp.h"
+#include "skl-sst-ipc.h"
 #include "skl-tplg-interface.h"
 #include "skl-topology.h"
+#include "../common/sst-dsp-priv.h"
 
 #define MOD_BUF		PAGE_SIZE
+#define FW_REG_BUF	PAGE_SIZE
+#define FW_REG_SIZE	0x60
 
 struct skl_debug {
 	struct skl *skl;
@@ -27,6 +32,7 @@ struct skl_debug {
 
 	struct dentry *fs;
 	struct dentry *modules;
+	u8 fw_read_buff[FW_REG_BUF];
 };
 
 static ssize_t skl_print_pins(struct skl_module_pin *m_pin, char *buf,
@@ -169,6 +175,51 @@ void skl_debug_init_module(struct skl_debug *d,
 		dev_err(d->dev, "%s: module debugfs init failed\n", w->name);
 }
 
+static ssize_t fw_softreg_read(struct file *file, char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct skl_debug *d = file->private_data;
+	struct sst_dsp *sst = d->skl->skl_sst->dsp;
+	size_t w0_stat_sz = sst->addr.w0_stat_sz;
+	void __iomem *in_base = sst->mailbox.in_base;
+	void __iomem *fw_reg_addr;
+	unsigned int offset;
+	char *tmp;
+	ssize_t ret = 0;
+
+	tmp = kzalloc(FW_REG_BUF, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	fw_reg_addr = in_base - w0_stat_sz;
+	memset(d->fw_read_buff, 0, FW_REG_BUF);
+
+	if (w0_stat_sz > 0)
+		__iowrite32_copy(d->fw_read_buff, fw_reg_addr, w0_stat_sz >> 2);
+
+	for (offset = 0; offset < FW_REG_SIZE; offset += 16) {
+		ret += snprintf(tmp + ret, FW_REG_BUF - ret, "%#.4x: ", offset);
+		hex_dump_to_buffer(d->fw_read_buff + offset, 16, 16, 4,
+				   tmp + ret, FW_REG_BUF - ret, 0);
+		ret += strlen(tmp + ret);
+
+		/* print newline for each offset */
+		if (FW_REG_BUF - ret > 0)
+			tmp[ret++] = '\n';
+	}
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, tmp, ret);
+	kfree(tmp);
+
+	return ret;
+}
+
+static const struct file_operations soft_regs_ctrl_fops = {
+	.open = simple_open,
+	.read = fw_softreg_read,
+	.llseek = default_llseek,
+};
+
 struct skl_debug *skl_debugfs_init(struct skl *skl)
 {
 	struct skl_debug *d;
@@ -195,6 +246,12 @@ struct skl_debug *skl_debugfs_init(struct skl *skl)
 		goto err;
 	}
 
+	if (!debugfs_create_file("fw_soft_regs_rd", 0444, d->fs, d,
+				 &soft_regs_ctrl_fops)) {
+		dev_err(d->dev, "fw soft regs control debugfs init failed\n");
+		goto err;
+	}
+
 	return d;
 
 err:
-- 
2.13.0
