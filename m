From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Fix kcontrol widget name memory
	management" to the asoc tree
Date: Wed, 08 Jul 2015 22:17:11 +0100
Message-ID: <E1ZCwiN-00071w-5w@debutante>
References: <1436385599-12403-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D4BA7265A8C
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 23:17:19 +0200 (CEST)
In-Reply-To: <1436385599-12403-1-git-send-email-lars@metafoo.de>
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

   ASoC: dapm: Fix kcontrol widget name memory management

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

>From e18077b6e5dfe26e9fbbdc1fd1085a1701c24bea Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Wed, 8 Jul 2015 21:59:59 +0200
Subject: [PATCH] ASoC: dapm: Fix kcontrol widget name memory management

The name field of the widget template is only used inside
snd_soc_dapm_new_control_unlocked() which allocates a copy for the actual
widget. This means we need to free the name allocated for the template in
dapm_kcontrol_data_alloc() and not the name of the actual widget in
dapm_kcontrol_free(). Otherwise we get a double free on the widget name and
a memory leak on the template name.

Fixes: 773da9b358bf ("ASoC: dapm: Append "Autodisable" to autodisable widget names")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 1779430013ea..9f270c0308b7 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -358,9 +358,10 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 			data->widget =
 				snd_soc_dapm_new_control_unlocked(widget->dapm,
 				&template);
+			kfree(name);
 			if (!data->widget) {
 				ret = -ENOMEM;
-				goto err_name;
+				goto err_data;
 			}
 		}
 		break;
@@ -391,9 +392,10 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 
 			data->widget = snd_soc_dapm_new_control_unlocked(
 						widget->dapm, &template);
+			kfree(name);
 			if (!data->widget) {
 				ret = -ENOMEM;
-				goto err_name;
+				goto err_data;
 			}
 
 			snd_soc_dapm_add_path(widget->dapm, data->widget,
@@ -408,8 +410,6 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 
 	return 0;
 
-err_name:
-	kfree(name);
 err_data:
 	kfree(data);
 	return ret;
@@ -418,8 +418,6 @@ err_data:
 static void dapm_kcontrol_free(struct snd_kcontrol *kctl)
 {
 	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kctl);
-	if (data->widget)
-		kfree(data->widget->name);
 	kfree(data->wlist);
 	kfree(data);
 }
-- 
2.1.4
