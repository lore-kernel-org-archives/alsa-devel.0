From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 7/7] ASoC: pxa-ssp: Remove unused DAI ID defines
Date: Sat, 15 Oct 2016 19:32:57 +0200
Message-ID: <1476552777-1849-7-git-send-email-lars@metafoo.de>
References: <1476552777-1849-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 45FCA261740
 for <alsa-devel@alsa-project.org>; Sat, 15 Oct 2016 20:00:54 +0200 (CEST)
In-Reply-To: <1476552777-1849-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Robert Jarzmik <robert.jarzmik@free.fr>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The DAI ID defines are back from the time when DAIs were referenced by a
numerical ID. These days a string is used for matching instead and the
defines are unused. The last user of these defines was removed in commit
f0fba2ad1b6b ("ASoC: multi-component - ASoC Multi-Component Support"). So
remove the defines as well.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/pxa/pxa-ssp.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.h b/sound/soc/pxa/pxa-ssp.h
index bc79da2..abf6ec0 100644
--- a/sound/soc/pxa/pxa-ssp.h
+++ b/sound/soc/pxa/pxa-ssp.h
@@ -9,12 +9,6 @@
 #ifndef _PXA_SSP_H
 #define _PXA_SSP_H
 
-/* pxa DAI SSP IDs */
-#define PXA_DAI_SSP1			0
-#define PXA_DAI_SSP2			1
-#define PXA_DAI_SSP3			2
-#define PXA_DAI_SSP4			3
-
 /* SSP clock sources */
 #define PXA_SSP_CLK_PLL	0
 #define PXA_SSP_CLK_EXT	1
-- 
2.1.4
