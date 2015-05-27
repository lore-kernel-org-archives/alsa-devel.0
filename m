From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH RESEND v3 1/2] ALSA: Kconfig: add config item SND_PROC_FS for expert
Date: Wed, 27 May 2015 19:45:44 +0800
Message-ID: <1432727145-6504-2-git-send-email-yang.jie@intel.com>
References: <1432727145-6504-1-git-send-email-yang.jie@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432727145-6504-1-git-send-email-yang.jie@intel.com>
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
 sound/core/Kconfig | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 63cc2e9..88e0bc4 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -176,9 +176,18 @@ config SND_SUPPORT_OLD_API
 	  Say Y here to support the obsolete ALSA PCM API (ver.0.9.0 rc3
 	  or older).
 
+config SND_PROC_FS
+        bool "Sound Proc FS Support" if EXPERT
+        depends on PROC_FS
+        default y
+        help
+          Say 'N' to disable Sound proc FS, which may reduce code size about
+          9KB on x86_64 platform.
+          If unsure say Y.
+
 config SND_VERBOSE_PROCFS
 	bool "Verbose procfs contents"
-	depends on PROC_FS
+	depends on SND_PROC_FS
 	default y
 	help
 	  Say Y here to include code for verbose procfs contents (provides
-- 
1.9.1
