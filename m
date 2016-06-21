From: Henrik Austad <henrik@austad.us>
Subject: [PATCH] INSTALL: update text and drop reference to Hg
Date: Tue, 21 Jun 2016 14:19:26 +0200
Message-ID: <1466511566-2942-1-git-send-email-henrik@austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: Henrik Austad <henrik@austad.us>
List-Id: alsa-devel@alsa-project.org

This is really just nitpick, but it annoyed me for a few seconds, so I thought
I'd just fix it.

In d7534b2ceec7 (hgcompile -> gitcompile) the filename was updated but
INSTALL was not, leaving outdated docs.

Signed-off-by: Henrik Austad <henrik@austad.us>
---
 INSTALL | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/INSTALL b/INSTALL
index 47086e3..64f3d09 100644
--- a/INSTALL
+++ b/INSTALL
@@ -11,13 +11,19 @@ For installation you can use these commands:
 	make install
 
 
-Compilation from HG sources
+Compilation from Git-sources
 ---------------------------
 
-You need also GNU packages automake and libtool installed in your system
-to compile HG (Mercurial) sources of alsa-lib package.
+Requirements:
+	* automake
+	* libtool
 
-For compilation you can use these commands:
+To compile alsa-lib from source:
+
+	./gitcompile
+
+If you do not want to use the supplied gitcompile-script, you can
+compile alsa-lib manually by using these steps:
 
 	libtoolize --force --copy --automake
 	aclocal
@@ -27,7 +33,6 @@ For compilation you can use these commands:
 	./configure
 	make
 
-The included hgcompile script does this job for you.
 
 Note: Some automake packages have missing aclocal program. Use newer version
       in the case.
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
