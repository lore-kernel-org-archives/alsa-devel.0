From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/5] ALSA: synth: Select snd-emux-synth
	explicitly
Date: Fri,  9 Jun 2017 17:12:51 +0200
Message-ID: <20170609151252.704-5-tiwai@suse.de>
References: <20170609151252.704-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 609D7267666
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 17:12:53 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 87020AE2C
 for <alsa-devel@alsa-project.org>; Fri,  9 Jun 2017 15:12:53 +0000 (UTC)
In-Reply-To: <20170609151252.704-1-tiwai@suse.de>
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

Instead of the non-standard way to enable the build of snd-emux-synth
module inside Makefile, rewrite Kconfig to select the item explicitly
from each driver (sbawe and emu10k1).  This is the standard way.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/Kconfig             | 2 ++
 sound/isa/Kconfig         | 1 +
 sound/pci/Kconfig         | 1 +
 sound/synth/Kconfig       | 2 ++
 sound/synth/emux/Makefile | 4 +---
 5 files changed, 7 insertions(+), 3 deletions(-)
 create mode 100644 sound/synth/Kconfig

diff --git a/sound/Kconfig b/sound/Kconfig
index d2fadbec8d51..d7d2aac9542e 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -110,6 +110,8 @@ source "sound/soc/Kconfig"
 
 source "sound/x86/Kconfig"
 
+source "sound/synth/Kconfig"
+
 endif # SND
 
 menuconfig SOUND_PRIME
diff --git a/sound/isa/Kconfig b/sound/isa/Kconfig
index bf1ab340e2a7..ea8ecc5bb826 100644
--- a/sound/isa/Kconfig
+++ b/sound/isa/Kconfig
@@ -389,6 +389,7 @@ config SND_SBAWE_SEQ
 	def_tristate SND_SEQUENCER && SND_SBAWE
 	select SND_SEQ_MIDI_EMUL
 	select SND_SEQ_VIRMIDI
+	select SND_SYNTH_EMUX
 
 config SND_SB16_CSP
 	bool "Sound Blaster 16/AWE CSP support"
diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index bc7acb489a43..9ac9326f28d6 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -482,6 +482,7 @@ config SND_EMU10K1_SEQ
 	def_tristate SND_SEQUENCER && SND_EMU10K1
 	select SND_SEQ_MIDI_EMUL
 	select SND_SEQ_VIRMIDI
+	select SND_SYNTH_EMUX
 
 config SND_EMU10K1X
 	tristate "Emu10k1X (Dell OEM Version)"
diff --git a/sound/synth/Kconfig b/sound/synth/Kconfig
new file mode 100644
index 000000000000..dfe8950e0556
--- /dev/null
+++ b/sound/synth/Kconfig
@@ -0,0 +1,2 @@
+config SND_SYNTH_EMUX
+	tristate
diff --git a/sound/synth/emux/Makefile b/sound/synth/emux/Makefile
index fb761c2c2b50..4599108452fd 100644
--- a/sound/synth/emux/Makefile
+++ b/sound/synth/emux/Makefile
@@ -8,6 +8,4 @@ snd-emux-synth-objs := emux.o emux_synth.o emux_seq.o emux_nrpn.o \
 snd-emux-synth-$(CONFIG_SND_PROC_FS) += emux_proc.o
 snd-emux-synth-$(CONFIG_SND_SEQUENCER_OSS) += emux_oss.o
 
-# Toplevel Module Dependencies
-obj-$(CONFIG_SND_SBAWE_SEQ) += snd-emux-synth.o
-obj-$(CONFIG_SND_EMU10K1_SEQ) += snd-emux-synth.o
+obj-$(CONFIG_SND_SYNTH_EMUX) += snd-emux-synth.o
-- 
2.13.1
