From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH asoc-dev 1/2] ASoC: Use correct include file
	for gpiolib in N810 machine driver
Date: Wed, 11 Jun 2008 11:52:49 +0300
Message-ID: <1213174370-29568-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id EEF942477D
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jun 2008 10:52:33 +0200 (CEST)
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m5B8q994017252
	for <alsa-devel@alsa-project.org>; Wed, 11 Jun 2008 11:52:31 +0300
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/omap/n810.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index 2d982b1..c32487b 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -30,7 +30,7 @@
 
 #include <asm/mach-types.h>
 #include <asm/arch/hardware.h>
-#include <asm/gpio.h>
+#include <linux/gpio.h>
 #include <asm/arch/mcbsp.h>
 
 #include "omap-mcbsp.h"
-- 
1.5.5.3
