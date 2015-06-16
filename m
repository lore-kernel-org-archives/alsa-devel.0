From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] ALSA: HDAC: move SND_HDA_PREALLOC_SIZE to core
Date: Tue, 16 Jun 2015 21:00:22 +0530
Message-ID: <1434468622-26918-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id BBDC426585A
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 17:28:52 +0200 (CEST)
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Since this is common option for HDA driver to specfiy pre-allocated
buffer, we should make this option availble to all HDA driver by
moving this to HDA core

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/hda/Kconfig     | 13 +++++++++++++
 sound/pci/hda/Kconfig | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/hda/Kconfig b/sound/hda/Kconfig
index 6dc3914fd28b..3129546398d0 100644
--- a/sound/hda/Kconfig
+++ b/sound/hda/Kconfig
@@ -14,3 +14,16 @@ config SND_HDA_I915
 config SND_HDA_EXT_CORE
        tristate
        select SND_HDA_CORE
+
+config SND_HDA_PREALLOC_SIZE
+	int "Pre-allocated buffer size for HD-audio driver"
+	range 0 32768
+	default 64
+	help
+	  Specifies the default pre-allocated buffer-size in kB for the
+	  HD-audio driver.  A larger buffer (e.g. 2048) is preferred
+	  for systems using PulseAudio.  The default 64 is chosen just
+	  for compatibility reasons.
+
+	  Note that the pre-allocation size can be changed dynamically
+	  via a proc file (/proc/asound/card*/pcm*/sub*/prealloc), too.
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 98ced971cb43..e94cfd5c69f7 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -38,19 +38,6 @@ config SND_HDA_TEGRA
 
 if SND_HDA
 
-config SND_HDA_PREALLOC_SIZE
-	int "Pre-allocated buffer size for HD-audio driver"
-	range 0 32768
-	default 64
-	help
-	  Specifies the default pre-allocated buffer-size in kB for the
-	  HD-audio driver.  A larger buffer (e.g. 2048) is preferred
-	  for systems using PulseAudio.  The default 64 is chosen just
-	  for compatibility reasons.
-
-	  Note that the pre-allocation size can be changed dynamically
-	  via a proc file (/proc/asound/card*/pcm*/sub*/prealloc), too.
-
 config SND_HDA_HWDEP
 	bool "Build hwdep interface for HD-audio driver"
 	select SND_HWDEP
-- 
1.9.1
