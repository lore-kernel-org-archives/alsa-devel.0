From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 1/3] ucm: docs: fix doxygen exclude patch for
	UCM local header
Date: Mon, 29 Jun 2015 16:25:57 +0100
Message-ID: <1435591559-6277-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3668B2612CD
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 17:26:12 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 doc/doxygen.cfg.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/doxygen.cfg.in b/doc/doxygen.cfg.in
index f4499d6..043e75b 100644
--- a/doc/doxygen.cfg.in
+++ b/doc/doxygen.cfg.in
@@ -94,7 +94,7 @@ EXCLUDE		 = @top_srcdir@/src/control/control_local.h \
 		   @top_srcdir@/src/mixer/mixer_local.h \
 		   @top_srcdir@/src/rawmidi/rawmidi_local.h \
 		   @top_srcdir@/src/seq/seq_local.h \
-		   @top_srcdir@/src/seq/ucm_local.h
+		   @top_srcdir@/src/ucm/ucm_local.h
 RECURSIVE	 = YES
 FILE_PATTERNS    = *.c *.h
 EXAMPLE_PATH     = @top_srcdir@/test
-- 
2.1.4
