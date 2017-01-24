From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: wm_adsp: Fixup wm_adsp2_boot_work
	error paths
Date: Tue, 24 Jan 2017 11:44:01 +0000
Message-ID: <1485258241-10575-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1485258241-10575-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 623F0266C6A
 for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2017 12:43:03 +0100 (CET)
In-Reply-To: <1485258241-10575-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

Currently we are not disabling MEM_ENA on the error path, we should
really do this to unwind the state back to how it was. This patch adds a
clear of MEM_ENA on the error path, again there is no major issues
caused by this minor fix.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 822dfef..d151224 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2473,7 +2473,7 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 
 	ret = wm_adsp2_ena(dsp);
 	if (ret != 0)
-		goto err_mutex;
+		goto err_mem;
 
 	ret = wm_adsp_load(dsp);
 	if (ret != 0)
@@ -2507,6 +2507,9 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 err_ena:
 	regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
 			   ADSP2_SYS_ENA | ADSP2_CORE_ENA | ADSP2_START, 0);
+err_mem:
+	regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+			   ADSP2_MEM_ENA, 0);
 err_mutex:
 	mutex_unlock(&dsp->pwr_lock);
 }
-- 
2.1.4
