From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: dapm: Don't prefix autodisable widgets
	twice
Date: Wed,  3 Feb 2016 21:59:50 +0100
Message-ID: <1454533190-29630-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-195.synserver.de (smtp-out-199.synserver.de
 [212.40.185.199])
 by alsa0.perex.cz (Postfix) with ESMTP id 587E726066D
 for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2016 21:59:56 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

When a DAPM context has a prefix the autodisable widgets get prefixed
twice, once for the control and once for the widget. To avoid this use
the un-prefixed control name to construct the autodisable widget name.

This change is purely cosmetic.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-dapm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5a2812f..0d37079 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -310,7 +310,7 @@ struct dapm_kcontrol_data {
 };
 
 static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
-	struct snd_kcontrol *kcontrol)
+	struct snd_kcontrol *kcontrol, const char *ctrl_name)
 {
 	struct dapm_kcontrol_data *data;
 	struct soc_mixer_control *mc;
@@ -333,7 +333,7 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 		if (mc->autodisable) {
 			struct snd_soc_dapm_widget template;
 
-			name = kasprintf(GFP_KERNEL, "%s %s", kcontrol->id.name,
+			name = kasprintf(GFP_KERNEL, "%s %s", ctrl_name,
 					 "Autodisable");
 			if (!name) {
 				ret = -ENOMEM;
@@ -371,7 +371,7 @@ static int dapm_kcontrol_data_alloc(struct snd_soc_dapm_widget *widget,
 		if (e->autodisable) {
 			struct snd_soc_dapm_widget template;
 
-			name = kasprintf(GFP_KERNEL, "%s %s", kcontrol->id.name,
+			name = kasprintf(GFP_KERNEL, "%s %s", ctrl_name,
 					 "Autodisable");
 			if (!name) {
 				ret = -ENOMEM;
@@ -871,7 +871,7 @@ static int dapm_create_or_share_kcontrol(struct snd_soc_dapm_widget *w,
 
 		kcontrol->private_free = dapm_kcontrol_free;
 
-		ret = dapm_kcontrol_data_alloc(w, kcontrol);
+		ret = dapm_kcontrol_data_alloc(w, kcontrol, name);
 		if (ret) {
 			snd_ctl_free_one(kcontrol);
 			goto exit_free;
-- 
2.1.4
