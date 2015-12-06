From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 01/17] ALSA: oxfw: rename a file for control
	elements so that it's for model-specific
Date: Sun,  6 Dec 2015 13:18:09 +0900
Message-ID: <1449375505-2704-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id E6E462604AA
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 05:18:30 +0100 (CET)
In-Reply-To: <1449375505-2704-1-git-send-email-o-takashi@sakamocchi.jp>
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

In ALSA firewire stack, drivers basically has no control elements. This
is due to the fact that each model has own functionality even if they use
the same communication chipset. Implementing all of the functionalities in
kernel space unreasonably increases our efforts to maintain the stack. In
most case, these functionalities can be implemented in userspace via Linux
fw character devices.

However, ALSA OXFW driver has control elements comes from old
firewire-speakers driver. Adding the elements is in a file names as
'oxfw-control.c', while the elements are really model-specific. The
name is confusing because it gives an idea to handle control elements
for all of OXFW-based models.

This commit renames the file so that it's just for models supported by
old firewire-speakers driver.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/Makefile                        | 4 ++--
 sound/firewire/oxfw/{oxfw-control.c => oxfw-spkr.c} | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename sound/firewire/oxfw/{oxfw-control.c => oxfw-spkr.c} (99%)

diff --git a/sound/firewire/oxfw/Makefile b/sound/firewire/oxfw/Makefile
index 06ff50f..4e54ba9 100644
--- a/sound/firewire/oxfw/Makefile
+++ b/sound/firewire/oxfw/Makefile
@@ -1,3 +1,3 @@
-snd-oxfw-objs := oxfw-command.o oxfw-stream.o oxfw-control.o oxfw-pcm.o \
-		 oxfw-proc.o oxfw-midi.o oxfw-hwdep.o oxfw.o
+snd-oxfw-objs := oxfw-command.o oxfw-stream.o oxfw-pcm.o oxfw-proc.o \
+		 oxfw-midi.o oxfw-hwdep.o oxfw-spkr.o oxfw.o
 obj-$(CONFIG_SND_OXFW) += snd-oxfw.o
diff --git a/sound/firewire/oxfw/oxfw-control.c b/sound/firewire/oxfw/oxfw-spkr.c
similarity index 99%
rename from sound/firewire/oxfw/oxfw-control.c
rename to sound/firewire/oxfw/oxfw-spkr.c
index 02a1cb9..22d8536 100644
--- a/sound/firewire/oxfw/oxfw-control.c
+++ b/sound/firewire/oxfw/oxfw-spkr.c
@@ -1,5 +1,5 @@
 /*
- * oxfw_stream.c - a part of driver for OXFW970/971 based devices
+ * oxfw-spkr.c - a part of driver for OXFW970/971 based devices
  *
  * Copyright (c) Clemens Ladisch <clemens@ladisch.de>
  * Licensed under the terms of the GNU General Public License, version 2.
-- 
2.5.0
