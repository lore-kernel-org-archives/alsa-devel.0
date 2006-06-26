From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] fix build failure due to snd-aoa
Date: Mon, 26 Jun 2006 08:25:34 +0200
Message-ID: <1151303134.7608.86.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 54FD91A8
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jun 2006 08:25:36 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

When snd-aoa is not built or built as modules, but CONFIG_SND is yes,
kernel build fails due to a bug I introduced when adding snd-aoa. This
patch fixes it.

From: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- a/sound/Makefile    Fri Jun 23 15:18:41 2006 +0200
+++ b/sound/Makefile    Fri Jun 23 16:49:15 2006 +0200
@@ -4,7 +4,8 @@ obj-$(CONFIG_SOUND) += soundcore.o
 obj-$(CONFIG_SOUND) += soundcore.o
 obj-$(CONFIG_SOUND_PRIME) += oss/
 obj-$(CONFIG_DMASOUND) += oss/
-obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ mips/ aoa/
+obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ synth/ usb/ sparc/ parisc/ pcmcia/ mips/
+obj-$(CONFIG_SND_AOA) += aoa/
 
 ifeq ($(CONFIG_SND),y)
   obj-y += last.o



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
