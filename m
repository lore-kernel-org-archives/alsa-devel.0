From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: [alsa-utils] [PATCH 2/3] aplay: Use open() instead of
	open64()
Date: Tue, 17 Jul 2012 15:45:34 +0530
Message-ID: <1342520135-2606-2-git-send-email-arun.raghavan@collabora.co.uk>
References: <1342520135-2606-1-git-send-email-arun.raghavan@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
 by alsa0.perex.cz (Postfix) with ESMTP id 16466264FA8
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2012 12:15:31 +0200 (CEST)
In-Reply-To: <1342520135-2606-1-git-send-email-arun.raghavan@collabora.co.uk>
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

AC_SYS_LARGEFILE in configure.in will automatically set up defines so
that open() will support large files if supported, and if not, this
allows us to fall back gracefully to non-LFS open().
---
 aplay/aplay.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 932497d..17fa913 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -2499,7 +2499,7 @@ static void playback(char *name)
 		name = "stdin";
 	} else {
 		init_stdin();
-		if ((fd = open64(name, O_RDONLY, 0)) == -1) {
+		if ((fd = open(name, O_RDONLY, 0)) == -1) {
 			perror(name);
 			prg_exit(EXIT_FAILURE);
 		}
@@ -2707,12 +2707,12 @@ static int safe_open(const char *name)
 {
 	int fd;
 
-	fd = open64(name, O_WRONLY | O_CREAT, 0644);
+	fd = open(name, O_WRONLY | O_CREAT, 0644);
 	if (fd == -1) {
 		if (errno != ENOENT || !use_strftime)
 			return -1;
 		if (create_path(name) == 0)
-			fd = open64(name, O_WRONLY | O_CREAT, 0644);
+			fd = open(name, O_WRONLY | O_CREAT, 0644);
 	}
 	return fd;
 }
-- 
1.7.8.6
