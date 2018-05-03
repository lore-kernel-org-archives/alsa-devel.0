From: Xiuli Pan <xiuli.pan@linux.intel.com>
Subject: [PATCH] conf/ucm: Fix build error for UCM Dell WD15
	Dock USB-audio
Date: Thu,  3 May 2018 13:20:36 +0800
Message-ID: <1525324836-7072-1-git-send-email-xiuli.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 831DB266EBE
 for <alsa-devel@alsa-project.org>; Thu,  3 May 2018 07:20:51 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Pan Xiuli <xiuli.pan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Pan Xiuli <xiuli.pan@linux.intel.com>

Miss oneline in configure.ac in provious patch
conf/ucm: Add a UCM profile for Dell WD15 Dock USB-audio

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pan Xiuli <xiuli.pan@linux.intel.com>
---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index 3ee989e..693b5d5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -725,6 +725,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/ucm/chtrt5645-mono-speaker-analog-mic/Makefile \
 	  src/conf/ucm/DAISY-I2S/Makefile \
 	  src/conf/ucm/DB410c/Makefile \
+	  src/conf/ucm/Dell-WD15-Dock/Makefile \
 	  src/conf/ucm/GoogleNyan/Makefile \
 	  src/conf/ucm/gpd-win-pocket-rt5645/Makefile \
 	  src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/Makefile \
-- 
2.7.4
