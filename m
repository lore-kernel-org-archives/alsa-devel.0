From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH 1/2] ALSA: Kconfig: add config menu for reduced
	memory footprint
Date: Tue, 26 May 2015 19:04:24 +0800
Message-ID: <1432638265-16646-2-git-send-email-yang.jie@intel.com>
References: <1432638265-16646-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 0283226512A
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 13:00:46 +0200 (CEST)
In-Reply-To: <1432638265-16646-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, broonie@kernel.org
Cc: vivian.zhang@intel.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

For some embedded devices, we need reduce code size and data
footprint as much as possible, e.g. disabling procfs, hw/sw
params refinement, mmap, dpcm, dapm, compressed API...

Here add root config menu for those configuration, and
disable procfs once reduced memory footprint is selected.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 sound/Kconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/Kconfig b/sound/Kconfig
index 5a240e0..6760dfa 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -68,6 +68,22 @@ menuconfig SND
 
 if SND
 
+menuconfig SND_REDUCED_MEMORY_FOOTPRINT
+	bool "Reduced Memory Footprint Support"
+	default n
+	help
+	  Say 'Y' to enable Reduced Memory Footprint Support, which may
+	  reduce code size and data footprint as much as possible.
+
+config SND_PROC_FS
+	bool "Sound Proc FS Support"
+	depends on PROC_FS && !SND_REDUCED_MEMORY_FOOTPRINT
+	default y
+	help
+	  Say 'N' to disable Sound proc FS, which may reduce code size about
+	  9KB on x86_64 platform.
+	  If unsure say Y.
+
 source "sound/core/Kconfig"
 
 source "sound/drivers/Kconfig"
-- 
1.9.1
