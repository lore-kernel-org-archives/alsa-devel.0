From: Ross Burton <ross.burton@intel.com>
Subject: [PATCH][alsa-tools] ld10k1: define _GNU_SOURCE and use
	sighandler_t
Date: Tue, 12 Jun 2018 13:24:34 +0100
Message-ID: <20180612122434.22106-1-ross.burton@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f175.google.com (mail-wr0-f175.google.com
 [209.85.128.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 7511E267252
 for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2018 14:24:41 +0200 (CEST)
Received: by mail-wr0-f175.google.com with SMTP id e18-v6so15618464wrs.5
 for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2018 05:24:41 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

__sighandler_t is a glibc internal type which doesn't exist in musl.  By using
AC_USE_SYSTEM_EXTENSIONS to get _GNU_SOURCE defined, both glibc and musl
then expose sighandler_t.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 ld10k1/configure.ac      | 1 +
 ld10k1/src/ld10k1_fnc1.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/ld10k1/configure.ac b/ld10k1/configure.ac
index 276b24e..f48ca31 100644
--- a/ld10k1/configure.ac
+++ b/ld10k1/configure.ac
@@ -4,6 +4,7 @@ AC_CONFIG_MACRO_DIR([m4])
 AM_MAINTAINER_MODE([enable])
 
 AC_CONFIG_HEADERS(config.h)
+AC_USE_SYSTEM_EXTENSIONS
 AC_PROG_CC
 AC_PROG_LD
 AC_PROG_INSTALL
diff --git a/ld10k1/src/ld10k1_fnc1.c b/ld10k1/src/ld10k1_fnc1.c
index 343584c..ddc43c6 100644
--- a/ld10k1/src/ld10k1_fnc1.c
+++ b/ld10k1/src/ld10k1_fnc1.c
@@ -179,7 +179,7 @@ int main_loop(comm_param *param, int audigy, const char *card_id, int tram_size,
 {
 	fd_set active_fd_set/*, read_fd_set*/;
 	int i, j, res = 0;
-	__sighandler_t old_sig_pipe;
+	sighandler_t old_sig_pipe;
 
 	int main_sock = 0;
 	int data_sock = 0;
-- 
2.11.0
