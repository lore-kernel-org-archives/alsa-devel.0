From: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] alsa-restore.rules: refer to correct attr
Date: Sun, 12 Jan 2014 11:15:52 -0500
Message-ID: <1389543352-9105-1-git-send-email-dreisner@archlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gerolde.archlinux.org (gerolde.archlinux.org [66.211.214.132])
 by alsa0.perex.cz (Postfix) with ESMTP id 8694C2619E4
 for <alsa-devel@alsa-project.org>; Sun, 12 Jan 2014 17:15:55 +0100 (CET)
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
Cc: Dave Reisner <dreisner@archlinux.org>
List-Id: alsa-devel@alsa-project.org

$attr{number} in the RUN rule is an empty expansion. This makes sense,
because the path doesn't exist -- i.e., it refers to the path:

/sys/devices/pci0000:00/foo/bar/sound/card0/controlC0/number

Instead, refer to $attr{device/number}, which does exist.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
This seems to have been broken when it was first introduced a little over
three years ago (de7c3eff0e).

Please CC me on replies as I am not subscribed to the list.

 alsactl/90-alsa-restore.rules.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/alsactl/90-alsa-restore.rules.in b/alsactl/90-alsa-restore.rules.in
index 88e12e0..c68119d 100644
--- a/alsactl/90-alsa-restore.rules.in
+++ b/alsactl/90-alsa-restore.rules.in
@@ -2,7 +2,7 @@ ACTION=="add", SUBSYSTEM=="sound", KERNEL=="controlC*", KERNELS!="card*", GOTO="
 GOTO="alsa_restore_end"
 
 LABEL="alsa_restore_go"
-TEST!="@daemonswitch@", RUN+="@sbindir@/alsactl restore $attr{number}"
-TEST=="@daemonswitch@", RUN+="@sbindir@/alsactl nrestore $attr{number}"
+TEST!="@daemonswitch@", RUN+="@sbindir@/alsactl restore $attr{device/number}"
+TEST=="@daemonswitch@", RUN+="@sbindir@/alsactl nrestore $attr{device/number}"
 
 LABEL="alsa_restore_end"
-- 
1.8.5.2
