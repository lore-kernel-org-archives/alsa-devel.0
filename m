From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH 2/2] gpio: include linux/gpio.h where needed
Date: Tue, 14 Jun 2011 17:06:02 -0700
Message-ID: <20110614170602.7a51b1af.randy.dunlap@oracle.com>
References: <4DDB3AFF.9030006@oracle.com>
	<20110524075248.GB19734@sirena.org.uk>
	<20110527074552.GA907@ponder.secretlab.ca>
	<4DDFE391.2030507@oracle.com>
	<20110527201201.GA6645@ponder.secretlab.ca>
	<BANLkTin-KSVcG2cQfRM3Ys0_g_uJVruDMw@mail.gmail.com>
	<20110603171837.GA9918@opensource.wolfsonmicro.com>
	<BANLkTi=oko_C8_46Y8p5O1Qvw1KEn-1PjA@mail.gmail.com>
	<4DEC4D67.6010506@oracle.com>
	<20110614091211.465553de.randy.dunlap@oracle.com>
	<20110614161357.GB1839@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet10.oracle.com (rcsinet10.oracle.com [148.87.113.121])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DA471038DD
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 02:06:46 +0200 (CEST)
In-Reply-To: <20110614161357.GB1839@ponder.secretlab.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, x86@kernel.org, Dmitry Artamonow <mad_soft@inbox.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, Harald Welte <laforge@gnufiish.org>
List-Id: alsa-devel@alsa-project.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Some files use GPIOF_ macros but don't include the header file
for them.  These macros are being moved to <linux/gpio.h>, so add
includes for <linux/gpio.h> where needed.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 arch/arm/mach-pxa/spitz_pm.c    |    1 +
 drivers/pcmcia/pxa2xx_vpac270.c |    1 +
 2 files changed, 2 insertions(+)

--- linux-next-20110614.orig/arch/arm/mach-pxa/spitz_pm.c
+++ linux-next-20110614/arch/arm/mach-pxa/spitz_pm.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/apm-emulation.h>
--- linux-next-20110614.orig/drivers/pcmcia/pxa2xx_vpac270.c
+++ linux-next-20110614/drivers/pcmcia/pxa2xx_vpac270.c
@@ -11,6 +11,7 @@
  *
  */
 
+#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
