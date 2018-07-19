From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 4/5] ASoC: wm_adsp: Allow up to 8 channels for
	voice control
Date: Thu, 19 Jul 2018 11:50:38 +0100
Message-ID: <20180719105039.28312-4-ckeepax@opensource.cirrus.com>
References: <20180719105039.28312-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id A3FB2267600
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

From: Richard Fitzgerald <rf@opensource.cirrus.com>

Newer voice control firmwares can capture multiple audio channels.
Allow up to 8 channels for future-proofing.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index e823a84b5ac2..287ca8d6a9ce 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -418,7 +418,7 @@ static const struct wm_adsp_fw_caps ctrl_caps[] = {
 	{
 		.id = SND_AUDIOCODEC_BESPOKE,
 		.desc = {
-			.max_ch = 1,
+			.max_ch = 8,
 			.sample_rates = { 16000 },
 			.num_sample_rates = 1,
 			.formats = SNDRV_PCM_FMTBIT_S16_LE,
-- 
2.11.0
