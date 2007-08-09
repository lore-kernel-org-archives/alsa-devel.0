From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] ad1848-lib Makefile cleanup
Date: Thu, 9 Aug 2007 19:06:43 +0200
Message-ID: <20070809190643.6e5a16be.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 33675243B1
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Aug 2007 19:02:37 +0200 (CEST)
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <alsa-devel@alsa-project.org>; 9 Aug 2007 19:02:29 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch uses the Kconfig parameter SND_AD1848_LIB instead
of mentioning each driver that requires the ad1848-lib separately
in the Makefile.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-2.6.23.old/sound/isa/ad1848/Makefile linux-2.6.23/sound/isa/ad1848/Makefile
--- linux-2.6.23.old/sound/isa/ad1848/Makefile	2007-08-04 22:12:08.000000000 +0200
+++ linux-2.6.23/sound/isa/ad1848/Makefile	2007-08-08 18:53:20.000000000 +0200
@@ -7,9 +7,7 @@ snd-ad1848-lib-objs := ad1848_lib.o
 snd-ad1848-objs := ad1848.o
 
 # Toplevel Module Dependency
-obj-$(CONFIG_SND_CMI8330) += snd-ad1848-lib.o
-obj-$(CONFIG_SND_SGALAXY) += snd-ad1848-lib.o
 obj-$(CONFIG_SND_AD1848) += snd-ad1848.o snd-ad1848-lib.o
-obj-$(CONFIG_SND_OPTI92X_AD1848) += snd-ad1848-lib.o
+obj-$(CONFIG_SND_AD1848_LIB) += snd-ad1848-lib.o
 
 obj-m := $(sort $(obj-m))
