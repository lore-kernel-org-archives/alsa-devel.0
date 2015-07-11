From: Tobias Stoeckmann <tobias@stoeckmann.org>
Subject: [PATCH] terminate readlink result string
Date: Sat, 11 Jul 2015 13:23:57 +0200
Message-ID: <20150711112356.GA30962@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by alsa0.perex.cz (Postfix) with ESMTP id 056C6260541
 for <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 15:23:48 +0200 (CEST)
Received: from localhost ([79.227.8.11]) by mrelayeu.kundenserver.de
 (mreue005) with ESMTPSA (Nemesis) id 0MLCD7-1ZDdly0zT7-000INt for
 <alsa-devel@alsa-project.org>; Sat, 11 Jul 2015 15:23:47 +0200
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

readlink does not guarantee that its result string is nul-terminated.
Instead, increase the buffer by one byte to make sure that we can
add '\0' at the end.
---
 alsactl/init_sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/alsactl/init_sysfs.c b/alsactl/init_sysfs.c
index 0cbada2..5c789b6 100644
--- a/alsactl/init_sysfs.c
+++ b/alsactl/init_sysfs.c
@@ -108,11 +108,11 @@ static char *sysfs_attr_get_value(const char *devpath, const char *attr_name)
 
 	if (S_ISLNK(statbuf.st_mode)) {
 		/* links return the last element of the target path */
-		char link_target[PATH_SIZE];
+		char link_target[PATH_SIZE + 1];
 		int len;
 		const char *pos;
 
-		len = readlink(path_full, link_target, sizeof(link_target));
+		len = readlink(path_full, link_target, sizeof(link_target) - 1);
 		if (len > 0) {
 			link_target[len] = '\0';
 			pos = strrchr(link_target, '/');
-- 
2.4.5
