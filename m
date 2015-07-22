From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Avoid duplicating immutable
	strings" to the asoc tree
Date: Wed, 22 Jul 2015 10:57:32 +0100
Message-ID: <E1ZHqmK-00079P-LB@debutante>
References: <1437495068-4104-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EA21E265290
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2015 11:57:39 +0200 (CEST)
In-Reply-To: <1437495068-4104-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Avoid duplicating immutable strings

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

>From 480689617510381391b3d906549477b948d9c4bc Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 21 Jul 2015 18:11:08 +0200
Subject: [PATCH] ASoC: dapm: Avoid duplicating immutable strings

When creating a new widget from a template the name string of the template
is duplicated for the newly created widget. This is necessary because in
some cases the string might be stored on the stack or other volatile
memory locations.

But most of the time the string is static const data, which means it is
possible to use it directly without having to worry that it might get freed
or changed.

Use kstrdup_const() to handle duplicating the string. This function is
capable of detecting whether a string is immutable and if it is returns the
input without duplicating it. This will slightly reduce the runtime memory
footprint of DAPM and also speed up initialization.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 24ea692bd49e..cb4bc1cd5049 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2329,7 +2329,7 @@ void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w)
 		dapm_free_path(p);
 
 	kfree(w->kcontrols);
-	kfree(w->name);
+	kfree_const(w->name);
 	kfree(w);
 }
 
@@ -3350,7 +3350,7 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 	if (prefix)
 		w->name = kasprintf(GFP_KERNEL, "%s %s", prefix, widget->name);
 	else
-		w->name = kasprintf(GFP_KERNEL, "%s", widget->name);
+		w->name = kstrdup_const(widget->name, GFP_KERNEL);
 	if (w->name == NULL) {
 		kfree(w);
 		return NULL;
-- 
2.1.4
