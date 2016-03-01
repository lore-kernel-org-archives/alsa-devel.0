From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ab8500: Fix enum ctl accesses in a
	wrong type" to the asoc tree
Date: Tue, 01 Mar 2016 12:23:25 +0900
Message-ID: <E1aaauD-00086E-Uf@finisterre>
References: <1456765684-5717-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E9E7265B6D
 for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2016 04:24:19 +0100 (CET)
In-Reply-To: <1456765684-5717-2-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ab8500: Fix enum ctl accesses in a wrong type

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

>From 4b606316129571c46381430852c149855ac50477 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Mon, 29 Feb 2016 18:08:00 +0100
Subject: [PATCH] ASoC: ab8500: Fix enum ctl accesses in a wrong type

"Sidetone Status" and "ANC Status" ctls in ab8500 codec driver are
enum, while the current driver accesses wrongly via
value.integer.value[].  They have to be via value.enumerated.item[]
instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ab8500-codec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index affb192238a4..faae6936bae4 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -1130,7 +1130,7 @@ static int sid_status_control_get(struct snd_kcontrol *kcontrol,
 	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
 
 	mutex_lock(&drvdata->ctrl_lock);
-	ucontrol->value.integer.value[0] = drvdata->sid_status;
+	ucontrol->value.enumerated.item[0] = drvdata->sid_status;
 	mutex_unlock(&drvdata->ctrl_lock);
 
 	return 0;
@@ -1147,7 +1147,7 @@ static int sid_status_control_put(struct snd_kcontrol *kcontrol,
 
 	dev_dbg(codec->dev, "%s: Enter\n", __func__);
 
-	if (ucontrol->value.integer.value[0] != SID_APPLY_FIR) {
+	if (ucontrol->value.enumerated.item[0] != SID_APPLY_FIR) {
 		dev_err(codec->dev,
 			"%s: ERROR: This control supports '%s' only!\n",
 			__func__, enum_sid_state[SID_APPLY_FIR]);
@@ -1199,7 +1199,7 @@ static int anc_status_control_get(struct snd_kcontrol *kcontrol,
 	struct ab8500_codec_drvdata *drvdata = dev_get_drvdata(codec->dev);
 
 	mutex_lock(&drvdata->ctrl_lock);
-	ucontrol->value.integer.value[0] = drvdata->anc_status;
+	ucontrol->value.enumerated.item[0] = drvdata->anc_status;
 	mutex_unlock(&drvdata->ctrl_lock);
 
 	return 0;
@@ -1220,7 +1220,7 @@ static int anc_status_control_put(struct snd_kcontrol *kcontrol,
 
 	mutex_lock(&drvdata->ctrl_lock);
 
-	req = ucontrol->value.integer.value[0];
+	req = ucontrol->value.enumerated.item[0];
 	if (req >= ARRAY_SIZE(enum_anc_state)) {
 		status = -EINVAL;
 		goto cleanup;
-- 
2.7.0
