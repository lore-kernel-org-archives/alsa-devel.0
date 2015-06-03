From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: fsl: Correct FSL_SAI_CR2_MSEL_MASK
	definition
Date: Wed,  3 Jun 2015 14:51:01 +0200
Message-ID: <1433335861-31474-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D7FC22606DA
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 14:51:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>
List-Id: alsa-devel@alsa-project.org

The bit mask FSL_SAI_CR2_MSEL_MASK is defined as (0xff << 26) and this
obviously overflows the 32bit integer.  Also this clears other bits
than the needed ones (FSL_SAI_CR2_MSEL_XXX) wrongly.

This patch fixes the definition only to mask bits 26 and 27.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=84351
Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/fsl/fsl_sai.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 34667209b607..0e33a17ddd01 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -72,7 +72,7 @@
 
 /* SAI Transmit and Recieve Configuration 2 Register */
 #define FSL_SAI_CR2_SYNC	BIT(30)
-#define FSL_SAI_CR2_MSEL_MASK	(0xff << 26)
+#define FSL_SAI_CR2_MSEL_MASK	(0x03 << 26)
 #define FSL_SAI_CR2_MSEL_BUS	0
 #define FSL_SAI_CR2_MSEL_MCLK1	BIT(26)
 #define FSL_SAI_CR2_MSEL_MCLK2	BIT(27)
-- 
2.4.2
