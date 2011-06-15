From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH 1/2] gpio: add GPIOF_ values regardless on
	kconfig settings
Date: Tue, 14 Jun 2011 17:05:11 -0700
Message-ID: <20110614170511.5cb8c8b2.randy.dunlap@oracle.com>
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
	by alsa0.perex.cz (Postfix) with ESMTP id D92C924416
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 02:06:43 +0200 (CEST)
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

Make GPIOF_ defined values available even when GPIOLIB nor GENERIC_GPIO
is enabled by moving them to <linux/gpio.h>.

Fixes these build errors in linux-next:
sound/soc/codecs/ak4641.c:524: error: 'GPIOF_OUT_INIT_LOW' undeclared (first use in this function)
sound/soc/codecs/wm8915.c:2921: error: 'GPIOF_OUT_INIT_LOW' undeclared (first use in this function)

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 include/asm-generic/gpio.h |   10 ----------
 include/linux/gpio.h       |   11 +++++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)

--- linux-next-20110614.orig/include/asm-generic/gpio.h
+++ linux-next-20110614/include/asm-generic/gpio.h
@@ -170,16 +170,6 @@ extern int __gpio_cansleep(unsigned gpio
 
 extern int __gpio_to_irq(unsigned gpio);
 
-#define GPIOF_DIR_OUT	(0 << 0)
-#define GPIOF_DIR_IN	(1 << 0)
-
-#define GPIOF_INIT_LOW	(0 << 1)
-#define GPIOF_INIT_HIGH	(1 << 1)
-
-#define GPIOF_IN		(GPIOF_DIR_IN)
-#define GPIOF_OUT_INIT_LOW	(GPIOF_DIR_OUT | GPIOF_INIT_LOW)
-#define GPIOF_OUT_INIT_HIGH	(GPIOF_DIR_OUT | GPIOF_INIT_HIGH)
-
 /**
  * struct gpio - a structure describing a GPIO with configuration
  * @gpio:	the GPIO number
--- linux-next-20110614.orig/include/linux/gpio.h
+++ linux-next-20110614/include/linux/gpio.h
@@ -3,6 +3,17 @@
 
 /* see Documentation/gpio.txt */
 
+/* make these flag values available regardless of GPIO kconfig options */
+#define GPIOF_DIR_OUT	(0 << 0)
+#define GPIOF_DIR_IN	(1 << 0)
+
+#define GPIOF_INIT_LOW	(0 << 1)
+#define GPIOF_INIT_HIGH	(1 << 1)
+
+#define GPIOF_IN		(GPIOF_DIR_IN)
+#define GPIOF_OUT_INIT_LOW	(GPIOF_DIR_OUT | GPIOF_INIT_LOW)
+#define GPIOF_OUT_INIT_HIGH	(GPIOF_DIR_OUT | GPIOF_INIT_HIGH)
+
 #ifdef CONFIG_GENERIC_GPIO
 #include <asm/gpio.h>
 
