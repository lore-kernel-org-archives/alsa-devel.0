From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: Fix forgotten dependency fix for
	tristate OSS sequencer kconfig
Date: Wed, 28 Jun 2017 08:39:33 +0200
Message-ID: <20170628063933.21442-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 96B62266838
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 08:39:35 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 0E0B1AEC7
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 06:39:35 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In the commit 3d774d5ef066 ("ALSA: seq: Allow the tristate build of
OSS emulation") we changed CONFIG_SND_SEQUENCER_OSS to tristate, but a
couple of places were forgotten, namely, opl3 and emux Makefile.
These contain the line like
  snd-opl3-synth-$(CONFIG_SND_SEQUENCER_OSS) += opl3_oss.o
and this doesn't work any longer as expected because snd-opl3-synth
can be built-in while CONFIG_SND_SEQUENCER_OSS=m.

This patch fixes these places to build properly for the new kconfig
dependency.  In the end, we had to use ifneq() to satisfy the
requirement.  It's a bit ugly, but lesser evil.

Fixes: 3d774d5ef066 ("ALSA: seq: Allow the tristate build of OSS emulation")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/drivers/opl3/Makefile | 4 +++-
 sound/synth/emux/Makefile   | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/opl3/Makefile b/sound/drivers/opl3/Makefile
index 7f2c2a10c4e5..d72b1e7b51c4 100644
--- a/sound/drivers/opl3/Makefile
+++ b/sound/drivers/opl3/Makefile
@@ -5,7 +5,9 @@
 
 snd-opl3-lib-objs := opl3_lib.o opl3_synth.o
 snd-opl3-synth-y := opl3_seq.o opl3_midi.o opl3_drums.o
-snd-opl3-synth-$(CONFIG_SND_SEQUENCER_OSS) += opl3_oss.o
+ifneq ($(CONFIG_SND_SEQUENCER_OSS),)
+snd-opl3-synth-y += opl3_oss.o
+endif
 
 obj-$(CONFIG_SND_OPL3_LIB) += snd-opl3-lib.o
 obj-$(CONFIG_SND_OPL4_LIB) += snd-opl3-lib.o
diff --git a/sound/synth/emux/Makefile b/sound/synth/emux/Makefile
index 4599108452fd..d1bac923eb1b 100644
--- a/sound/synth/emux/Makefile
+++ b/sound/synth/emux/Makefile
@@ -6,6 +6,8 @@
 snd-emux-synth-objs := emux.o emux_synth.o emux_seq.o emux_nrpn.o \
 		       emux_effect.o emux_hwdep.o soundfont.o
 snd-emux-synth-$(CONFIG_SND_PROC_FS) += emux_proc.o
-snd-emux-synth-$(CONFIG_SND_SEQUENCER_OSS) += emux_oss.o
+ifneq ($(CONFIG_SND_SEQUENCER_OSS),)
+snd-emux-synth-y += emux_oss.o
+endif
 
 obj-$(CONFIG_SND_SYNTH_EMUX) += snd-emux-synth.o
-- 
2.13.2
