From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH] tinycompress: INSTALL: Update the instructions
Date: Thu, 10 Mar 2016 13:43:37 +0530
Message-ID: <1457597617-13737-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id DB2BA2606AB
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 09:09:48 +0100 (CET)
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, pathes.audio@intel.com, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 INSTALL | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/INSTALL b/INSTALL
index 2099840756e6..5ac7670b0a7c 100644
--- a/INSTALL
+++ b/INSTALL
@@ -1,5 +1,34 @@
-Installation Instructions
-*************************
+
+		Tinycompress Installation Instructions
+		**************************************
+
+Install from tarball
+====================
+
+For installation you can use these commands:
+
+	./configure
+	make install
+
+
+Compilation from Git
+====================
+
+gitcompile script allows to build and then install
+
+	./gitcompile
+	make install
+
+
+Compilation for Android
+=======================
+
+Android makefile Android.mk is inculded in this project and should be
+packaged into Android build system
+
+
+Configure help
+==============
 
 Copyright (C) 1994-1996, 1999-2002, 2004-2013 Free Software Foundation,
 Inc.
-- 
1.9.1
