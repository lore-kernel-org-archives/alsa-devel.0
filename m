From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 1/6] ASoC: max9867: Show Kconfig entry
Date: Thu, 1 Mar 2018 15:19:23 +0100
Message-ID: <20180301141923.GC30722@lenoch>
References: <20180301141843.GB30722@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 1478F26792C
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 15:19:25 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23993945AbeCAOTZiFhby (ORCPT
 <rfc822;alsa-devel@alsa-project.org>); Thu, 1 Mar 2018 15:19:25 +0100
Content-Disposition: inline
In-Reply-To: <20180301141843.GB30722@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

Allow codec to be selected.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 sound/soc/codecs/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index d874706a493e..822df8d3d4f9 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -640,7 +640,8 @@ config SND_SOC_MAX98504
 	depends on I2C
 
 config SND_SOC_MAX9867
-	tristate
+	tristate "Maxim MAX9867 CODEC"
+	depends on I2C
 
 config SND_SOC_MAX98925
        tristate
-- 
2.16.2
