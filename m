From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: davinci-evm: Do not include
	davinci-pcm.h and davinci-i2s.h
Date: Mon, 2 Feb 2015 14:49:42 +0200
Message-ID: <1422881382-26405-3-git-send-email-peter.ujfalusi@ti.com>
References: <1422881382-26405-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id D2FFB2605F1
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 13:49:52 +0100 (CET)
In-Reply-To: <1422881382-26405-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: olof@lixom.net, alsa-devel@alsa-project.org, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, arnd@arndb.de
List-Id: alsa-devel@alsa-project.org

There is no need for them to be included.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-evm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index d1a8b6e3ac3b..b6bb5947a8a8 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -24,9 +24,6 @@
 #include <asm/dma.h>
 #include <asm/mach-types.h>
 
-#include "davinci-pcm.h"
-#include "davinci-i2s.h"
-
 struct snd_soc_card_drvdata_davinci {
 	struct clk *mclk;
 	unsigned sysclk;
-- 
2.2.2
