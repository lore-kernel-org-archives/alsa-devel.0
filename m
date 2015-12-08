From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 04/13] ASoC: wm_adsp: Add power lock for
	firmware change control
Date: Tue, 8 Dec 2015 16:08:28 +0000
Message-ID: <1449590917-21170-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1449590917-21170-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D8562604D1
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 17:09:08 +0100 (CET)
In-Reply-To: <1449590917-21170-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

We should hold the DSP power lock whilst changing the firmware since we
need to check if it is running first.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 2ab9de8..b083642 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -451,6 +451,7 @@ static int wm_adsp_fw_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	struct wm_adsp *dsp = snd_soc_codec_get_drvdata(codec);
+	int ret = 0;
 
 	if (ucontrol->value.integer.value[0] == dsp[e->shift_l].fw)
 		return 0;
@@ -458,12 +459,16 @@ static int wm_adsp_fw_put(struct snd_kcontrol *kcontrol,
 	if (ucontrol->value.integer.value[0] >= WM_ADSP_NUM_FW)
 		return -EINVAL;
 
+	mutex_lock(&dsp[e->shift_l].pwr_lock);
+
 	if (dsp[e->shift_l].running)
-		return -EBUSY;
+		ret = -EBUSY;
+	else
+		dsp[e->shift_l].fw = ucontrol->value.integer.value[0];
 
-	dsp[e->shift_l].fw = ucontrol->value.integer.value[0];
+	mutex_unlock(&dsp[e->shift_l].pwr_lock);
 
-	return 0;
+	return ret;
 }
 
 static const struct soc_enum wm_adsp_fw_enum[] = {
-- 
2.1.4
