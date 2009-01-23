From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/9] ASoC: Remove unneeded e7x0 inclusion of
	pxa-regs.h and hardware.h
Date: Fri, 23 Jan 2009 17:18:35 +0000
Message-ID: <1232731120-6144-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090123171619.GB6003@rakim.wolfsonmicro.main>
	<1232731120-6144-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1232731120-6144-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 61D332448E
	for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2009 18:18:42 +0100 (CET)
In-Reply-To: <1232731120-6144-3-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

pxa-regs.h and hardware.h are not intended for use directly in driver
code and references to them have been removed in other code - remove
them from the newly added e740 and e750 machine drivers.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/e740_wm9705.c |    2 --
 sound/soc/pxa/e750_wm9705.c |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/e740_wm9705.c b/sound/soc/pxa/e740_wm9705.c
index ac36176..7cd2f89 100644
--- a/sound/soc/pxa/e740_wm9705.c
+++ b/sound/soc/pxa/e740_wm9705.c
@@ -18,8 +18,6 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 
-#include <mach/pxa-regs.h>
-#include <mach/hardware.h>
 #include <mach/audio.h>
 #include <mach/eseries-gpio.h>
 
diff --git a/sound/soc/pxa/e750_wm9705.c b/sound/soc/pxa/e750_wm9705.c
index 20fbdcf..8dceccc 100644
--- a/sound/soc/pxa/e750_wm9705.c
+++ b/sound/soc/pxa/e750_wm9705.c
@@ -18,8 +18,6 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 
-#include <mach/pxa-regs.h>
-#include <mach/hardware.h>
 #include <mach/audio.h>
 #include <mach/eseries-gpio.h>
 
-- 
1.5.6.5
