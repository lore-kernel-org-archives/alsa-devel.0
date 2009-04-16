From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] ASoC: Fix include build error in s3c2412-i2s.c
Date: Thu, 16 Apr 2009 10:32:21 +0100
Message-ID: <1239874343-7280-3-git-send-email-ben-linux@fluff.org>
References: <1239874343-7280-1-git-send-email-ben-linux@fluff.org>
	<1239874343-7280-2-git-send-email-ben-linux@fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from teyla.home.fluff.org (aeryn.fluff.org.uk [87.194.8.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 954E110394C
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 11:36:10 +0200 (CEST)
In-Reply-To: <1239874343-7280-2-git-send-email-ben-linux@fluff.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
Cc: Ben Dooks <ben-linux@fluff.org>
List-Id: alsa-devel@alsa-project.org

Fix accidental change of <mach/regs-gpio.h> to
<plat/regs-gpio.h> in s3c2412-i2s.c

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 sound/soc/s3c24xx/s3c2412-i2s.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/s3c24xx/s3c2412-i2s.c b/sound/soc/s3c24xx/s3c2412-i2s.c
index 1ca3cda..b7e0b3f 100644
--- a/sound/soc/s3c24xx/s3c2412-i2s.c
+++ b/sound/soc/s3c24xx/s3c2412-i2s.c
@@ -33,8 +33,8 @@
 
 #include <plat/regs-s3c2412-iis.h>
 
-#include <plat/regs-gpio.h>
 #include <plat/audio.h>
+#include <mach/regs-gpio.h>
 #include <mach/dma.h>
 
 #include "s3c24xx-pcm.h"
-- 
1.5.6.5
