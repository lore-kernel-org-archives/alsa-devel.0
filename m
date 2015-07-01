From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 13/13] topology: doxygen: Add doxygen
	support for topology core.
Date: Wed,  1 Jul 2015 14:44:35 +0100
Message-ID: <1435758275-4047-13-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1435758275-4047-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 986E126071E
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2015 15:46:02 +0200 (CEST)
In-Reply-To: <1435758275-4047-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 doc/doxygen.cfg.in | 7 +++++--
 doc/index.doxygen  | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/doc/doxygen.cfg.in b/doc/doxygen.cfg.in
index 043e75b..92bd52b 100644
--- a/doc/doxygen.cfg.in
+++ b/doc/doxygen.cfg.in
@@ -29,6 +29,7 @@ INPUT            = @top_srcdir@/doc/index.doxygen \
 		   @top_srcdir@/include/control_external.h \
 		   @top_srcdir@/include/mixer.h \
 		   @top_srcdir@/include/use-case.h \
+		   @top_srcdir@/include/topology.h \
 		   @top_srcdir@/src/error.c \
 		   @top_srcdir@/src/dlmisc.c \
 		   @top_srcdir@/src/async.c \
@@ -78,7 +79,8 @@ INPUT            = @top_srcdir@/doc/index.doxygen \
 		   @top_srcdir@/src/timer \
 		   @top_srcdir@/src/hwdep \
 		   @top_srcdir@/src/seq \
-		   @top_srcdir@/src/ucm
+		   @top_srcdir@/src/ucm \
+		   @top_srcdir@/src/topology
 EXCLUDE		 = @top_srcdir@/src/control/control_local.h \
 		   @top_srcdir@/src/pcm/atomic.h \
 		   @top_srcdir@/src/pcm/interval.h \
@@ -94,7 +96,8 @@ EXCLUDE		 = @top_srcdir@/src/control/control_local.h \
 		   @top_srcdir@/src/mixer/mixer_local.h \
 		   @top_srcdir@/src/rawmidi/rawmidi_local.h \
 		   @top_srcdir@/src/seq/seq_local.h \
-		   @top_srcdir@/src/ucm/ucm_local.h
+		   @top_srcdir@/src/ucm/ucm_local.h \
+		   @top_srcdir@/src/topology/tplg_local.h
 RECURSIVE	 = YES
 FILE_PATTERNS    = *.c *.h
 EXAMPLE_PATH     = @top_srcdir@/test
diff --git a/doc/index.doxygen b/doc/index.doxygen
index 7d049fe..b40c75a 100644
--- a/doc/index.doxygen
+++ b/doc/index.doxygen
@@ -41,6 +41,7 @@ may be placed in the library code instead of the kernel driver.</P>
   <LI>Page \ref timer explains the design of the Timer API.
   <LI>Page \ref seq explains the design of the Sequencer API.
   <LI>Page \ref ucm explains the use case API.
+  <LI>Page \ref topology explains the DSP topology API.
 </UL>
 
 <H2>Configuration</H2>
-- 
2.1.4
