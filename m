From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/25] ALSA: firewire-lib: rename 'amdtp' to
	'amdtp-stream' for functional separation
Date: Thu, 13 Aug 2015 09:19:57 +0900
Message-ID: <1439425221-30826-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1439425221-30826-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id C02A12612DE
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 02:20:34 +0200 (CEST)
In-Reply-To: <1439425221-30826-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This commit is a preparation for splitting to packet transmission layer
and data processing layer.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Makefile                    | 2 +-
 sound/firewire/{amdtp.c => amdtp-stream.c} | 2 +-
 sound/firewire/{amdtp.h => amdtp-stream.h} | 4 ++--
 sound/firewire/bebob/bebob.h               | 2 +-
 sound/firewire/dice/dice.h                 | 2 +-
 sound/firewire/fcp.c                       | 2 +-
 sound/firewire/fireworks/fireworks.h       | 2 +-
 sound/firewire/oxfw/oxfw.h                 | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)
 rename sound/firewire/{amdtp.c => amdtp-stream.c} (99%)
 rename sound/firewire/{amdtp.h => amdtp-stream.h} (99%)

diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
index 8b37f08..102e342 100644
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -1,5 +1,5 @@
 snd-firewire-lib-objs := lib.o iso-resources.o packets-buffer.o \
-			 fcp.o cmp.o amdtp.o
+			 fcp.o cmp.o amdtp-stream.o
 snd-oxfw-objs := oxfw.o
 snd-isight-objs := isight.o
 snd-scs1x-objs := scs1x.o
diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp-stream.c
similarity index 99%
rename from sound/firewire/amdtp.c
rename to sound/firewire/amdtp-stream.c
index 2a153d2..50e4d40 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp-stream.c
@@ -15,7 +15,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/rawmidi.h>
-#include "amdtp.h"
+#include "amdtp-stream.h"
 
 #define TICKS_PER_CYCLE		3072
 #define CYCLES_PER_SECOND	8000
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp-stream.h
similarity index 99%
rename from sound/firewire/amdtp.h
rename to sound/firewire/amdtp-stream.h
index b2cf9e7..adab54f 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp-stream.h
@@ -1,5 +1,5 @@
-#ifndef SOUND_FIREWIRE_AMDTP_H_INCLUDED
-#define SOUND_FIREWIRE_AMDTP_H_INCLUDED
+#ifndef SOUND_FIREWIRE_AMDTP_STREAM_H_INCLUDED
+#define SOUND_FIREWIRE_AMDTP_STREAM_H_INCLUDED
 
 #include <linux/err.h>
 #include <linux/interrupt.h>
diff --git a/sound/firewire/bebob/bebob.h b/sound/firewire/bebob/bebob.h
index d23caca..72a1c5e 100644
--- a/sound/firewire/bebob/bebob.h
+++ b/sound/firewire/bebob/bebob.h
@@ -31,7 +31,7 @@
 #include "../fcp.h"
 #include "../packets-buffer.h"
 #include "../iso-resources.h"
-#include "../amdtp.h"
+#include "../amdtp-stream.h"
 #include "../cmp.h"
 
 /* basic register addresses on DM1000/DM1100/DM1500 */
diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
index ecf5dc8..29578c1 100644
--- a/sound/firewire/dice/dice.h
+++ b/sound/firewire/dice/dice.h
@@ -34,7 +34,7 @@
 #include <sound/pcm_params.h>
 #include <sound/rawmidi.h>
 
-#include "../amdtp.h"
+#include "../amdtp-stream.h"
 #include "../iso-resources.h"
 #include "../lib.h"
 #include "dice-interface.h"
diff --git a/sound/firewire/fcp.c b/sound/firewire/fcp.c
index 0619597..cce1976 100644
--- a/sound/firewire/fcp.c
+++ b/sound/firewire/fcp.c
@@ -17,7 +17,7 @@
 #include <linux/delay.h>
 #include "fcp.h"
 #include "lib.h"
-#include "amdtp.h"
+#include "amdtp-stream.h"
 
 #define CTS_AVC 0x00
 
diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index 084d414..d54f171 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -29,7 +29,7 @@
 
 #include "../packets-buffer.h"
 #include "../iso-resources.h"
-#include "../amdtp.h"
+#include "../amdtp-stream.h"
 #include "../cmp.h"
 #include "../lib.h"
 
diff --git a/sound/firewire/oxfw/oxfw.h b/sound/firewire/oxfw/oxfw.h
index cace5ad..2c3d20b 100644
--- a/sound/firewire/oxfw/oxfw.h
+++ b/sound/firewire/oxfw/oxfw.h
@@ -28,7 +28,7 @@
 #include "../fcp.h"
 #include "../packets-buffer.h"
 #include "../iso-resources.h"
-#include "../amdtp.h"
+#include "../amdtp-stream.h"
 #include "../cmp.h"
 
 struct device_info {
-- 
2.1.4
