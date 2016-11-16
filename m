From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH] crec: Correct name of output binary to crec
Date: Wed, 16 Nov 2016 11:06:45 +0000
Message-ID: <1479294405-17471-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id DBBDF266639
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 12:06:49 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

For some reason when the build system was converted to
automake by this patch

    "Convert the build system to autotools"

the name of the output binary for crec was changed
from 'crec' to 'crecord'.

This patch corrects it back to 'crec'

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 src/utils/Makefile.am | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/utils/Makefile.am b/src/utils/Makefile.am
index 5f685e3..1967d92 100644
--- a/src/utils/Makefile.am
+++ b/src/utils/Makefile.am
@@ -1,11 +1,11 @@
-bin_PROGRAMS = cplay crecord
+bin_PROGRAMS = cplay crec
 
 cplay_SOURCES = cplay.c
-crecord_SOURCES = crec.c
+crec_SOURCES = crec.c
 
 cplay_CFLAGS = -I$(top_srcdir)/include
-crecord_CFLAGS = -I$(top_srcdir)/include
+crec_CFLAGS = -I$(top_srcdir)/include
 
 
 cplay_LDADD = $(top_builddir)/src/lib/libtinycompress.la
-crecord_LDADD = $(top_builddir)/src/lib/libtinycompress.la
+crec_LDADD = $(top_builddir)/src/lib/libtinycompress.la
-- 
2.1.4
