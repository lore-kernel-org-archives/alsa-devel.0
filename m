From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH v3 1/2] ALSA: Kconfig: add config item SND_PROC_FS for expert
Date: Wed, 27 May 2015 17:10:17 +0800
Message-ID: <1432717818-4685-2-git-send-email-yang.jie@intel.com>
References: <1432717818-4685-1-git-send-email-yang.jie@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432717818-4685-1-git-send-email-yang.jie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com, yang.jie@intel.com, vivian.zhang@intel.com
List-Id: alsa-devel@alsa-project.org

For some embedded devices, we need reduce code size and data
footprint as much as possible, e.g. disabling procfs, hw/sw
params refinement, mmap, dpcm, dapm, compressed API...

Here add SND_PROC_FS item for expert, we can unselect it to
disable sound proc FS and reduce memory footprint.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/core/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 63cc2e9..4542554 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -225,4 +225,13 @@ config SND_DMA_SGBUF
 	def_bool y
 	depends on X86
 
+config SND_PROC_FS
+        bool "Sound Proc FS Support" if EXPERT
+        depends on PROC_FS
+        default y
+        help
+          Say 'N' to disable Sound proc FS, which may reduce code size about
+          9KB on x86_64 platform.
+          If unsure say Y.
+
 source "sound/core/seq/Kconfig"
-- 
1.9.1
