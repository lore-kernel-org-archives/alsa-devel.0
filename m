From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC 11/12] snd-aoa: add Kconfig and Makefile
Date: Wed, 07 Jun 2006 15:09:20 +0200
Message-ID: <20060607130917.996988000@sipsolutions.net>
References: <20060607130909.584205000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 04D16169
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jun 2006 15:11:59 +0200 (MEST)
Content-Disposition: inline; filename=add-build-stuff.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
Cc: linuxppc-dev@ozlabs.org, netstar@gatheringofgray.com
List-Id: alsa-devel@alsa-project.org

This patch adds the simple Kconfig and Makefile files for aoa.

--- /dev/null
+++ b/sound/aoa/Kconfig
@@ -0,0 +1,17 @@
+menu "Apple Onboard Audio driver"
+	depends on SND != n && PPC
+
+config SND_AOA
+	tristate "Apple Onboard Audio driver"
+	depends on SOUND && SND_PCM && EXPERIMENTAL
+	---help---
+	This option enables the new driver for the various
+	Apple Onboard Audio components.
+
+source "sound/aoa/fabrics/Kconfig"
+
+source "sound/aoa/codecs/Kconfig"
+
+source "sound/aoa/soundbus/Kconfig"
+
+endmenu
--- /dev/null
+++ b/sound/aoa/Makefile
@@ -0,0 +1,4 @@
+obj-$(CONFIG_SND_AOA) += core/
+obj-$(CONFIG_SND_AOA) += codecs/
+obj-$(CONFIG_SND_AOA) += fabrics/
+obj-$(CONFIG_SND_AOA_SOUNDBUS) += soundbus/

--
