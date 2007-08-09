From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] isa libs Makefiles cleanup
Date: Thu, 9 Aug 2007 22:36:29 +0200
Message-ID: <20070809223629.dadd33e7.krzysztof.h1@wp.pl>
References: <20070809190643.6e5a16be.krzysztof.h1@wp.pl>
	<s5hps1wwrmf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E83E1037EE
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Aug 2007 22:32:15 +0200 (CEST)
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <alsa-devel@alsa-project.org>; 9 Aug 2007 22:32:14 +0200
In-Reply-To: <s5hps1wwrmf.wl%tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch uses the Kconfig parameters SND_AD1848_LIB and
SND_CS4231_LIB instead of mentioning each driver that requires
 the ad1848-lib or cs4231-lib separately in the Makefiles.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This is short enough to do both libraries in one patch.

diff -urp linux-2.6.22.new/sound/isa/ad1848/Makefile linux-2.6.23/sound/isa/ad1848/Makefile
--- linux-2.6.22.new/sound/isa/ad1848/Makefile	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.23/sound/isa/ad1848/Makefile	2007-08-09 22:24:30.863357129 +0200
@@ -7,9 +7,6 @@ snd-ad1848-lib-objs := ad1848_lib.o
 snd-ad1848-objs := ad1848.o
 
 # Toplevel Module Dependency
-obj-$(CONFIG_SND_CMI8330) += snd-ad1848-lib.o
-obj-$(CONFIG_SND_SGALAXY) += snd-ad1848-lib.o
-obj-$(CONFIG_SND_AD1848) += snd-ad1848.o snd-ad1848-lib.o
-obj-$(CONFIG_SND_OPTI92X_AD1848) += snd-ad1848-lib.o
+obj-$(CONFIG_SND_AD1848) += snd-ad1848.o
+obj-$(CONFIG_SND_AD1848_LIB) += snd-ad1848-lib.o
 
-obj-m := $(sort $(obj-m))
diff -urp linux-2.6.22.new/sound/isa/cs423x/Makefile linux-2.6.23/sound/isa/cs423x/Makefile
--- linux-2.6.22.new/sound/isa/cs423x/Makefile	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.23/sound/isa/cs423x/Makefile	2007-08-09 22:25:32.794886405 +0200
@@ -10,17 +10,8 @@ snd-cs4232-objs := cs4232.o
 snd-cs4236-objs := cs4236.o
 
 # Toplevel Module Dependency
-obj-$(CONFIG_SND_AZT2320) += snd-cs4231-lib.o
-obj-$(CONFIG_SND_MIRO) += snd-cs4231-lib.o
-obj-$(CONFIG_SND_OPL3SA2) += snd-cs4231-lib.o
-obj-$(CONFIG_SND_CS4231) += snd-cs4231.o snd-cs4231-lib.o
-obj-$(CONFIG_SND_CS4232) += snd-cs4232.o snd-cs4231-lib.o
-obj-$(CONFIG_SND_CS4236) += snd-cs4236.o snd-cs4236-lib.o snd-cs4231-lib.o
-obj-$(CONFIG_SND_GUSMAX) += snd-cs4231-lib.o
-obj-$(CONFIG_SND_INTERWAVE) += snd-cs4231-lib.o
-obj-$(CONFIG_SND_INTERWAVE_STB) += snd-cs4231-lib.o
-obj-$(CONFIG_SND_OPTI92X_CS4231) += snd-cs4231-lib.o
-obj-$(CONFIG_SND_WAVEFRONT) += snd-cs4231-lib.o
-obj-$(CONFIG_SND_SSCAPE) += snd-cs4231-lib.o
+obj-$(CONFIG_SND_CS4231_LIB) += snd-cs4231-lib.o
+obj-$(CONFIG_SND_CS4231) += snd-cs4231.o
+obj-$(CONFIG_SND_CS4232) += snd-cs4232.o
+obj-$(CONFIG_SND_CS4236) += snd-cs4236.o snd-cs4236-lib.o
 
-obj-m := $(sort $(obj-m))
