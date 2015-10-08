From: arun@accosted.net
Subject: [tinycompress] [PATCH] build: Fix make distcheck
Date: Thu,  8 Oct 2015 11:41:28 +0100
Message-ID: <1444300888-30059-1-git-send-email-arun@accosted.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 by alsa0.perex.cz (Postfix) with ESMTP id E0D8F2617BB
 for <alsa-devel@alsa-project.org>; Thu,  8 Oct 2015 12:41:37 +0200 (CEST)
Received: by wicfx3 with SMTP id fx3so18872891wic.0
 for <alsa-devel@alsa-project.org>; Thu, 08 Oct 2015 03:41:37 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Arun Raghavan <git@arunraghavan.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Arun Raghavan <git@arunraghavan.net>

srcdir may not be the same as builddir, so use the correct variable for
the include path.
---
 src/lib/Makefile.am   | 2 +-
 src/utils/Makefile.am | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/lib/Makefile.am b/src/lib/Makefile.am
index 6f900ac..4baeab5 100644
--- a/src/lib/Makefile.am
+++ b/src/lib/Makefile.am
@@ -2,4 +2,4 @@ tinycompressdir = $(libdir)
 
 tinycompress_LTLIBRARIES = libtinycompress.la
 libtinycompress_la_SOURCES = compress.c
-libtinycompress_la_CFLAGS = -I $(top_builddir)/include
+libtinycompress_la_CFLAGS = -I$(top_srcdir)/include
diff --git a/src/utils/Makefile.am b/src/utils/Makefile.am
index 6a89c45..5f685e3 100644
--- a/src/utils/Makefile.am
+++ b/src/utils/Makefile.am
@@ -3,8 +3,8 @@ bin_PROGRAMS = cplay crecord
 cplay_SOURCES = cplay.c
 crecord_SOURCES = crec.c
 
-cplay_CFLAGS = -I$(top_builddir)/include
-crecord_CFLAGS = -I$(top_builddir)/include
+cplay_CFLAGS = -I$(top_srcdir)/include
+crecord_CFLAGS = -I$(top_srcdir)/include
 
 
 cplay_LDADD = $(top_builddir)/src/lib/libtinycompress.la
-- 
2.4.3
