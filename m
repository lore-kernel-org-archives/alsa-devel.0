From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-utils] alsactl: Manage both save and
	restore in a single unit
Date: Tue, 29 Sep 2015 18:03:57 +0200
Message-ID: <1443542637-3946-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D9908265821
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 18:03:59 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A9B88AAC8
 for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2015 16:03:58 +0000 (UTC)
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

With RemainAfterExit=true, we can manage both save and restore of the
card state in a single unit file.  This will fix also the case where
systemd reloads the service; with two individual units, it will
restore the previous state before saving, and may lead to inconsistent
state suddenly.

Also fix alsa-state.service as well to make both start and stop
working in a simpler way.

Bugzilla: https://bugzilla.novell.com/show_bug.cgi?id=929619
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 alsactl/Makefile.am             | 14 ++------------
 alsactl/alsa-restore.service.in |  7 +++----
 alsactl/alsa-state.service.in   |  3 ---
 alsactl/alsa-store.service.in   | 16 ----------------
 4 files changed, 5 insertions(+), 35 deletions(-)
 delete mode 100644 alsactl/alsa-store.service.in

diff --git a/alsactl/Makefile.am b/alsactl/Makefile.am
index 47f06e906ced..cac8094687de 100644
--- a/alsactl/Makefile.am
+++ b/alsactl/Makefile.am
@@ -25,20 +25,15 @@ if HAVE_SYSTEMD
 
 systemdsystemunit_DATA = \
 	alsa-state.service \
-	alsa-restore.service \
-	alsa-store.service
+	alsa-restore.service
 
 install-data-hook:
 	$(MKDIR_P) -m 0755 \
-		$(DESTDIR)$(systemdsystemunitdir)/basic.target.wants \
-		$(DESTDIR)$(systemdsystemunitdir)/shutdown.target.wants
+		$(DESTDIR)$(systemdsystemunitdir)/basic.target.wants
 	( cd $(DESTDIR)$(systemdsystemunitdir)/basic.target.wants && \
 		rm -f alsa-state.service alsa-restore.service && \
 		$(LN_S) ../alsa-state.service alsa-state.service && \
 		$(LN_S) ../alsa-restore.service alsa-restore.service)
-	( cd $(DESTDIR)$(systemdsystemunitdir)/shutdown.target.wants && \
-	        rm -f alsa-store.service && \
-		$(LN_S) ../alsa-store.service alsa-store.service )
 
 endif
 
@@ -54,22 +49,17 @@ alsa-state.service: alsa-state.service.in
 alsa-restore.service: alsa-restore.service.in
 	$(edit)
 
-alsa-store.service: alsa-store.service.in
-	$(edit)
-
 90-alsa-restore.rules: 90-alsa-restore.rules.in
 	$(edit)
 
 EXTRA_DIST += \
 	alsa-state.service.in \
 	alsa-restore.service.in \
-	alsa-store.service.in \
 	90-alsa-restore.rules.in
 
 CLEANFILES = \
 	alsa-state.service \
 	alsa-restore.service \
-	alsa-store.service \
 	90-alsa-restore.rules
 
 %.7: %.xml
diff --git a/alsactl/alsa-restore.service.in b/alsactl/alsa-restore.service.in
index d1a74d637457..2884098c26f0 100644
--- a/alsactl/alsa-restore.service.in
+++ b/alsactl/alsa-restore.service.in
@@ -4,15 +4,14 @@
 #
 
 [Unit]
-Description=Restore Sound Card State
+Description=Save/Restore Sound Card State
 ConditionPathExists=!@daemonswitch@
 ConditionPathExistsGlob=/dev/snd/control*
-DefaultDependencies=no
 After=alsa-state.service
-Before=shutdown.target
-Conflicts=shutdown.target
 
 [Service]
 Type=oneshot
+RemainAfterExit=true
 ExecStart=-@sbindir@/alsactl restore
+ExecStop=-@sbindir@/alsactl store
 StandardOutput=syslog
diff --git a/alsactl/alsa-state.service.in b/alsactl/alsa-state.service.in
index 56c12c104565..f1321d63a0ca 100644
--- a/alsactl/alsa-state.service.in
+++ b/alsactl/alsa-state.service.in
@@ -6,10 +6,7 @@
 [Unit]
 Description=Manage Sound Card State (restore and store)
 ConditionPathExists=@daemonswitch@
-DefaultDependencies=no
 After=sysinit.target
-Before=shutdown.target
-Conflicts=shutdown.target
 
 [Service]
 Type=simple
diff --git a/alsactl/alsa-store.service.in b/alsactl/alsa-store.service.in
deleted file mode 100644
index c89cfff04f35..000000000000
--- a/alsactl/alsa-store.service.in
+++ /dev/null
@@ -1,16 +0,0 @@
-#
-# Note that two different ALSA card state management schemes exist and they
-# can be switched using a file exist check - /etc/alsa/state-daemon.conf .
-#
-
-[Unit]
-Description=Store Sound Card State
-ConditionPathExists=!@daemonswitch@
-ConditionPathExistsGlob=/dev/snd/control*
-DefaultDependencies=no
-Before=shutdown.target
-
-[Service]
-Type=oneshot
-ExecStart=@sbindir@/alsactl store
-StandardOutput=syslog
-- 
2.5.3
