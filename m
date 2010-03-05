From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 1/8] ALSA: usb-audio: move ua101 driver
Date: Fri,  5 Mar 2010 08:41:18 +0100
Message-ID: <1267774885-16266-2-git-send-email-daniel@caiaq.de>
References: <1267774885-16266-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 2459A103847
	for <alsa-devel@alsa-project.org>; Fri,  5 Mar 2010 08:41:51 +0100 (CET)
In-Reply-To: <1267774885-16266-1-git-send-email-daniel@caiaq.de>
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
Cc: tiwai@suse.de, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

As part of the USB audio code cleanup, move the non-standard ua101
driver out of the way.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/Makefile           |    5 ++---
 sound/usb/misc/Makefile      |    2 ++
 sound/usb/{ => misc}/ua101.c |    2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)
 create mode 100644 sound/usb/misc/Makefile
 rename sound/usb/{ => misc}/ua101.c (99%)

diff --git a/sound/usb/Makefile b/sound/usb/Makefile
index 5bf64ae..b0e5597 100644
--- a/sound/usb/Makefile
+++ b/sound/usb/Makefile
@@ -4,12 +4,11 @@
 
 snd-usb-audio-objs := usbaudio.o usbmixer.o
 snd-usb-lib-objs := usbmidi.o
-snd-ua101-objs := ua101.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_USB_AUDIO) += snd-usb-audio.o snd-usb-lib.o
-obj-$(CONFIG_SND_USB_UA101) += snd-ua101.o snd-usb-lib.o
+obj-$(CONFIG_SND_USB_UA101) += snd-usb-lib.o
 obj-$(CONFIG_SND_USB_USX2Y) += snd-usb-lib.o
 obj-$(CONFIG_SND_USB_US122L) += snd-usb-lib.o
 
-obj-$(CONFIG_SND) += usx2y/ caiaq/
+obj-$(CONFIG_SND) += misc/ usx2y/ caiaq/
diff --git a/sound/usb/misc/Makefile b/sound/usb/misc/Makefile
new file mode 100644
index 0000000..ccefd81
--- /dev/null
+++ b/sound/usb/misc/Makefile
@@ -0,0 +1,2 @@
+snd-ua101-objs := ua101.o
+obj-$(CONFIG_SND_USB_UA101) += snd-ua101.o
diff --git a/sound/usb/ua101.c b/sound/usb/misc/ua101.c
similarity index 99%
rename from sound/usb/ua101.c
rename to sound/usb/misc/ua101.c
index 3d458d3..e9b0ae5 100644
--- a/sound/usb/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -23,7 +23,7 @@
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
-#include "usbaudio.h"
+#include "../usbaudio.h"
 
 MODULE_DESCRIPTION("Edirol UA-101/1000 driver");
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
-- 
1.6.6.2
