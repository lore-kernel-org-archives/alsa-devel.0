From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: SoC: skylake: no need to check return value of debugfs_create functions" to the asoc tree
Date: Thu,  1 Aug 2019 14:10:39 +0100 (BST)
Message-ID: <20190801131039.EAD042742D2C@ypsilon.sirena.org.uk>
References: <20190731131716.9764-1-gregkh@linuxfoundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190731131716.9764-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: SoC: skylake: no need to check return value of debugfs_create functions

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From d8701fae95c0e6cb587b293cb8e01acc96dd1095 Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 31 Jul 2019 15:17:14 +0200
Subject: [PATCH] ASoC: Intel: SoC: skylake: no need to check return value of
 debugfs_create functions

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
Link: https://lore.kernel.org/r/20190731131716.9764-1-gregkh@linuxfoundation.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-debug.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-debug.c b/sound/soc/intel/skylake/skl-debug.c
index fb232428109f..212370bf704c 100644
--- a/sound/soc/intel/skylake/skl-debug.c
+++ b/sound/soc/intel/skylake/skl-debug.c
@@ -164,10 +164,8 @@ void skl_debug_init_module(struct skl_debug *d,
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
@@ -224,34 +222,18 @@ struct skl_debug *skl_debugfs_init(struct skl_dev *skl)
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
 
 void skl_debugfs_exit(struct skl_dev *skl)
-- 
2.20.1
