From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [TINYCOMPRESS][v2 PATCH 6/7] src/lib/utils.c: remove
	this empty file
Date: Tue, 24 Mar 2015 10:32:33 +0000
Message-ID: <1427193154-6753-7-git-send-email-qais.yousef@imgtec.com>
References: <1427193154-6753-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 082F8260462
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 11:32:45 +0100 (CET)
In-Reply-To: <1427193154-6753-1-git-send-email-qais.yousef@imgtec.com>
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
Cc: alsa-devel@alsa-project.org, Qais Yousef <qais.yousef@imgtec.com>
List-Id: alsa-devel@alsa-project.org

utils.c isn't implementing anything so delete it
---
 Android.mk          |  2 +-
 src/lib/Makefile.am |  2 +-
 src/lib/utils.c     | 62 -----------------------------------------------------
 3 files changed, 2 insertions(+), 64 deletions(-)
 delete mode 100644 src/lib/utils.c

diff --git a/Android.mk b/Android.mk
index 14878cccc805..d201cfa1abff 100644
--- a/Android.mk
+++ b/Android.mk
@@ -2,7 +2,7 @@ LOCAL_PATH:= $(call my-dir)
 
 include $(CLEAR_VARS)
 LOCAL_C_INCLUDES:= $(LOCAL_PATH)/include
-LOCAL_SRC_FILES:= src/lib/compress.c src/lib/utils.c
+LOCAL_SRC_FILES:= src/lib/compress.c
 LOCAL_MODULE := libtinycompress
 LOCAL_SHARED_LIBRARIES:= libcutils libutils
 LOCAL_MODULE_TAGS := optional
diff --git a/src/lib/Makefile.am b/src/lib/Makefile.am
index 01afb8a443a1..6f900ac98a27 100644
--- a/src/lib/Makefile.am
+++ b/src/lib/Makefile.am
@@ -1,5 +1,5 @@
 tinycompressdir = $(libdir)
 
 tinycompress_LTLIBRARIES = libtinycompress.la
-libtinycompress_la_SOURCES = compress.c utils.c
+libtinycompress_la_SOURCES = compress.c
 libtinycompress_la_CFLAGS = -I $(top_builddir)/include
diff --git a/src/lib/utils.c b/src/lib/utils.c
deleted file mode 100644
index 9a0f86a3160a..000000000000
--- a/src/lib/utils.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * BSD LICENSE
- *
- * tinycompress utility functions
- * Copyright (c) 2011-2013, Intel Corporation
- * All rights reserved.
- *
- * Author: Vinod Koul <vinod.koul@intel.com>
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions are met:
- *
- * Redistributions of source code must retain the above copyright notice,
- * this list of conditions and the following disclaimer.
- * Redistributions in binary form must reproduce the above copyright notice,
- * this list of conditions and the following disclaimer in the documentation
- * and/or other materials provided with the distribution.
- * Neither the name of Intel Corporation nor the names of its contributors
- * may be used to endorse or promote products derived from this software
- * without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
- * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
- * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
- * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
- * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
- * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
- * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
- * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
- * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
- * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
- * THE POSSIBILITY OF SUCH DAMAGE.
- *
- * LGPL LICENSE
- *
- * tinycompress utility functions
- * Copyright (c) 2011-2013, Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU Lesser General Public License,
- * version 2.1, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
- * License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public License
- * along with this program; if not, write to
- * the Free Software Foundation, Inc.,
- * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
- */
-#include <stdio.h>
-#include <stdlib.h>
-#include <stdbool.h>
-#include <linux/types.h>
-#include <sys/time.h>
-#define __force
-#define __bitwise
-#define __user
-#include "tinycompress/tinycompress.h"
-
-- 
2.1.0
