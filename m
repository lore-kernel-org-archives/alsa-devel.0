From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/5] ASoC: ab8500: Fix enum ctl accesses in a
	wrong type
Date: Mon, 29 Feb 2016 18:08:00 +0100
Message-ID: <1456765684-5717-2-git-send-email-tiwai@suse.de>
References: <1456765684-5717-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 25A1C265142
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 18:08:06 +0100 (CET)
In-Reply-To: <1456765684-5717-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

"Sidetone Status" and "ANC Status" ctls in ab8500 codec driver are
enum, while the current driver accesses wrongly via
value.integer.value[].  They have to be via value.enumerated.item[]
instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
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
2.7.2
