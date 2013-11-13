From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH [alsa-utils] 1/2] alsaconf: support newer m-i-t
	and kmod
Date: Wed, 13 Nov 2013 13:23:47 -0500
Message-ID: <1384367028-750-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
 by alsa0.perex.cz (Postfix) with ESMTP id CE29C260307
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 19:23:50 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by smtp.gentoo.org (Postfix) with ESMTP id 74B5433F355
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 18:23:48 +0000 (UTC)
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

The m-i-t package made it up to 3.10 versions before ending, so update
the glob to handle those too.

Most distros are moving on to kmod, so we also want to handle the version
string that package outputs.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 alsaconf/alsaconf.in | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/alsaconf/alsaconf.in b/alsaconf/alsaconf.in
index 5c23787..59f25d1 100644
--- a/alsaconf/alsaconf.in
+++ b/alsaconf/alsaconf.in
@@ -308,9 +308,11 @@ elif [ "$kernel" = "new" ]; then
     cfgout="/etc/modprobe.d/50-sound.conf"
     cfgoldout="/etc/modprobe.d/sound"
     if [ ! -f $cfgout ]; then
-	modver=$(modprobe -V | sed -e's/^module-init-tools version //')
-	case "$modver" in
-	3.[789]*)
+	case "$(modprobe -V)" in
+	"module-init-tools version "3.[789]*|\
+	"module-init-tools version "3.1[0-9]*)
+	  ;;
+	"kmod version "*)
 	  ;;
 	*)
 	  cfgout="/etc/modprobe.d/sound"
-- 
1.8.3.2
