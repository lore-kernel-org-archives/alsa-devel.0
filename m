From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm_adsp: Add small delay whilst
	polling DSP RAM start
Date: Wed, 18 Dec 2013 09:25:49 +0000
Message-ID: <1387358749-13988-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1387358749-13988-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5131026163E
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 10:32:41 +0100 (CET)
In-Reply-To: <1387358749-13988-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

Some devices are getting very close to the limit whilst polling the RAM
start, this patch adds a small delay to this loop to give a longer
startup timeout.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 456784f..fb0c678 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1475,13 +1475,17 @@ static int wm_adsp2_ena(struct wm_adsp *dsp)
 		return ret;
 
 	/* Wait for the RAM to start, should be near instantaneous */
-	count = 0;
-	do {
+	for (count = 0; count < 10; ++count) {
 		ret = regmap_read(dsp->regmap, dsp->base + ADSP2_STATUS1,
 				  &val);
 		if (ret != 0)
 			return ret;
-	} while (!(val & ADSP2_RAM_RDY) && ++count < 10);
+
+		if (val & ADSP2_RAM_RDY)
+			break;
+
+		msleep(1);
+	}
 
 	if (!(val & ADSP2_RAM_RDY)) {
 		adsp_err(dsp, "Failed to start DSP RAM\n");
-- 
1.7.2.5
