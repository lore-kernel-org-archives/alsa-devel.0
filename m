From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 03/13] ASoC: wm_adsp: Add locking to DSP
	firmware controls
Date: Tue, 8 Dec 2015 16:08:27 +0000
Message-ID: <1449590917-21170-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1449590917-21170-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 6ED742604F4
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 17:09:07 +0100 (CET)
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

Locking is currently missing from the DSP firmware controls, which can
lead to some race conditions if the controls are accessed as the DSP
powers up or down. This patch adds them to the new power lock.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index d3b7726..2ab9de8 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -592,14 +592,19 @@ static int wm_coeff_put(struct snd_kcontrol *kctl,
 {
 	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kctl->private_value;
 	char *p = ucontrol->value.bytes.data;
+	int ret = 0;
+
+	mutex_lock(&ctl->dsp->pwr_lock);
 
 	memcpy(ctl->cache, p, ctl->len);
 
 	ctl->set = 1;
-	if (!ctl->enabled)
-		return 0;
+	if (ctl->enabled)
+		ret = wm_coeff_write_control(ctl, p, ctl->len);
 
-	return wm_coeff_write_control(ctl, p, ctl->len);
+	mutex_unlock(&ctl->dsp->pwr_lock);
+
+	return ret;
 }
 
 static int wm_coeff_read_control(struct wm_coeff_ctl *ctl,
@@ -646,17 +651,22 @@ static int wm_coeff_get(struct snd_kcontrol *kctl,
 {
 	struct wm_coeff_ctl *ctl = (struct wm_coeff_ctl *)kctl->private_value;
 	char *p = ucontrol->value.bytes.data;
+	int ret = 0;
+
+	mutex_lock(&ctl->dsp->pwr_lock);
 
 	if (ctl->flags & WMFW_CTL_FLAG_VOLATILE) {
 		if (ctl->enabled)
-			return wm_coeff_read_control(ctl, p, ctl->len);
+			ret = wm_coeff_read_control(ctl, p, ctl->len);
 		else
-			return -EPERM;
+			ret = -EPERM;
+	} else {
+		memcpy(p, ctl->cache, ctl->len);
 	}
 
-	memcpy(p, ctl->cache, ctl->len);
+	mutex_unlock(&ctl->dsp->pwr_lock);
 
-	return 0;
+	return ret;
 }
 
 struct wmfw_ctl_work {
-- 
2.1.4
