From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix makefile sequencer macros
Date: Fri, 31 Jan 2003 09:09:07 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0301310854001.20037-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


It seems my make doesn't like the 'sequencer' macros:
- When using :=, the right hand side is evaluated immediately instead of
  when the function is called. This means $(1) is empty.
- The CONFIG_SND_module macros are defined as 'n', and not empty as
  expected by the function.
- isa/sb/Makefile has $(if $(1)). This seems to by a typo.

The patch below works for me, but I didn't test all combinations of
y/m/n/empty for the symbols used.


Index: alsa-kernel/core/seq/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/seq/Makefile,v
retrieving revision 1.28
diff -u -r1.28 Makefile
--- alsa-kernel/core/seq/Makefile	30 Jan 2003 16:33:16 -0000	1.28
+++ alsa-kernel/core/seq/Makefile	31 Jan 2003 07:51:45 -0000
@@ -31,7 +31,7 @@
 #   <empty string> - CONFIG_SND_SEQUENCER is undefined
 #   otherwise parameter #1 value
 #
-sequencer := $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(1),m),$(if $(CONFIG_SND_SEQUENCER),$(1)))
+sequencer = $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(subst n,,$(1)),m),$(if $(CONFIG_SND_SEQUENCER),$(1)))

 obj-$(CONFIG_SND_SEQUENCER) += snd-seq.o snd-seq-device.o
 ifeq ($(CONFIG_SND_SEQUENCER_OSS),y)
Index: alsa-kernel/core/seq/instr/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/seq/instr/Makefile,v
retrieving revision 1.13
diff -u -r1.13 Makefile
--- alsa-kernel/core/seq/instr/Makefile	30 Jan 2003 16:33:17 -0000	1.13
+++ alsa-kernel/core/seq/instr/Makefile	31 Jan 2003 07:51:46 -0000
@@ -16,7 +16,7 @@
 #   <empty string> - CONFIG_SND_SEQUENCER is undefined
 #   otherwise parameter #1 value
 #
-sequencer := $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(1),m),$(if $(CONFIG_SND_SEQUENCER),$(1)))
+sequencer = $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(subst n,,$(1)),m),$(if $(CONFIG_SND_SEQUENCER),$(1)))

 # Toplevel Module Dependency
 obj-$(call sequencer,$(CONFIG_SND_ALS100)) += snd-ainstr-fm.o
Index: alsa-kernel/isa/gus/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/gus/Makefile,v
retrieving revision 1.9
diff -u -r1.9 Makefile
--- alsa-kernel/isa/gus/Makefile	30 Jan 2003 16:33:17 -0000	1.9
+++ alsa-kernel/isa/gus/Makefile	31 Jan 2003 07:51:46 -0000
@@ -25,7 +25,7 @@
 #   <empty string> - CONFIG_SND_SEQUENCER is undefined
 #   otherwise parameter #1 value
 #
-sequencer := $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(1),m),$(if $(CONFIG_SND_SEQUENCER),$(1)))
+sequencer = $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(subst n,,$(1)),m),$(if $(CONFIG_SND_SEQUENCER),$(1)))

 # Toplevel Module Dependency
 obj-$(CONFIG_SND_GUSCLASSIC) += snd-gusclassic.o snd-gus-lib.o
Index: alsa-kernel/isa/sb/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/sb/Makefile,v
retrieving revision 1.14
diff -u -r1.14 Makefile
--- alsa-kernel/isa/sb/Makefile	30 Jan 2003 16:33:23 -0000	1.14
+++ alsa-kernel/isa/sb/Makefile	31 Jan 2003 07:51:46 -0000
@@ -21,7 +21,7 @@
 #   <empty string> - CONFIG_SND_SEQUENCER is undefined
 #   otherwise parameter #1 value
 #
-sequencer := $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(1)),$(if $(CONFIG_SND_SEQUENCER),$(1)))
+sequencer = $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(subst n,,$(1)),m),$(if $(CONFIG_SND_SEQUENCER),$(1)))

 # Toplevel Module Dependency
 obj-$(CONFIG_SND_ALS100) += snd-sb16-dsp.o snd-sb-common.o
Index: alsa-kernel/pci/emu10k1/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/Makefile,v
retrieving revision 1.8
diff -u -r1.8 Makefile
--- alsa-kernel/pci/emu10k1/Makefile	30 Jan 2003 16:33:24 -0000	1.8
+++ alsa-kernel/pci/emu10k1/Makefile	31 Jan 2003 07:51:46 -0000
@@ -16,7 +16,7 @@
 #   <empty string> - CONFIG_SND_SEQUENCER is undefined
 #   otherwise parameter #1 value
 #
-sequencer := $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(1),m),$(if $(CONFIG_SND_SEQUENCER),$(1)))
+sequencer = $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(subst n,,$(1)),m),$(if $(CONFIG_SND_SEQUENCER),$(1)))

 # Toplevel Module Dependency
 obj-$(CONFIG_SND_EMU10K1) += snd-emu10k1.o
Index: alsa-kernel/pci/trident/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/trident/Makefile,v
retrieving revision 1.7
diff -u -r1.7 Makefile
--- alsa-kernel/pci/trident/Makefile	30 Jan 2003 16:33:24 -0000	1.7
+++ alsa-kernel/pci/trident/Makefile	31 Jan 2003 07:51:46 -0000
@@ -14,7 +14,7 @@
 #   <empty string> - CONFIG_SND_SEQUENCER is undefined
 #   otherwise parameter #1 value
 #
-sequencer := $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(1),m),$(if $(CONFIG_SND_SEQUENCER),$(1)))
+sequencer = $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(subst n,,$(1)),m),$(if $(CONFIG_SND_SEQUENCER),$(1)))

 # Toplevel Module Dependency
 obj-$(CONFIG_SND_TRIDENT) += snd-trident.o
Index: alsa-kernel/synth/emux/Makefile
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/synth/emux/Makefile,v
retrieving revision 1.10
diff -u -r1.10 Makefile
--- alsa-kernel/synth/emux/Makefile	30 Jan 2003 16:33:25 -0000	1.10
+++ alsa-kernel/synth/emux/Makefile	31 Jan 2003 07:51:46 -0000
@@ -15,7 +15,7 @@
 #   <empty string> - CONFIG_SND_SEQUENCER is undefined
 #   otherwise parameter #1 value
 #
-sequencer := $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(1),m),$(if $(CONFIG_SND_SEQUENCER),$(1)))
+sequencer = $(if $(subst y,,$(CONFIG_SND_SEQUENCER)),$(if $(subst n,,$(1)),m),$(if $(CONFIG_SND_SEQUENCER),$(1)))

 # Toplevel Module Dependencies
 obj-$(call sequencer,$(CONFIG_SND_SBAWE)) += snd-emux-synth.o



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
