From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC 09/12] snd-aoa: add build files for codecs
Date: Wed, 07 Jun 2006 15:09:18 +0200
Message-ID: <20060607130916.954103000@sipsolutions.net>
References: <20060607130909.584205000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7C325169
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jun 2006 15:11:41 +0200 (MEST)
Content-Disposition: inline; filename=add-codec-build.patch
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

This adds the Makefile and Kconfig file for the codecs
that were added in the previous patches.

--- /dev/null
+++ b/sound/aoa/codecs/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_SND_AOA_ONYX) += snd-aoa-codec-onyx.o
+obj-$(CONFIG_SND_AOA_TAS) += snd-aoa-codec-tas.o
+obj-$(CONFIG_SND_AOA_TOONIE) += snd-aoa-codec-toonie.o
--- /dev/null
+++ b/sound/aoa/codecs/Kconfig
@@ -0,0 +1,32 @@
+config SND_AOA_ONYX
+	tristate "support Onyx chip"
+	depends on SND_AOA
+	---help---
+	This option enables support for the Onyx (pcm3052)
+	codec chip found in the latest Apple machines
+	(most of those with digital audio output).
+
+#config SND_AOA_TOPAZ
+#	tristate "support Topaz chips"
+#	depends on SND_AOA
+#	---help---
+#	This option enables support for the Topaz (CS84xx)
+#	codec chips found in the latest Apple machines,
+#	these chips do the digital input and output on
+#	some PowerMacs.
+
+config SND_AOA_TAS
+	tristate "support TAS chips"
+	depends on SND_AOA
+	---help---
+	This option enables support for the tas chips
+	found in a lot of Apple Machines, especially
+	iBooks and PowerBooks without digital.
+
+config SND_AOA_TOONIE
+	tristate "support Toonie chip"
+	depends on SND_AOA
+	---help---
+	This option enables support for the toonie codec
+	found in the Mac Mini. If you have a Mac Mini and
+	want to hear sound, select this option.

--
