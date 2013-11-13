From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH [alsa-utils] 2/2] alsaconf: update gentoo to
	use modprobe.d method as everyone else
Date: Wed, 13 Nov 2013 13:23:48 -0500
Message-ID: <1384367028-750-2-git-send-email-vapier@gentoo.org>
References: <1384367028-750-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
 by alsa0.perex.cz (Postfix) with ESMTP id B830B2602F3
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 19:23:50 +0100 (CET)
Received: from localhost.localdomain (localhost [127.0.0.1])
 by smtp.gentoo.org (Postfix) with ESMTP id 02D6F33F350
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 18:23:48 +0000 (UTC)
In-Reply-To: <1384367028-750-1-git-send-email-vapier@gentoo.org>
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

We migrated off modules.d a long time ago.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 alsaconf/alsaconf.in | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/alsaconf/alsaconf.in b/alsaconf/alsaconf.in
index 59f25d1..3d6adca 100644
--- a/alsaconf/alsaconf.in
+++ b/alsaconf/alsaconf.in
@@ -300,9 +300,7 @@ if [ -n "$cfgfile" ]; then
     exit 1
   fi
 else
-if [ "$distribution" = "gentoo" ]; then
-  cfgfile="/etc/modules.d/alsa"
-elif [ "$kernel" = "new" ]; then
+if [ "$kernel" = "new" ]; then
   cfgfile="/etc/modprobe.conf"
   if [ -d /etc/modprobe.d ]; then
     cfgout="/etc/modprobe.d/50-sound.conf"
-- 
1.8.3.2
