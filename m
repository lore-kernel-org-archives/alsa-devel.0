From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: [PATCH] ASoC: Davinci: McASP: remove unused header
	include
Date: Wed, 8 Aug 2012 20:40:30 +0530
Message-ID: <1344438632-2604-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id DA0D326624F
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2012 16:55:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tony@atomide.com, lrg@ti.com, broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, sudhakar.raj@ti.com, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, gururaja.hebbar@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Defines or parameters from <mach/mux.h> isn't used anywhere. Hence
remove the header include.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
---
This patch was tested on AM18x Board and is based on repo at 
http://git.kernel.org/?p=linux/kernel/git/broonie/sound.git;
a=shortlog;h=refs/heads/for-3.6

:100644 100644 10a2d8c... c80c20a... M	sound/soc/davinci/davinci-evm.c
 sound/soc/davinci/davinci-evm.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 10a2d8c..c80c20a 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -24,7 +24,6 @@
 
 #include <mach/asp.h>
 #include <mach/edma.h>
-#include <mach/mux.h>
 
 #include "davinci-pcm.h"
 #include "davinci-i2s.h"
-- 
1.7.1
