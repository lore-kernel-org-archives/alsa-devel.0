From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 4/6] ALSA: usb-mixer: rename usbmixer.[ch] ->
	mixer.[ch]
Date: Thu, 11 Mar 2010 21:13:23 +0100
Message-ID: <1268338405-8944-5-git-send-email-daniel@caiaq.de>
References: <1268338405-8944-1-git-send-email-daniel@caiaq.de>
	<1268338405-8944-2-git-send-email-daniel@caiaq.de>
	<1268338405-8944-3-git-send-email-daniel@caiaq.de>
	<1268338405-8944-4-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F942103804
	for <alsa-devel@alsa-project.org>; Thu, 11 Mar 2010 21:14:18 +0100 (CET)
In-Reply-To: <1268338405-8944-4-git-send-email-daniel@caiaq.de>
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

For clearer namespace, also rename usbmixer_maps.c -> mixer_maps.c

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/Makefile                          |    2 +-
 sound/usb/card.c                            |    2 +-
 sound/usb/{usbmixer.c => mixer.c}           |    4 ++--
 sound/usb/{usbmixer.h => mixer.h}           |    0
 sound/usb/{usbmixer_maps.c => mixer_maps.c} |    0
 sound/usb/mixer_quirks.c                    |    2 +-
 sound/usb/quirks.c                          |    2 +-
 7 files changed, 6 insertions(+), 6 deletions(-)
 rename sound/usb/{usbmixer.c => mixer.c} (99%)
 rename sound/usb/{usbmixer.h => mixer.h} (100%)
 rename sound/usb/{usbmixer_maps.c => mixer_maps.c} (100%)

diff --git a/sound/usb/Makefile b/sound/usb/Makefile
index 744024a..e7ac7f4 100644
--- a/sound/usb/Makefile
+++ b/sound/usb/Makefile
@@ -3,7 +3,7 @@
 #
 
 snd-usb-audio-objs := 	card.o \
-			usbmixer.o \
+			mixer.o \
 			mixer_quirks.o \
 			proc.o \
 			quirks.o \
diff --git a/sound/usb/card.c b/sound/usb/card.c
index 78d12ff..0bd62a1 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -56,7 +56,7 @@
 #include "usbaudio.h"
 #include "card.h"
 #include "midi.h"
-#include "usbmixer.h"
+#include "mixer.h"
 #include "proc.h"
 #include "quirks.h"
 #include "endpoint.h"
diff --git a/sound/usb/usbmixer.c b/sound/usb/mixer.c
similarity index 99%
rename from sound/usb/usbmixer.c
rename to sound/usb/mixer.c
index ec2436e..4e7c2fd 100644
--- a/sound/usb/usbmixer.c
+++ b/sound/usb/mixer.c
@@ -41,7 +41,7 @@
 #include <sound/tlv.h>
 
 #include "usbaudio.h"
-#include "usbmixer.h"
+#include "mixer.h"
 #include "helper.h"
 #include "mixer_quirks.h"
 
@@ -132,7 +132,7 @@ enum {
  * if the mixer topology is too complicated and the parsed names are
  * ambiguous, add the entries in usbmixer_maps.c.
  */
-#include "usbmixer_maps.c"
+#include "mixer_maps.c"
 
 static const struct usbmix_name_map *
 find_map(struct mixer_build *state, int unitid, int control)
diff --git a/sound/usb/usbmixer.h b/sound/usb/mixer.h
similarity index 100%
rename from sound/usb/usbmixer.h
rename to sound/usb/mixer.h
diff --git a/sound/usb/usbmixer_maps.c b/sound/usb/mixer_maps.c
similarity index 100%
rename from sound/usb/usbmixer_maps.c
rename to sound/usb/mixer_maps.c
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index d2f4dcd..56b6659 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -35,7 +35,7 @@
 #include <sound/info.h>
 
 #include "usbaudio.h"
-#include "usbmixer.h"
+#include "mixer.h"
 #include "mixer_quirks.h"
 #include "helper.h"
 
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index a82cfed..d4ced64 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -24,7 +24,7 @@
 
 #include "usbaudio.h"
 #include "card.h"
-#include "usbmixer.h"
+#include "mixer.h"
 #include "mixer_quirks.h"
 #include "midi.h"
 #include "quirks.h"
-- 
1.6.6.2
