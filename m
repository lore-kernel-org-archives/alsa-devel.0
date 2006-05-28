From: Johannes Berg <johannes@sipsolutions.net>
Subject: [RFC 7/7] snd-aoa: wire up aoa in sound/
Date: Sun, 28 May 2006 21:00:33 +0200
Message-ID: <20060528190131.137228000@johannes.berg>
References: <20060528190026.754474000@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E948C192
	for <alsa-devel@alsa-project.org>;
	Sun, 28 May 2006 21:02:42 +0200 (MEST)
Content-Disposition: inline; filename=07-wire-up.patch
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

This patch adds the necessary Kconfig and Makefile hooks to make aoa
buildable inside the kernel tree.

--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -58,6 +58,8 @@ source "sound/pci/Kconfig"
 
 source "sound/ppc/Kconfig"
 
+source "sound/aoa/Kconfig"
+
 source "sound/arm/Kconfig"
 
 source "sound/mips/Kconfig"
--- a/sound/Makefile
+++ b/sound/Makefile
@@ -4,7 +4,7 @@ #
 obj-$(CONFIG_SOUND) += soundcore.o
 obj-$(CONFIG_SOUND_PRIME) += oss/
 obj-$(CONFIG_DMASOUND) += oss/
-obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ mips/
+obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ mips/ aoa/
 
 ifeq ($(CONFIG_SND),y)
   obj-y += last.o

--
