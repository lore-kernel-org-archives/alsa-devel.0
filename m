From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v3 3/5] ASoC: dapm: Append "Autodisable" to
	autodisable widget names
Date: Fri,  1 May 2015 12:37:25 +0100
Message-ID: <1430480247-28753-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1430480247-28753-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 351F6261B28
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2015 13:45:33 +0200 (CEST)
In-Reply-To: <1430480247-28753-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

This makes it a little easier to follow what is happening in debugfs.
Additionally is also useful in facilitating work to add autodisable
muxes because the control name is already used for the mux widget and
thus shouldn't be reused for the autodisable widget.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index beb48b6..a0d97f8 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -308,6 +308,8 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 {
 	struct dapm_kcontrol_data *data;
 	struct soc_mixer_control *mc;
+	const char *name;
+	int ret;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -324,6 +326,13 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 		if (mc->autodisable) {
 			struct snd_soc_dapm_widget template;
 
+			name = kasprintf(GFP_KERNEL, "%s %s", kcontrol->id.name,
+					 "Autodisable");
+			if (!name) {
+				ret = -ENOMEM;
+				goto err_data;
+			}
+
 			memset(&template, 0, sizeof(template));
 			template.reg = mc->reg;
 			template.mask = (1 << fls(mc->max)) - 1;
@@ -334,15 +343,15 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 				template.off_val = 0;
 			template.on_val = template.off_val;
 			template.id = snd_soc_dapm_kcontrol;
-			template.name = kcontrol->id.name;
+			template.name = name;
 
 			data->value = template.on_val;
 
 			data->widget = snd_soc_dapm_new_control(widget->dapm,
 				&template);
 			if (!data->widget) {
-				kfree(data);
-				return -ENOMEM;
+				ret = -ENOMEM;
+				goto err_name;
 			}
 		}
 		break;
@@ -353,11 +362,19 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 	kcontrol->private_data = data;
 
 	return 0;
+
+err_name:
+	kfree(name);
+err_data:
+	kfree(data);
+	return ret;
 }
 
 static void dapm_kcontrol_free(struct snd_kcontrol *kctl)
 {
 	struct dapm_kcontrol_data *data = snd_kcontrol_chip(kctl);
+	if (data->widget)
+		kfree(data->widget->name);
 	kfree(data->wlist);
 	kfree(data);
 }
-- 
1.7.2.5
