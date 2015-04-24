From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 05/21] ALSA: hda - Merge codec and controller
	helpers
Date: Fri, 24 Apr 2015 14:38:37 +0200
Message-ID: <1429879133-32293-6-git-send-email-tiwai@suse.de>
References: <1429879133-32293-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2FEF62605A3
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 14:39:01 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 68E88AD32
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 12:39:00 +0000 (UTC)
In-Reply-To: <1429879133-32293-1-git-send-email-tiwai@suse.de>
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

There is no much merit to keep the HD-audio codec and controller
helper codes in separate modules any longer.  Let's merge them into a
single helper module.

This patch just changes Makefile entries to merge two individual
modules to one.  The only code change is the removal of superfluous
MODULE_*() macros in one side.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/Makefile         | 3 +--
 sound/pci/hda/hda_controller.c | 3 ---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index af78fb33a4fd..c5e6651efb49 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -1,10 +1,10 @@
 snd-hda-intel-objs := hda_intel.o
-snd-hda-controller-objs := hda_controller.o
 snd-hda-tegra-objs := hda_tegra.o
 # for haswell power well
 snd-hda-intel-$(CONFIG_SND_HDA_I915) +=	hda_i915.o
 
 snd-hda-codec-y := hda_bind.o hda_codec.o hda_jack.o hda_auto_parser.o hda_sysfs.o
+snd-hda-codec-y += hda_controller.o
 snd-hda-codec-$(CONFIG_PROC_FS) += hda_proc.o
 snd-hda-codec-$(CONFIG_SND_HDA_HWDEP) += hda_hwdep.o
 snd-hda-codec-$(CONFIG_SND_HDA_INPUT_BEEP) += hda_beep.o
@@ -27,7 +27,6 @@ snd-hda-codec-hdmi-objs :=	patch_hdmi.o hda_eld.o
 
 # common driver
 obj-$(CONFIG_SND_HDA) := snd-hda-codec.o
-obj-$(CONFIG_SND_HDA) += snd-hda-controller.o
 
 # codec drivers
 obj-$(CONFIG_SND_HDA_GENERIC) += snd-hda-codec-generic.o
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index b4474e27631d..6b39f2e8c820 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -1966,6 +1966,3 @@ int azx_init_stream(struct azx *chip)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(azx_init_stream);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Common HDA driver functions");
-- 
2.3.5
