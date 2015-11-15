From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/9] ALSA: oxfw: rename a file for control
	elements so that it means being model-specific
Date: Sun, 15 Nov 2015 18:25:58 +0900
Message-ID: <1447579565-4615-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1447579565-4615-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E52C261A2C
 for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2015 10:26:10 +0100 (CET)
In-Reply-To: <1447579565-4615-1-git-send-email-o-takashi@sakamocchi.jp>
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

Basically, drivers in ALSA firewire stack implement no control elements,
because they can be implemented in userspace as Linux FireWire subsystem
interface applications. Nevertheless, ALSA oxfw driver has some control
elements. This is due to backward compatibility to old firewire-speakers
module. The control elements are model-specific, while the file name gives
an impression of oxfw generic functionality.

This commit renames the file so that it's specific for two models.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/Makefile                        | 4 ++--
 sound/firewire/oxfw/{oxfw-control.c => oxfw-spkr.c} | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)
 rename sound/firewire/oxfw/{oxfw-control.c => oxfw-spkr.c} (98%)

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
similarity index 98%
rename from sound/firewire/oxfw/oxfw-control.c
rename to sound/firewire/oxfw/oxfw-spkr.c
index 02a1cb9..ba766be 100644
--- a/sound/firewire/oxfw/oxfw-control.c
+++ b/sound/firewire/oxfw/oxfw-spkr.c
@@ -1,7 +1,9 @@
 /*
- * oxfw_stream.c - a part of driver for OXFW970/971 based devices
+ * oxfw-spkr.c - a part of driver for OXFW970/971 based devices
  *
  * Copyright (c) Clemens Ladisch <clemens@ladisch.de>
+ * Copyright (c) 2015 Takashi Sakamoto <o-takashi@sakamocchi.jp>
+ *
  * Licensed under the terms of the GNU General Public License, version 2.
  */
 
-- 
2.5.0
