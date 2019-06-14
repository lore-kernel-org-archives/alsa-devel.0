From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: no need to check return value
	of debugfs_create functions" to the asoc tree
Date: Fri, 14 Jun 2019 16:43:18 +0100 (BST)
Message-ID: <20190614154318.94311440049@finisterre.sirena.org.uk>
References: <20190614094756.2965-3-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64D46F80794
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2019 17:43:19 +0200 (CEST)
In-Reply-To: <20190614094756.2965-3-gregkh@linuxfoundation.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: no need to check return value of debugfs_create functions

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 7f807f280964e31fb32fe6aaa263cfa2488236d8 Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 14 Jun 2019 11:47:54 +0200
Subject: [PATCH] ASoC: wm_adsp: no need to check return value of
 debugfs_create functions

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 37 +++++++------------------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index b26e6b825a90..8f301cb07745 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -731,41 +731,18 @@ static void wm_adsp2_init_debugfs(struct wm_adsp *dsp,
 	struct dentry *root = NULL;
 	int i;
 
-	if (!component->debugfs_root) {
-		adsp_err(dsp, "No codec debugfs root\n");
-		goto err;
-	}
-
 	root = debugfs_create_dir(dsp->name, component->debugfs_root);
 
-	if (!root)
-		goto err;
-
-	if (!debugfs_create_bool("booted", 0444, root, &dsp->booted))
-		goto err;
+	debugfs_create_bool("booted", 0444, root, &dsp->booted);
+	debugfs_create_bool("running", 0444, root, &dsp->running);
+	debugfs_create_x32("fw_id", 0444, root, &dsp->fw_id);
+	debugfs_create_x32("fw_version", 0444, root, &dsp->fw_id_version);
 
-	if (!debugfs_create_bool("running", 0444, root, &dsp->running))
-		goto err;
-
-	if (!debugfs_create_x32("fw_id", 0444, root, &dsp->fw_id))
-		goto err;
-
-	if (!debugfs_create_x32("fw_version", 0444, root, &dsp->fw_id_version))
-		goto err;
-
-	for (i = 0; i < ARRAY_SIZE(wm_adsp_debugfs_fops); ++i) {
-		if (!debugfs_create_file(wm_adsp_debugfs_fops[i].name,
-					 0444, root, dsp,
-					 &wm_adsp_debugfs_fops[i].fops))
-			goto err;
-	}
+	for (i = 0; i < ARRAY_SIZE(wm_adsp_debugfs_fops); ++i)
+		debugfs_create_file(wm_adsp_debugfs_fops[i].name, 0444, root,
+				    dsp, &wm_adsp_debugfs_fops[i].fops);
 
 	dsp->debugfs_root = root;
-	return;
-
-err:
-	debugfs_remove_recursive(root);
-	adsp_err(dsp, "Failed to create debugfs\n");
 }
 
 static void wm_adsp2_cleanup_debugfs(struct wm_adsp *dsp)
-- 
2.20.1
