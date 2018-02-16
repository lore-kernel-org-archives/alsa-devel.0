From: Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: wm_adsp: Fix some signedness errors in
	register access
Date: Fri, 16 Feb 2018 14:36:10 +0000
Message-ID: <20180216143610.12048-1-rf@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id E230826701D
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 15:36:23 +0100 (CET)
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, Richard Fitzgerald <rf@opensource.cirrus.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

base and sysclk_reg should be unsigned int, as that is what
regmap takes as a register address.

sysclk_mask is used to mask unsigned register values so
should be unsigned.

sysclk_shift is a shift value so is not allowed to be negative.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index 41cc11c19b83..d4042c95315e 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -64,10 +64,10 @@ struct wm_adsp {
 	struct regmap *regmap;
 	struct snd_soc_codec *codec;
 
-	int base;
-	int sysclk_reg;
-	int sysclk_mask;
-	int sysclk_shift;
+	unsigned int base;
+	unsigned int sysclk_reg;
+	unsigned int sysclk_mask;
+	unsigned int sysclk_shift;
 
 	struct list_head alg_regions;
 
-- 
2.11.0
