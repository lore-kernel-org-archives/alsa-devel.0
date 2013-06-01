From: o-takashi@sakamocchi.jp
Subject: [PATCH 8/8] modify Makefile and Kconfig to build this module
Date: Sun,  2 Jun 2013 00:55:58 +0900
Message-ID: <1370102158-24389-9-git-send-email-o-takashi@sakamocchi.jp>
References: <1370102158-24389-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1370102158-24389-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: perex@perex.cz, clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

The purpose of this file is building this module by Linux kernel's driver module
build system.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Kconfig            |   16 ++++++++++++++++
 sound/firewire/Makefile           |    2 ++
 sound/firewire/fireworks/Makefile |    2 ++
 3 files changed, 20 insertions(+)
 create mode 100644 sound/firewire/fireworks/Makefile

diff --git a/sound/firewire/Kconfig b/sound/firewire/Kconfig
index ea063e1..b4cbad5 100644
--- a/sound/firewire/Kconfig
+++ b/sound/firewire/Kconfig
@@ -46,4 +46,20 @@ config SND_SCS1X
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-scs1x.
 
+config SND_FIREWORKS
+	tristate "Echo Fireworks chipset support"
+	select SND_PCM
+	select SND_RAWMIDI
+	select SND_FIREWIRE_LIB
+	help
+	  Say Y here to include support for FireWire devices based
+	  on Echo Digital Audio's Fireworks architecture:
+	  * Echo AudioFire 2/4/8/8a/Pre8/12
+	  * Echo Fireworks 8/HDMI
+	  * Gibson Goldtop/RIP
+	  * Mackie Onyx 400F/1200F
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called snd-fireworks.
+
 endif # SND_FIREWIRE
diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
index 460179d..9d9d9e8 100644
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -8,3 +8,5 @@ obj-$(CONFIG_SND_FIREWIRE_LIB) += snd-firewire-lib.o
 obj-$(CONFIG_SND_FIREWIRE_SPEAKERS) += snd-firewire-speakers.o
 obj-$(CONFIG_SND_ISIGHT) += snd-isight.o
 obj-$(CONFIG_SND_SCS1X) += snd-scs1x.o
+
+obj-$(CONFIG_SND) += fireworks/
diff --git a/sound/firewire/fireworks/Makefile b/sound/firewire/fireworks/Makefile
new file mode 100644
index 0000000..3bdd77c
--- /dev/null
+++ b/sound/firewire/fireworks/Makefile
@@ -0,0 +1,2 @@
+snd-fireworks-objs := fireworks_command.o fireworks_proc.o fireworks_control.o fireworks_pcm.o fireworks_midi.o fireworks_stream.o fireworks.o
+obj-$(SND_FIREWORKS) += snd-fireworks.o
-- 
1.7.10.4


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
