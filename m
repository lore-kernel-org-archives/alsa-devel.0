From: Huang Weiyi <weiyi.huang@gmail.com>
Subject: sound/soc/pxa/tosa.c: removed duplicated include
Date: Sat, 26 Jul 2008 20:43:01 +0800
Message-ID: <20080726204150.AF5E.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ti-out-0910.google.com (ti-out-0910.google.com [209.85.142.184])
	by alsa0.perex.cz (Postfix) with ESMTP id C4ED3103815
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Jul 2008 14:43:04 +0200 (CEST)
Received: by ti-out-0910.google.com with SMTP id j3so1843878tid.8
	for <alsa-devel@alsa-project.org>; Sat, 26 Jul 2008 05:43:02 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: liam.girdwood@wolfsonmicro.com, broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Removed duplicated include <asm/arch/tosa.h> in 
sound/soc/pxa/tosa.c.

Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>

diff --git a/sound/soc/pxa/tosa.c b/sound/soc/pxa/tosa.c
index fe6cca9..22971a0 100644
--- a/sound/soc/pxa/tosa.c
+++ b/sound/soc/pxa/tosa.c
@@ -33,7 +33,6 @@
 #include <asm/arch/pxa-regs.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/audio.h>
-#include <asm/arch/tosa.h>

 #include "../codecs/wm9712.h"
 #include "pxa2xx-pcm.h"
