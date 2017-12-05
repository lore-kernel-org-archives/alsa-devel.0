From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] conf/ucm: Rearrange Makefile.am
Date: Tue,  5 Dec 2017 17:46:18 +0100
Message-ID: <20171205164620.6257-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 094D6266D61
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 17:46:26 +0100 (CET)
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
Cc: Hui Wang <hui.wang@canonical.com>, Kailang <kailang@realtek.com>
List-Id: alsa-devel@alsa-project.org

Just rearrange and split to multiple lines to make future patches
cleaner.  No actual code change.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 configure.ac             | 16 ++++++++--------
 src/conf/ucm/Makefile.am | 16 +++++++++++++++-
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index 22d65bb84882..83724e07459c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -691,19 +691,20 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/cards/Makefile \
 	  src/conf/pcm/Makefile \
 	  src/conf/ucm/Makefile \
+	  src/conf/ucm/broadwell-rt286/Makefile \
+	  src/conf/ucm/broxton-rt298/Makefile \
+	  src/conf/ucm/bytcr-rt5651/Makefile \
+	  src/conf/ucm/chtrt5645/Makefile \
 	  src/conf/ucm/DAISY-I2S/Makefile \
+	  src/conf/ucm/DB410c/Makefile \
+	  src/conf/ucm/GoogleNyan/Makefile \
 	  src/conf/ucm/PandaBoard/Makefile \
 	  src/conf/ucm/PandaBoardES/Makefile \
-	  src/conf/ucm/SDP4430/Makefile \
-	  src/conf/ucm/tegraalc5632/Makefile \
 	  src/conf/ucm/PAZ00/Makefile \
-	  src/conf/ucm/GoogleNyan/Makefile \
-	  src/conf/ucm/broadwell-rt286/Makefile \
+	  src/conf/ucm/SDP4430/Makefile \
 	  src/conf/ucm/skylake-rt286/Makefile \
+	  src/conf/ucm/tegraalc5632/Makefile \
 	  src/conf/ucm/VEYRON-I2S/Makefile \
-	  src/conf/ucm/chtrt5645/Makefile \
-	  src/conf/ucm/DB410c/Makefile \
-	  src/conf/ucm/bytcr-rt5651/Makefile \
 	  src/conf/topology/Makefile \
 	  src/conf/topology/broadwell/Makefile \
 	  modules/Makefile modules/mixer/Makefile modules/mixer/simple/Makefile \
@@ -711,7 +712,6 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
 	  src/conf/topology/bxtrt298/Makefile \
 	  alsalisp/Makefile aserver/Makefile \
 	  test/Makefile test/lsb/Makefile \
-	  src/conf/ucm/broxton-rt298/Makefile \
 	  utils/Makefile utils/alsa-lib.spec utils/alsa.pc)
 
 dnl Create asoundlib.h dynamically according to configure options
diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
index 2bd4ebe761ae..060d025f1bb5 100644
--- a/src/conf/ucm/Makefile.am
+++ b/src/conf/ucm/Makefile.am
@@ -1 +1,15 @@
-SUBDIRS=DAISY-I2S PandaBoard PandaBoardES SDP4430 tegraalc5632 PAZ00 GoogleNyan broadwell-rt286 skylake-rt286 VEYRON-I2S chtrt5645 DB410c broxton-rt298 bytcr-rt5651
+SUBDIRS=\
+broadwell-rt286 \
+broxton-rt298 \
+bytcr-rt5651 \
+chtrt5645 \
+DAISY-I2S \
+DB410c \
+GoogleNyan \
+PandaBoard \
+PandaBoardES \
+PAZ00 \
+SDP4430 \
+skylake-rt286 \
+tegraalc5632 \
+VEYRON-I2S
-- 
2.15.0
