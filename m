From: soodvarun78@gmail.com
Subject: [PATCH] [alsa-lib] Removed compilation warning from
	test/namehint.c
Date: Sun,  9 Apr 2017 23:15:07 +0530
Message-ID: <1491759907-10912-1-git-send-email-soodvarun78@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f196.google.com (mail-pf0-f196.google.com
 [209.85.192.196])
 by alsa0.perex.cz (Postfix) with ESMTP id E60F026648D
 for <alsa-devel@alsa-project.org>; Sun,  9 Apr 2017 19:46:18 +0200 (CEST)
Received: by mail-pf0-f196.google.com with SMTP id n11so6432551pfg.2
 for <alsa-devel@alsa-project.org>; Sun, 09 Apr 2017 10:46:18 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: o-takashi@sakamocchi.jp
Cc: alsa-devel@alsa-project.org, varun <soodvarun78@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: varun <soodvarun78@gmail.com>

Changed hint variable from char ** to void ** to match function snd_device_name_hint

Signed-off-by: varun <soodvarun78@gmail.com>
---
 test/namehint.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/test/namehint.c b/test/namehint.c
index e978d5c..18bad1d 100644
--- a/test/namehint.c
+++ b/test/namehint.c
@@ -4,7 +4,8 @@
 int main(int argc, char *argv[])
 {
 	const char *iface = "pcm";
-	char **hints, **n;
+	void **hints;
+	char **n;
 	int err;
 
 	if (argc > 1)
@@ -12,7 +13,7 @@ int main(int argc, char *argv[])
 	err = snd_device_name_hint(-1, iface, &hints);
 	if (err < 0)
 		errx(1, "snd_device_name_hint error: %s", snd_strerror(err));
-	n = hints;
+	n = (char **)hints;
 	while (*n != NULL) {
 		printf("%s\n", *n);
 		n++;
-- 
1.9.1
