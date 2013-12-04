From: Aaron Wu <aaron.wu@analog.com>
Subject: [PATCH] Add no-mmu support for alsa-utils
Date: Wed, 4 Dec 2013 16:36:30 +0800
Message-ID: <1386146190-2780-1-git-send-email-aaron.wu@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E11F26171F
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 09:39:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: adi-buildroot-devel@lists.sourceforge.net, alsa-devel@alsa-project.org
Cc: Aaron Wu <Aaron.wu@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Aaron Wu <Aaron.wu@analog.com>

Signed-off-by: Aaron Wu <Aaron.wu@analog.com>

Add no-mmu support for alsa-utils mainly for Blackfin
---
 alsactl/init_utils_run.c |    4 ++++
 alsaloop/alsaloop.c      |    8 ++++++++
 configure.in             |    1 +
 3 files changed, 13 insertions(+)

diff --git a/alsactl/init_utils_run.c b/alsactl/init_utils_run.c
index dde490b..ac074e6 100644
--- a/alsactl/init_utils_run.c
+++ b/alsactl/init_utils_run.c
@@ -89,7 +89,11 @@ int run_program0(struct space *space,
 		argv[0] = program;
 	}
 
+	#ifdef HAVE_FORK
 	pid = fork();
+	#else
+	pid = vfork();
+	#endif
 	switch(pid) {
 	case 0:
 		/* child closes parent ends of pipes */
diff --git a/alsaloop/alsaloop.c b/alsaloop/alsaloop.c
index 3b20682..1b1e540 100644
--- a/alsaloop/alsaloop.c
+++ b/alsaloop/alsaloop.c
@@ -861,14 +861,22 @@ int main(int argc, char *argv[])
 			logit(LOG_CRIT, "daemon() failed: %s\n", strerror(errno));
 			exit(EXIT_FAILURE);
 		}
+		#ifdef HAVE_FORK
 		i = fork();
+		#else
+		i = vfork();
+		#endif
 		if (i < 0) {
 			logit(LOG_CRIT, "fork() failed: %s\n", strerror(errno));
 			exit(EXIT_FAILURE);
 		}
 		if (i > 0) {
 			/* wait(&i); */
+			#ifdef HAVE_FORK
 			exit(EXIT_SUCCESS);
+			#else
+			_exit(EXIT_SUCCESS);
+			#endif
 		}
 	}
 
diff --git a/configure.in b/configure.in
index 60da1fa..f289f9b 100644
--- a/configure.in
+++ b/configure.in
@@ -25,6 +25,7 @@ then
   AC_MSG_RESULT($CC)
 fi
 
+AC_CHECK_FUNC([fork])
 AC_PROG_CC
 dnl AC_PROG_CXX
 AC_PROG_INSTALL
-- 
1.7.9.5
