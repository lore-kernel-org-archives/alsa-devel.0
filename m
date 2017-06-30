From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Add support to read
	firmware registers" to the asoc tree
Date: Fri, 30 Jun 2017 13:29:25 +0100
Message-ID: <E1dQv37-00010g-4F@finisterre>
References: <20170629123608.5498-6-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20170629123608.5498-6-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Sodhi@alsa-project.org, alsa-devel@alsa-project.org, B@alsa-project.org, Babu@alsa-project.org, Patches Audio <patches.audio@intel.com>, Pardha Saradhi <pardha.saradhi.kesapragada@intel.com>, Jayachandran <jayachandran.b@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Ramesh <ramesh.babu@intel.com>, Mousumi Jana <mousumix.jana@intel.com>, liam.r.girdwood@linux.intel.com, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Kesapragada@alsa-project.org, "Sodhi, , VunnyX" <vunnyx.sodhi@intel.com>, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Add support to read firmware registers

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

>From bdd0384a5ada8bb5745e5f29c10a5ba88827efad Mon Sep 17 00:00:00 2001
From: Vunny Sodhi <vunnyx.sodhi@intel.com>
Date: Fri, 30 Jun 2017 09:06:08 +0530
Subject: [PATCH] ASoC: Intel: Skylake: Add support to read firmware registers

This patch adds debugfs support to read fw registers, mailbox
offsets and sram address.

Signed-off-by: Mousumi Jana <mousumix.jana@intel.com>
Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
Signed-off-by: Jayachandran B <jayachandran.b@intel.com>
Signed-off-by: Pardha Saradhi K <pardha.saradhi.kesapragada@intel.com>
Signed-off-by: Vunny Sodhi <vunnyx.sodhi@intel.com>
Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-debug.c | 57 +++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
index be3238c63200..75497b1fda45 100644
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
2.13.2
