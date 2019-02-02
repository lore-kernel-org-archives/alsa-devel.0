From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: fix use-after-free issue with
	dailink sname" to the asoc tree
Date: Sat,  2 Feb 2019 16:18:06 +0000 (GMT)
Message-ID: <20190202161806.E8BE3440082@finisterre.ee.mobilebroadband>
References: <20190201170513.13905-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C0A80267477
 for <alsa-devel@alsa-project.org>; Sat,  2 Feb 2019 17:18:08 +0100 (CET)
In-Reply-To: <20190201170513.13905-3-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: fix use-after-free issue with dailink sname

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

>From 199ed3e81c49a621ce6fcb630ab9f30d92db6718 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 1 Feb 2019 11:05:12 -0600
Subject: [PATCH] ASoC: dapm: fix use-after-free issue with dailink sname

Commit 7620fe9161ce ("ASoC: topology: fix memory leak in
soc_tplg_dapm_widget_create") fixed a memory leak issue, but
additional tests and KASAN reports show a use-after-free in soc-dapm.

The widgets are created with a kmemdup operating on a template. The
"name" string is also duplicated, but the "sname" string is not. As a
result, when the template is freed after widget creation, its sname
string is still used.

Fix by explicitly duplicating the "sname" string, and freeing it when
required.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 2c4c13419539..e71cd5b660ad 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -295,7 +295,22 @@ EXPORT_SYMBOL_GPL(dapm_mark_endpoints_dirty);
 static inline struct snd_soc_dapm_widget *dapm_cnew_widget(
 	const struct snd_soc_dapm_widget *_widget)
 {
-	return kmemdup(_widget, sizeof(*_widget), GFP_KERNEL);
+	struct snd_soc_dapm_widget *w;
+
+	w = kmemdup(_widget, sizeof(*_widget), GFP_KERNEL);
+	if (!w)
+		return NULL;
+
+	/*
+	 * w->name is duplicated in caller, but w->sname isn't.
+	 * Duplicate it here if defined
+	 */
+	if (_widget->sname) {
+		w->sname = kstrdup_const(_widget->sname, GFP_KERNEL);
+		if (!w->sname)
+			return NULL;
+	}
+	return w;
 }
 
 struct dapm_kcontrol_data {
@@ -2412,6 +2427,7 @@ void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w)
 
 	kfree(w->kcontrols);
 	kfree_const(w->name);
+	kfree_const(w->sname);
 	kfree(w);
 }
 
@@ -3469,6 +3485,7 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 	else
 		w->name = kstrdup_const(widget->name, GFP_KERNEL);
 	if (w->name == NULL) {
+		kfree_const(w->sname);
 		kfree(w);
 		return ERR_PTR(-ENOMEM);
 	}
-- 
2.20.1
