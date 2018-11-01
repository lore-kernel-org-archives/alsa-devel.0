From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH alsa-lib] Don't use fork() on noMMU platforms
Date: Thu,  1 Nov 2018 15:40:01 +0100
Message-ID: <20181101144001.1452-1-thomas.petazzoni@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 669AD2677D0
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2018 15:40:04 +0100 (CET)
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
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
List-Id: alsa-devel@alsa-project.org

fork() is not available on noMMU platforms, but in the specific case
of pcm_direct.c, vfork() can be used instead. This commit adds an
autoconf check for fork(), and falls back to vfork() is fork() is not
available.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 configure.ac         |  2 ++
 src/pcm/pcm_direct.c | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 4c9d860f..ab659490 100644
--- a/configure.ac
+++ b/configure.ac
@@ -51,6 +51,8 @@ dnl Checks for library functions.
 AC_PROG_GCC_TRADITIONAL
 AC_CHECK_FUNCS([uselocale])
 
+AC_CHECK_FUNC([fork])
+
 SAVE_LIBRARY_VERSION
 AC_SUBST(LIBTOOL_VERSION_INFO)
 
diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 2b07eff9..4dc3ea26 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -431,13 +431,21 @@ int snd_pcm_direct_server_create(snd_pcm_direct_t *dmix)
 		close(dmix->server_fd);
 		return ret;
 	}
-	
+
+#ifdef HAVE_FORK
 	ret = fork();
+#else
+	ret = vfork();
+#endif
 	if (ret < 0) {
 		close(dmix->server_fd);
 		return ret;
 	} else if (ret == 0) {
+#ifdef HAVE_FORK
 		ret = fork();
+#else
+		ret = vfork();
+#endif
 		if (ret == 0)
 			server_job(dmix);
 		_exit(EXIT_SUCCESS);
-- 
2.14.4
