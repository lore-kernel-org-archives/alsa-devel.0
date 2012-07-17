From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: [alsa-lib] [PATCH 4/4] build: Disable another compile
	chack with --disable-alsatest
Date: Tue, 17 Jul 2012 15:30:17 +0530
Message-ID: <1342519217-3668-5-git-send-email-arun.raghavan@collabora.co.uk>
References: <1342519217-3668-1-git-send-email-arun.raghavan@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B37B264FB5
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 12:02:08 +0200 (CEST)
In-Reply-To: <1342519217-3668-1-git-send-email-arun.raghavan@collabora.co.uk>
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
Cc: Arun Raghavan <arun.raghavan@collabora.co.uk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Arun Raghavan <arun.raghavan@collabora.co.uk>
---
 utils/alsa.m4 |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/utils/alsa.m4 b/utils/alsa.m4
index 79a24ef..e12310d 100644
--- a/utils/alsa.m4
+++ b/utils/alsa.m4
@@ -57,6 +57,7 @@ LIBS="$ALSA_LIBS $LIBS"
 AC_MSG_RESULT($ALSA_LIBS)
 
 dnl Check for a working version of libasound that is of the right version.
+if test "x$enable_alsatest" = "xyes"; then
 min_alsa_version=ifelse([$1], ,0.1.1,$1)
 AC_MSG_CHECKING(for libasound headers version >= $min_alsa_version)
 no_alsa=""
@@ -110,6 +111,7 @@ exit(0);
    alsa_found=no]
 )
 AC_LANG_RESTORE
+fi
 
 dnl Now that we know that we have the right version, let's see if we have the library and not just the headers.
 if test "x$enable_alsatest" = "xyes"; then
-- 
1.7.8.6
