From: tom.ty89@gmail.com
Subject: [PATCH - alsactl 1/1] make systemd service start in
	proper way
Date: Sun, 24 Jan 2016 08:30:23 +0800
Message-ID: <56a41b26.5908620a.ff61a.6c10@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: alsa-devel@alsa-project.org, Tom Yan <tom.ty89@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Tom Yan <tom.ty89@gmail.com>

Use sound.target to trigger the service, which is the proper way
to start a service related to sound card. This also makes sure that
the service will only start if a sound card exists in the system.

basic.target is too early for either of the service:
1. alsa-state.service will spam "No soundcards found" on every boot
2. alsa-restore.service will never start because of
   "ConditionPathExistsGlob=/dev/snd/control*"

"After=sysinit.target" is removed from alsa-state.service because it
never made any sense.

"After=alsa-state.service" is removed from alsa-restore.service because
it is completely unnecessary with the daemon conf switch.

Now either of serivce is enough to manage the state all by itself without
the udev rules if only ONE sound card exists in the system, while the rules
are still necessary in system with multiple sound cards.

"StandardOutput=syslog" is also removed from alsa-restore.service because it
makes little sense (if it has ever switched the behaviour away from default).

Signed-off-by: Tom Yan <tom.ty89@gmail.com>

diff --git a/alsactl/Makefile.am b/alsactl/Makefile.am
index cac8094..90fab9d 100644
--- a/alsactl/Makefile.am
+++ b/alsactl/Makefile.am
@@ -29,8 +29,8 @@ systemdsystemunit_DATA = \
 
 install-data-hook:
 	$(MKDIR_P) -m 0755 \
-		$(DESTDIR)$(systemdsystemunitdir)/basic.target.wants
-	( cd $(DESTDIR)$(systemdsystemunitdir)/basic.target.wants && \
+		$(DESTDIR)$(systemdsystemunitdir)/sound.target.wants
+	( cd $(DESTDIR)$(systemdsystemunitdir)/sound.target.wants && \
 		rm -f alsa-state.service alsa-restore.service && \
 		$(LN_S) ../alsa-state.service alsa-state.service && \
 		$(LN_S) ../alsa-restore.service alsa-restore.service)
diff --git a/alsactl/alsa-restore.service.in b/alsactl/alsa-restore.service.in
index 2884098..fbcf983 100644
--- a/alsactl/alsa-restore.service.in
+++ b/alsactl/alsa-restore.service.in
@@ -6,12 +6,9 @@
 [Unit]
 Description=Save/Restore Sound Card State
 ConditionPathExists=!@daemonswitch@
-ConditionPathExistsGlob=/dev/snd/control*
-After=alsa-state.service
 
 [Service]
 Type=oneshot
 RemainAfterExit=true
 ExecStart=-@sbindir@/alsactl restore
 ExecStop=-@sbindir@/alsactl store
-StandardOutput=syslog
diff --git a/alsactl/alsa-state.service.in b/alsactl/alsa-state.service.in
index f1321d6..5a8fe5e 100644
--- a/alsactl/alsa-state.service.in
+++ b/alsactl/alsa-state.service.in
@@ -6,7 +6,6 @@
 [Unit]
 Description=Manage Sound Card State (restore and store)
 ConditionPathExists=@daemonswitch@
-After=sysinit.target
 
 [Service]
 Type=simple
-- 
2.7.0
