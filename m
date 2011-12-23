From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: [PATCH v5 6/6] core: add makefile and kconfig file for
	compress
Date: Fri, 23 Dec 2011 10:36:40 +0530
Message-ID: <1324616800-19749-7-git-send-email-vinod.koul@linux.intel.com>
References: <1323070791-12620-1-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id AF562103FB5
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 06:07:00 +0100 (CET)
In-Reply-To: <1323070791-12620-1-git-send-email-vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@linux.intel.com>, broonie@opensource.wolfsonmicro.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/core/Kconfig  |   10 ++++++++++
 sound/core/Makefile |    4 ++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/sound/core/Kconfig b/sound/core/Kconfig
index 475455c..2dc7776 100644
--- a/sound/core/Kconfig
+++ b/sound/core/Kconfig
@@ -155,6 +155,16 @@ config SND_DYNAMIC_MINORS
 
 	  If you are unsure about this, say N here.
 
+config SND_COMPRESS_OFFLOAD
+	tristate "ALSA Compressed audio offload support"
+	default n
+	help
+	  If you want support for offloading compressed audio and have such
+	  a hardware, then you should say Y here and also to the DSP driver
+	  of your platform.
+
+	  If you are unsure about this, say N here.
+
 config SND_SUPPORT_OLD_API
 	bool "Support old ALSA API"
 	default y
diff --git a/sound/core/Makefile b/sound/core/Makefile
index 350a08d..67c8e93 100644
--- a/sound/core/Makefile
+++ b/sound/core/Makefile
@@ -21,6 +21,8 @@ snd-hrtimer-objs  := hrtimer.o
 snd-rtctimer-objs := rtctimer.o
 snd-hwdep-objs    := hwdep.o
 
+snd-compress-objs := compress_offload.o
+
 obj-$(CONFIG_SND) 		+= snd.o
 obj-$(CONFIG_SND_HWDEP)		+= snd-hwdep.o
 obj-$(CONFIG_SND_TIMER)		+= snd-timer.o
@@ -31,3 +33,5 @@ obj-$(CONFIG_SND_RAWMIDI)	+= snd-rawmidi.o
 
 obj-$(CONFIG_SND_OSSEMUL)	+= oss/
 obj-$(CONFIG_SND_SEQUENCER)	+= seq/
+
+obj-$(CONFIG_SND_COMPRESS_OFFLOAD)	+= snd-compress.o
-- 
1.7.0.4
