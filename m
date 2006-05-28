From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC 6/7] snd-aoa: add Kconfig and Makefile
Date: Sun, 28 May 2006 21:00:32 +0200
Message-ID: <20060528190130.441063000@johannes.berg>
References: <20060528190026.754474000@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 42E3E191
	for <alsa-devel@alsa-project.org>;
	Sun, 28 May 2006 21:02:52 +0200 (MEST)
Content-Disposition: inline; filename=06-add-build-stuff.patch
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
Cc: linuxppc-dev@ozlabs.org
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
