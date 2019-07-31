From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/3] ASoC: Intel: SoC: skylake: no need to check return value of debugfs_create functions
Date: Wed, 31 Jul 2019 15:17:14 +0200
Message-ID: <20190731131716.9764-1-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Also, if a debugfs call fails, userspace is notified with an error in
the log, so no need to log the error again.

Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Jie Yang <yang.jie@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: rebase on 5.3-rc1
    change Subject line to match the subsystem better
    rework based on debugfs core now reporting errors.

 sound/soc/intel/skylake/skl-debug.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
index b9b4a72a4334..1d6240ad6112 100644
--- a/sound/soc/intel/skylake/skl-debug.c
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -162,10 +162,8 @@ void skl_debug_init_module(struct skl_debug *d,
 			struct snd_soc_dapm_widget *w,
 			struct skl_module_cfg *mconfig)
 {
-	if (!debugfs_create_file(w->name, 0444,
-				d->modules, mconfig,
-				&mcfg_fops))
-		dev_err(d->dev, "%s: module debugfs init failed\n", w->name);
+	debugfs_create_file(w->name, 0444, d->modules, mconfig,
+			    &mcfg_fops);
 }
 
 static ssize_t fw_softreg_read(struct file *file, char __user *user_buf,
@@ -222,34 +220,18 @@ struct skl_debug *skl_debugfs_init(struct skl *skl)
 		return NULL;
 
 	/* create the debugfs dir with platform component's debugfs as parent */
-	d->fs = debugfs_create_dir("dsp",
-				   skl->component->debugfs_root);
-	if (IS_ERR(d->fs) || !d->fs) {
-		dev_err(&skl->pci->dev, "debugfs root creation failed\n");
-		return NULL;
-	}
+	d->fs = debugfs_create_dir("dsp", skl->component->debugfs_root);
 
 	d->skl = skl;
 	d->dev = &skl->pci->dev;
 
 	/* now create the module dir */
 	d->modules = debugfs_create_dir("modules", d->fs);
-	if (IS_ERR(d->modules) || !d->modules) {
-		dev_err(&skl->pci->dev, "modules debugfs create failed\n");
-		goto err;
-	}
 
-	if (!debugfs_create_file("fw_soft_regs_rd", 0444, d->fs, d,
-				 &soft_regs_ctrl_fops)) {
-		dev_err(d->dev, "fw soft regs control debugfs init failed\n");
-		goto err;
-	}
+	debugfs_create_file("fw_soft_regs_rd", 0444, d->fs, d,
+			    &soft_regs_ctrl_fops);
 
 	return d;
-
-err:
-	debugfs_remove_recursive(d->fs);
-	return NULL;
 }
 
 void skl_debugfs_exit(struct skl *skl)
-- 
2.22.0
