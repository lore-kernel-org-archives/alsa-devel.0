From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: [PATCH 3/3] ASoC: mid-x86 - remove the flag in makefile
Date: Fri,  7 Jan 2011 16:21:12 +0530
Message-ID: <1294397472-8792-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id C16262435F
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 11:49:09 +0100 (CET)
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
Cc: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, Vinod Koul <vinod.koul@intel.com>, Harsha Priya <priya.harsha@intel.com>, lrg@slimlogic.co.uk, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

From: Vinod Koul <vinod.koul@intel.com>

previous commit e62255f2adf2 introduced DDEBUG flag in Makefile
This causes all debug statemenets to be ON.

This patch removes this flag

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Harsha Priya <priya.harsha@intel.com>
---
 sound/soc/mid-x86/Makefile |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mid-x86/Makefile b/sound/soc/mid-x86/Makefile
index a1a9331..6398833 100644
--- a/sound/soc/mid-x86/Makefile
+++ b/sound/soc/mid-x86/Makefile
@@ -1,5 +1,3 @@
-EXTRA_CFLAGS += -DDEBUG
-
 snd-soc-sst-platform-objs := sst_platform.o
 snd-soc-mfld-machine-objs := mfld_machine.o
 
-- 
1.7.2.3
