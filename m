From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 2/3] configure.in: Add m4 check for new
	AM_SILENT_RULES
Date: Tue, 29 Sep 2009 23:48:20 +0200
Message-ID: <1254260901-1161-3-git-send-email-stefan@datenfreihafen.org>
References: <1254260901-1161-1-git-send-email-stefan@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id E580110385F
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Sep 2009 23:48:49 +0200 (CEST)
In-Reply-To: <1254260901-1161-1-git-send-email-stefan@datenfreihafen.org>
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
Cc: Stefan Schmidt <stefan@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Stefan Schmidt <stefan@slimlogic.co.uk>

Kbuild like output for automake (>=1.11). It's no hard dependency as it needs
the newest automake, but enable it by default if it is available. To turn it off
you can either use --disable-silent-rules at configure time or make V=0  at
compile time.

Signed-off-by: Stefan Schmidt <stefan@slimlogic.co.uk>
---
 configure.in |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/configure.in b/configure.in
index 3cd6366..a455de1 100644
--- a/configure.in
+++ b/configure.in
@@ -17,6 +17,9 @@ eval LIBTOOL_VERSION_INFO="2:0:0"
 dnl *************************************************
 AM_CONDITIONAL(INSTALL_M4, test -n "${ACLOCAL}")
 
+# Test for new silent rules and enable only if they are available
+m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
+
 AC_PREFIX_DEFAULT(/usr)
 
 dnl Checks for programs.
-- 
1.6.4.3
