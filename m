From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 3/5] ASoC: wm_adsp: Ensure DSP boot work
	complete before preloader_put return
Date: Thu, 19 Jul 2018 11:50:37 +0100
Message-ID: <20180719105039.28312-3-ckeepax@opensource.cirrus.com>
References: <20180719105039.28312-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id A67D326788E
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2018 12:50:43 +0200 (CEST)
In-Reply-To: <20180719105039.28312-1-ckeepax@opensource.cirrus.com>
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
Cc: stuarth@opensource.cirrus.com, patches@opensource.cirrus.com, rf@opensource.cirrus.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Stuart Henderson <stuarth@opensource.cirrus.com>

All controls derived from the loaded firmware should be created prior
to returning from the preloader's put function, such that they are
immediately available to user-space.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index eec73c98a141..e823a84b5ac2 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2685,6 +2685,8 @@ int wm_adsp2_preloader_put(struct snd_kcontrol *kcontrol,
 
 	snd_soc_dapm_sync(dapm);
 
+	flush_work(&dsp->boot_work);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_preloader_put);
-- 
2.11.0
