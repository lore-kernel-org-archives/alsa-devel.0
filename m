From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: dapm: Fix kcontrol widget name memory
	management
Date: Wed,  8 Jul 2015 21:59:59 +0200
Message-ID: <1436385599-12403-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-104.synserver.de (smtp-out-104.synserver.de
 [212.40.185.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D3A5265A2B
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 22:00:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The name field of the widget template is only used inside
snd_soc_dapm_new_control_unlocked() which allocates a copy for the actual
widget. This means we need to free the name allocated for the template in
dapm_kcontrol_data_alloc() and not the name of the actual widget in
dapm_kcontrol_free(). Otherwise we get a double free on the widget name and
a memory leak on the template name.

Fixes: 773da9b358bf ("ASoC: dapm: Append "Autodisable" to autodisable widget names")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6bac491..1628f0c 100644
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
