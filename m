From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 13/13] topology: doxygen: Add doxygen support
	for topology core.
Date: Mon, 29 Jun 2015 17:32:58 +0100
Message-ID: <1435595578-6899-13-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1435595578-6899-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id AE9C3265487
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 18:33:33 +0200 (CEST)
In-Reply-To: <1435595578-6899-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
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
