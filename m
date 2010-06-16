From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 1/5] ALSA: usb-audio: clean up includes in
	clock.c
Date: Wed, 16 Jun 2010 17:57:27 +0200
Message-ID: <1276703851-22199-2-git-send-email-daniel@caiaq.de>
References: <1276703851-22199-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id B1A392413A
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jun 2010 17:57:43 +0200 (CEST)
In-Reply-To: <1276703851-22199-1-git-send-email-daniel@caiaq.de>
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
Cc: tiwai@suse.de, alexlee188@gmail.com, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 sound/usb/clock.c |   16 +---------------
 1 files changed, 1 insertions(+), 15 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index b585511..386b09c 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -19,33 +19,19 @@
 
 #include <linux/bitops.h>
 #include <linux/init.h>
-#include <linux/list.h>
-#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/usb.h>
-#include <linux/moduleparam.h>
-#include <linux/mutex.h>
 #include <linux/usb/audio.h>
 #include <linux/usb/audio-v2.h>
 
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/pcm.h>
-#include <sound/pcm_params.h>
-#include <sound/initval.h>
 
 #include "usbaudio.h"
 #include "card.h"
-#include "midi.h"
-#include "mixer.h"
-#include "proc.h"
-#include "quirks.h"
-#include "endpoint.h"
 #include "helper.h"
-#include "debug.h"
-#include "pcm.h"
-#include "urb.h"
-#include "format.h"
+#include "clock.h"
 
 static struct uac_clock_source_descriptor *
 	snd_usb_find_clock_source(struct usb_host_interface *ctrl_iface,
-- 
1.7.1
