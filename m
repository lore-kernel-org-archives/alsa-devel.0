From: Vikram Narayanan <vikram186@gmail.com>
Subject: [PATCH] Trivial fixes in INSTALL file
Date: Sat, 11 Feb 2012 13:47:48 +0530
Message-ID: <4F36242C.4010409@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Changed from HG->git in the INSTALL file

Signed-off-by: Vikram Narayanan <vikram186@gmail.com>
---
diff --git a/INSTALL b/INSTALL
index 202c491..544d5d2 100644
--- a/INSTALL
+++ b/INSTALL
@@ -24,11 +24,11 @@ package. The configure script from alsa-utils package probably cannot find
 header file asoundlib.h in $prefix/include/alsa directory (usually in
 /usr/include/alsa directory).
 
-Compilation from HG sources
+Compilation from git sources
 ---------------------------
 
 You need also GNU packages autoconf and automake installed in your system
-to compile HG (Mercurial) sources of alsa-utils package.
+to compile git sources of alsa-utils package.
 
 For compilation you can use these commands:
 
@@ -40,7 +40,7 @@ For compilation you can use these commands:
 	./configure
 	make
 
-The included hgcompile script does this job for you.
+The included gitcompile script does this job for you.
 
 Note: Some automake packages have missing aclocal program. Use newer version
       in the case.
-- 
1.7.4.1
