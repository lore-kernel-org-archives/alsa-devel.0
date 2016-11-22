From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2] ASoC: wm_adsp: Check return value from
	wm_adsp_buffer_init
Date: Tue, 22 Nov 2016 15:38:34 +0000
Message-ID: <1479829114-11579-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 883802665B0
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2016 16:37:41 +0100 (CET)
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

We are not checking the return value from a call to wm_adsp_buffer_init
it looks like this used to be returned at the bottom of the function but
probably got missed when more error paths were added. This patch adds
the appropriate error check.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

Changes since v1:
 - Add unlock of the mutex on the error path

Thanks,
Charles

 sound/soc/codecs/wm_adsp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 6ccb731..e00ccfc 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2580,8 +2580,13 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 
 		mutex_lock(&dsp->pwr_lock);
 
-		if (wm_adsp_fw[dsp->fw].num_caps != 0)
+		if (wm_adsp_fw[dsp->fw].num_caps != 0) {
 			ret = wm_adsp_buffer_init(dsp);
+			if (ret < 0) {
+				mutex_unlock(&dsp->pwr_lock);
+				goto err;
+			}
+		}
 
 		mutex_unlock(&dsp->pwr_lock);
 
-- 
2.1.4
