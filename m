From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Don't add prefix to widget stream name" to the asoc tree
Date: Tue, 21 Jul 2015 11:49:15 +0100
Message-ID: <E1ZHV6p-0002sH-RJ@debutante>
References: <1437472295-5524-1-git-send-email-lars@metafoo.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1437472295-5524-1-git-send-email-lars@metafoo.de>
Sender: stable-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Don't add prefix to widget stream name

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

>From a798c24a69b64f09e2d323ac8155a36373e5d5fd Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Tue, 21 Jul 2015 11:51:35 +0200
Subject: [PATCH] ASoC: dapm: Don't add prefix to widget stream name

Commit fdb6eb0a1287 ("ASoC: dapm: Modify widget stream name according to
prefix") fixed the case where a DAPM route between a DAI widget and a
DAC/ADC/AIF widget with a matching stream name was not created when the
DAPM context was using a prefix.

Unfortunately the patch introduced a few issues on its own like leaking the
dynamically allocated stream name memory and also not checking whether the
allocation succeeded in the first place.

It is also incomplete in that it still does not handle the case where
stream name of the widget is a substring of the stream name of the DAI,
which is explicitly allowed and works fine if no DAPM prefix is used.

Revert the commit and take a slightly different approach to solving the
issue. Instead of comparing the widget's stream name to the name of the DAI
widget compare it to the stream name of the DAI widget. The stream name of
the DAI widget is identical to the name of the DAI widget except that it
wont have the DAPM prefix added. So this approach behaves identical
regardless to whether the DAPM context uses a prefix or not.

We don't have to worry about potentially matching with a widget with the
same stream name, but from a different DAPM context with a different
prefix, since the code already makes sure that both the DAI widget and the
matched widget are from the same DAPM context.

Fixes: fdb6eb0a1287 ("ASoC: dapm: Modify widget stream name according to prefix")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/soc-dapm.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 9f270c0308b7..e0de8072c514 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3341,16 +3341,10 @@ snd_soc_dapm_new_control_unlocked(struct snd_soc_dapm_context *dapm,
 	}
 
 	prefix = soc_dapm_prefix(dapm);
-	if (prefix) {
+	if (prefix)
 		w->name = kasprintf(GFP_KERNEL, "%s %s", prefix, widget->name);
-		if (widget->sname)
-			w->sname = kasprintf(GFP_KERNEL, "%s %s", prefix,
-					     widget->sname);
-	} else {
+	else
 		w->name = kasprintf(GFP_KERNEL, "%s", widget->name);
-		if (widget->sname)
-			w->sname = kasprintf(GFP_KERNEL, "%s", widget->sname);
-	}
 	if (w->name == NULL) {
 		kfree(w);
 		return NULL;
@@ -3799,7 +3793,7 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
 				break;
 			}
 
-			if (!w->sname || !strstr(w->sname, dai_w->name))
+			if (!w->sname || !strstr(w->sname, dai_w->sname))
 				continue;
 
 			if (dai_w->id == snd_soc_dapm_dai_in) {
-- 
2.1.4
