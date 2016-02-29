From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 9/9] ASoC: wm_adsp: Fix enum ctl accesses in a
	wrong type
Date: Mon, 29 Feb 2016 18:01:18 +0100
Message-ID: <1456765278-5435-10-git-send-email-tiwai@suse.de>
References: <1456765278-5435-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id E2679264F34
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 18:01:27 +0100 (CET)
In-Reply-To: <1456765278-5435-1-git-send-email-tiwai@suse.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The firmware ctls like "DSP1 Firmware" in wm_adsp codec driver are
enum, while the current driver accesses wrongly via
value.integer.value[].  They have to be via value.enumerated.item[]
instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm_adsp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 33806d487b8a..b9195b9c2b05 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -586,7 +586,7 @@ static int wm_adsp_fw_get(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct wm_adsp *dsp = snd_soc_codec_get_drvdata(codec);
 
-	ucontrol->value.integer.value[0] = dsp[e->shift_l].fw;
+	ucontrol->value.enumerated.item[0] = dsp[e->shift_l].fw;
 
 	return 0;
 }
@@ -599,10 +599,10 @@ static int wm_adsp_fw_put(struct snd_kcontrol *kcontrol,
 	struct wm_adsp *dsp = snd_soc_codec_get_drvdata(codec);
 	int ret = 0;
 
-	if (ucontrol->value.integer.value[0] == dsp[e->shift_l].fw)
+	if (ucontrol->value.enumerated.item[0] == dsp[e->shift_l].fw)
 		return 0;
 
-	if (ucontrol->value.integer.value[0] >= WM_ADSP_NUM_FW)
+	if (ucontrol->value.enumerated.item[0] >= WM_ADSP_NUM_FW)
 		return -EINVAL;
 
 	mutex_lock(&dsp[e->shift_l].pwr_lock);
@@ -610,7 +610,7 @@ static int wm_adsp_fw_put(struct snd_kcontrol *kcontrol,
 	if (dsp[e->shift_l].running || dsp[e->shift_l].compr)
 		ret = -EBUSY;
 	else
-		dsp[e->shift_l].fw = ucontrol->value.integer.value[0];
+		dsp[e->shift_l].fw = ucontrol->value.enumerated.item[0];
 
 	mutex_unlock(&dsp[e->shift_l].pwr_lock);
 
-- 
2.7.2
