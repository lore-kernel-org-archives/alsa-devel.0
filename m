From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: wm_adsp: Return an error on write to
	a disabled volatile control
Date: Mon, 6 Mar 2017 16:54:33 +0000
Message-ID: <1488819274-9791-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EBD6266DB3
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 17:53:31 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Volatile controls should only be accessed when the firmware is active,
currently however writes to these controls will succeed, but the data
will be lost, if the firmware is powered down. Update this behaviour such
that an error is returned the same as it is for reads.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index d151224..6313b3d 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -899,7 +899,10 @@ static int wm_coeff_put(struct snd_kcontrol *kctl,
 
 	mutex_lock(&ctl->dsp->pwr_lock);
 
-	memcpy(ctl->cache, p, ctl->len);
+	if (ctl->flags & WMFW_CTL_FLAG_VOLATILE)
+		ret = -EPERM;
+	else
+		memcpy(ctl->cache, p, ctl->len);
 
 	ctl->set = 1;
 	if (ctl->enabled && ctl->dsp->running)
@@ -926,6 +929,8 @@ static int wm_coeff_tlv_put(struct snd_kcontrol *kctl,
 		ctl->set = 1;
 		if (ctl->enabled && ctl->dsp->running)
 			ret = wm_coeff_write_control(ctl, ctl->cache, size);
+		else if (ctl->flags & WMFW_CTL_FLAG_VOLATILE)
+			ret = -EPERM;
 	}
 
 	mutex_unlock(&ctl->dsp->pwr_lock);
-- 
2.1.4
