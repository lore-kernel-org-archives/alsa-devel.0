From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Don't prefix autodisable widgets
	twice" to the asoc tree
Date: Thu, 04 Feb 2016 12:16:19 +0000
Message-ID: <E1aRIpf-0001Iv-0U@debutante>
References: <1454533190-29630-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A4DA1265D93
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2016 13:16:27 +0100 (CET)
In-Reply-To: <1454533190-29630-1-git-send-email-lars@metafoo.de>
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

   ASoC: dapm: Don't prefix autodisable widgets twice

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

>From 41d80025a83b9c7a94f97ef25c4cd3345bdc3c5e Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Wed, 3 Feb 2016 21:59:50 +0100
Subject: [PATCH] ASoC: dapm: Don't prefix autodisable widgets twice

When a DAPM context has a prefix the autodisable widgets get prefixed
twice, once for the control and once for the widget. To avoid this use
the un-prefixed control name to construct the autodisable widget name.

This change is purely cosmetic.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5a2812fa8946..0d3707987900 100644
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
2.7.0.rc3
