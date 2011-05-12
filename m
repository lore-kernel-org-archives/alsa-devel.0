From: Alexander Stein <a.stein@systec-electronic.com>
Subject: [PATCH] Always link to libm
Date: Thu, 12 May 2011 14:39:53 +0200
Message-ID: <1305203993-6878-1-git-send-email-a.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webbox687.server-home.net (webbox687.server-home.net
	[195.149.74.151])
	by alsa0.perex.cz (Postfix) with ESMTP id E6E971039CA
	for <alsa-devel@alsa-project.org>;
	Thu, 12 May 2011 14:40:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Alexander Stein <alexander.stein@systec-electronic.com>
List-Id: alsa-devel@alsa-project.org

From: Alexander Stein <alexander.stein@systec-electronic.com>

Starting with commit 9b6df1cf64ea7ccb329b4922d138c1f36ace00c0
  control: add ASCII parsers from amixer
ctlparse.c uses ceil() and so libm is need unrelated to soft- or hardfloat.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 configure.in |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/configure.in b/configure.in
index 7ee0ccc..687e5eb 100644
--- a/configure.in
+++ b/configure.in
@@ -228,10 +228,7 @@ else
   AC_MSG_RESULT(no)
 fi
 
-ALSA_DEPLIBS=""
-if test "$softfloat" != "yes"; then
-  ALSA_DEPLIBS="-lm"
-fi
+ALSA_DEPLIBS="-lm"
 
 dnl Check for libdl
 AC_MSG_CHECKING(for libdl)
-- 
1.7.3.4
