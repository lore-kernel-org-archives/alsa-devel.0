From: Alexander Volkov <a.volkov@rusbitech.ru>
Subject: [PATCH - alsa-utils 1/1] arecord: Remove only regular
	files
Date: Mon, 21 Sep 2015 16:05:57 +0300
Message-ID: <1442840757-5403-1-git-send-email-a.volkov@rusbitech.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.rusbitech.ru (mx.rusbitech.ru [109.74.130.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E1EA2612D1
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 15:09:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mx.rusbitech.ru (Postfix) with ESMTP id 03F4418022F
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 16:09:29 +0300 (MSK)
Received: from mx.rusbitech.ru ([127.0.0.1])
 by localhost (larix.rusbitech.ru [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0ANlx8jmBPJD for <alsa-devel@alsa-project.org>;
 Mon, 21 Sep 2015 16:09:28 +0300 (MSK)
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

arecord removes a file before writing into it. It's not
appropriate in some cases. For example, if you a pass
a symlink to a file, then the symlink will be removed
while the user expects to record into the symlink's target.
Another case is recording into the device file. Some
modems provide a tty device file as a voice device.
And it's not possible to write into it under root with
arecord, because it removes the device file.

So check the type of a file before writing into it and
remove only regular files.

Signed-off-by: Alexander Volkov <a.volkov@rusbitech.ru>

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 459f7dd..1b2cdfc 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -2929,6 +2929,7 @@ static void capture(char *orig_name)
 	char *name = orig_name;	/* current filename */
 	char namebuf[PATH_MAX+1];
 	off64_t count, rest;		/* number of bytes to capture */
+	struct stat statbuf;
 
 	/* get number of bytes to capture */
 	count = calc_count();
@@ -2973,7 +2974,10 @@ static void capture(char *orig_name)
 			}
 			
 			/* open a new file */
-			remove(name);
+			if (!lstat(name, &statbuf)) {
+				if (S_ISREG(statbuf.st_mode))
+					remove(name);
+			}
 			fd = safe_open(name);
 			if (fd < 0) {
 				perror(name);
-- 
2.4.0
