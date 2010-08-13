From: Ian Lartey <ian@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: multi-component: Fix reference to moved
 header file, which was unused anyway.
Date: Fri, 13 Aug 2010 17:02:13 +0100
Message-ID: <1281715333.2074.44.camel@Tapajos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id ED9482437B
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 18:02:49 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

 Removed #include of pxa2xx-pcm.h

Signed-off-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
---
 sound/soc/pxa/pxa2xx-i2s.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 3b473b2..d1b2ca6 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -27,7 +27,6 @@
 #include <mach/dma.h>
 #include <mach/audio.h>
 
-#include "pxa2xx-pcm.h"
 #include "pxa2xx-i2s.h"
 
 /*
-- 
1.7.0.4
