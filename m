From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH] ALSA: fireworks/bebob/oxfw/dice: enable to
	make as built-in
Date: Sun, 18 Oct 2015 13:46:47 +0900
Message-ID: <1445143608-23297-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CDF2261480
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 06:46:53 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

When committed to upstream, these four modules had wrong entries for
Makefile. This forces them to be loadable modules even if they're set
as built-in.

This commit fixes this bug.

Fixes: b5b04336015e('ALSA: fireworks: Add skelton for Fireworks based devices')
Fixes: fd6f4b0dc167('ALSA: bebob: Add skelton for BeBoB based devices')
Fixes: 1a4e39c2e5ca('ALSA: oxfw: Move to its own directory')
Fixes: 14ff6a094815('ALSA: dice: Move file to its own directory')
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/Makefile     | 2 +-
 sound/firewire/dice/Makefile      | 2 +-
 sound/firewire/fireworks/Makefile | 2 +-
 sound/firewire/oxfw/Makefile      | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/bebob/Makefile b/sound/firewire/bebob/Makefile
index 6cf470c..af7ed66 100644
--- a/sound/firewire/bebob/Makefile
+++ b/sound/firewire/bebob/Makefile
@@ -1,4 +1,4 @@
 snd-bebob-objs := bebob_command.o bebob_stream.o bebob_proc.o bebob_midi.o \
 		  bebob_pcm.o bebob_hwdep.o bebob_terratec.o bebob_yamaha.o \
 		  bebob_focusrite.o bebob_maudio.o bebob.o
-obj-m += snd-bebob.o
+obj-$(CONFIG_SND_BEBOB) += snd-bebob.o
diff --git a/sound/firewire/dice/Makefile b/sound/firewire/dice/Makefile
index 9ef228e..55b4be9 100644
--- a/sound/firewire/dice/Makefile
+++ b/sound/firewire/dice/Makefile
@@ -1,3 +1,3 @@
 snd-dice-objs := dice-transaction.o dice-stream.o dice-proc.o dice-midi.o \
 		 dice-pcm.o dice-hwdep.o dice.o
-obj-m += snd-dice.o
+obj-$(CONFIG_SND_DICE) += snd-dice.o
diff --git a/sound/firewire/fireworks/Makefile b/sound/firewire/fireworks/Makefile
index 0c74408..15ef7f7 100644
--- a/sound/firewire/fireworks/Makefile
+++ b/sound/firewire/fireworks/Makefile
@@ -1,4 +1,4 @@
 snd-fireworks-objs := fireworks_transaction.o fireworks_command.o \
 		      fireworks_stream.o fireworks_proc.o fireworks_midi.o \
 		      fireworks_pcm.o fireworks_hwdep.o fireworks.o
-obj-m += snd-fireworks.o
+obj-$(CONFIG_SND_FIREWORKS) += snd-fireworks.o
diff --git a/sound/firewire/oxfw/Makefile b/sound/firewire/oxfw/Makefile
index a926850..06ff50f 100644
--- a/sound/firewire/oxfw/Makefile
+++ b/sound/firewire/oxfw/Makefile
@@ -1,3 +1,3 @@
 snd-oxfw-objs := oxfw-command.o oxfw-stream.o oxfw-control.o oxfw-pcm.o \
 		 oxfw-proc.o oxfw-midi.o oxfw-hwdep.o oxfw.o
-obj-m += snd-oxfw.o
+obj-$(CONFIG_SND_OXFW) += snd-oxfw.o
-- 
2.1.4
