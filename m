From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCHES] Integrate minimal systemd support in
	alsa-utils
Date: Tue, 23 Nov 2010 03:16:58 +0100
Message-ID: <20101123021657.GA17275@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 281F81038AD
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 03:17:18 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, jkysela@redhat.com, Kay Sievers <kay.sievers@vrfy.org>
List-Id: alsa-devel@alsa-project.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Heya,

Up to this point most distributions have been using different init
scripts/udev rules files to save/restore mixer settings at
boot/hotplug/shutdown. Please see my two attached patches for alsa-utils
which add standardized, simplified support for this.

The first patch is stolen from Debian/Ubuntu, which moves asound.state
to /var/lib, which is a more appropriate place, since /etc might be
read-only.

The second patch includes a minimal udev rule (executed synchronously,
enabled on all systems, regardless of systemd is used or not) and two
systemd service files (executed asynchronously at boot/shutdown, only
enabled if built with systemd support).

Given that most big distributions are moving to adopt systemd sooner or
later it would be great to have support for this in the upstream package
to avoid further balkanization how things are done here.

Lennart

-- 
Lennart Poettering - Red Hat, Inc.

--/04w6evG8XlLl3ft
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-Move-asound.state-location-to-var-lib-alsa.patch"

>From c5b414489626fcd46d792ab96db06e254dfeff90 Mon Sep 17 00:00:00 2001
From: David B. Harris <david@eelf.ddts.net>
Date: Tue, 23 Nov 2010 02:59:18 +0100
Subject: [PATCH 1/2] Move asound.state location to /var/lib/alsa/

/etc might be on a read-only partition which is not suitable for dynamic
data such as the mixer settings. Hence move the location of asound.state
to /var/lib.
---
 alsaconf/alsaconf.in |    4 ++--
 alsactl/alsactl.1    |    4 ++--
 alsactl/alsactl.c    |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/alsaconf/alsaconf.in b/alsaconf/alsaconf.in
index ccc1b37..b9815d1 100644
--- a/alsaconf/alsaconf.in
+++ b/alsaconf/alsaconf.in
@@ -956,8 +956,8 @@ If you have a big amplifier, lower your volumes or say no.
 	  aplay -N $TESTSOUND
       fi
     fi
-    if [ ! -r /etc/asound.state ]; then
-	xecho "Saving the mixer setup used for this in /etc/asound.state."
+    if [ ! -r /var/lib/alsa/asound.state ]; then
+	xecho "Saving the mixer setup used for this in /var/lib/alsa/asound.state."
 	$sbindir/alsactl store
     fi
     clear
diff --git a/alsactl/alsactl.1 b/alsactl/alsactl.1
index eb3cbd1..eb5968c 100644
--- a/alsactl/alsactl.1
+++ b/alsactl/alsactl.1
@@ -43,7 +43,7 @@ Print alsactl version number.
 
 .TP
 \fI\-f, \-\-file\fP
-Select the configuration file to use. The default is /etc/asound.state.
+Select the configuration file to use. The default is /var/lib/alsa/asound.state.
 
 .TP
 \fI\-F, \-\-force\fP
@@ -90,7 +90,7 @@ The configuration file for init. By default, PREFIX/share/alsa/init/00main
 is used.
 
 .SH FILES
-\fI/etc/asound.state\fP (or whatever file you specify with the
+\fI/var/lib/alsa/asound.state\fP (or whatever file you specify with the
 \fB\-f\fP flag) is used to store current settings for your
 soundcards. The settings include all the usual soundcard mixer
 settings.  More importantly, alsactl is
diff --git a/alsactl/alsactl.c b/alsactl/alsactl.c
index 3b5dfda..59f0738 100644
--- a/alsactl/alsactl.c
+++ b/alsactl/alsactl.c
@@ -30,7 +30,7 @@
 #include <alsa/asoundlib.h>
 #include "alsactl.h"
 
-#define SYS_ASOUNDRC "/etc/asound.state"
+#define SYS_ASOUNDRC "/var/lib/alsa/asound.state"
 
 int debugflag = 0;
 int force_restore = 1;
-- 
1.7.3.2


--/04w6evG8XlLl3ft
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0002-alsactl-systemd-and-udev-hookup.patch"

>From 2925d59fd4a451ab36e704ea09984a6a70c358a7 Mon Sep 17 00:00:00 2001
From: Lennart Poettering <lennart@poettering.net>
Date: Tue, 23 Nov 2010 01:45:08 +0100
Subject: [PATCH 2/2] alsactl: systemd and udev hookup

Add minimal systemd and udev support to alsactl so that mixer settings
are restored at boot, when sound cards are plugged in and saved on
shutdown.

This is similar to existing udev/init script solutions in various
distributions.

Note that alsactl is called both synchronously from the udev rules as
well as asynchronously at boot. This is intended, and to ensure two
things:

- At boot the asound.state file might not be readable, since it resides
  on a different file system. That means exclusively restoring sound card
  settings from udev rules will no suffice, since if the rule is
  executed at early boot (for example within udev settle) then the file
  will no be readable and cannot be restored.

- We need to ensure that applications monitoring sound cards coming and
  going (such as PA) must not get these events before the mixer settings
  have been restored. That means the mixer settings must be restored
  synchronously withing the udev rules, before the events are passed on
  to the apps.

That basically means we need to restore the settings once in udev, to
deal with sound cards becoming available during runtime. And once in
early boot to deal with coldplugged soundcards whose data files might
not have been available at time of plugging. Hence we call alsactl
twice: one from the udev rule, and once from he systemd unit file.
---
 Makefile.am                      |    3 ++
 alsactl/.gitignore               |    3 ++
 alsactl/90-alsa-restore.rules.in |    2 +
 alsactl/Makefile.am              |   46 ++++++++++++++++++++++++++++++++++++++
 alsactl/alsa-restore.service.in  |   11 +++++++++
 alsactl/alsa-store.service.in    |    9 +++++++
 configure.in                     |   17 +++++++++++--
 7 files changed, 88 insertions(+), 3 deletions(-)
 create mode 100644 alsactl/.gitignore
 create mode 100644 alsactl/90-alsa-restore.rules.in
 create mode 100644 alsactl/alsa-restore.service.in
 create mode 100644 alsactl/alsa-store.service.in

diff --git a/Makefile.am b/Makefile.am
index 9951c46..62e1ba6 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -37,3 +37,6 @@ dist-hook:
 	else \
 		$(TAR) --create --verbose --file=- $(distdir) | bzip2 -c -9 > $(distdir).tar.bz2 ; \
 	fi
+
+DISTCHECK_CONFIGURE_FLAGS = \
+        --with-systemdsystemunitdir=$$dc_install_base/$(systemdsystemunitdir)
diff --git a/alsactl/.gitignore b/alsactl/.gitignore
new file mode 100644
index 0000000..56ab3a2
--- /dev/null
+++ b/alsactl/.gitignore
@@ -0,0 +1,3 @@
+alsa-store.service
+alsa-restore.service
+90-alsa-restore.rules
diff --git a/alsactl/90-alsa-restore.rules.in b/alsactl/90-alsa-restore.rules.in
new file mode 100644
index 0000000..0bcee5b
--- /dev/null
+++ b/alsactl/90-alsa-restore.rules.in
@@ -0,0 +1,2 @@
+ACTION=="add", SUBSYSTEM=="sound", KERNEL=="controlC*", KERNELS=="card*", \
+        RUN+="@sbindir@/alsactl restore $attr{number}"
diff --git a/alsactl/Makefile.am b/alsactl/Makefile.am
index 359f73a..9a2d30e 100644
--- a/alsactl/Makefile.am
+++ b/alsactl/Makefile.am
@@ -10,5 +10,51 @@ EXTRA_DIST=alsactl.1 alsactl_init.xml
 alsactl_SOURCES=alsactl.c state.c utils.c init_parse.c
 noinst_HEADERS=alsactl.h list.h init_sysdeps.c init_utils_string.c init_utils_run.c init_sysfs.c
 
+udevrulesdir=/lib/udev/rules.d
+
+dist_udevrules_DATA = \
+	90-alsa-restore.rules
+
+if HAVE_SYSTEMD
+
+systemdsystemunit_DATA = \
+	alsa-store.service \
+	alsa-restore.service
+
+install-data-hook:
+	$(MKDIR_P) -m 0755 \
+		$(DESTDIR)$(systemdsystemunitdir)/basic.target.wants \
+		$(DESTDIR)$(systemdsystemunitdir)/shutdown.target.wants
+	( cd $(DESTDIR)$(systemdsystemunitdir)/basic.target.wants && \
+	        rm -f alsa-restore.service && \
+		$(LN_S) ../alsa-restore.service alsa-restore.service )
+	( cd $(DESTDIR)$(systemdsystemunitdir)/shutdown.target.wants && \
+	        rm -f alsa-store.service && \
+		$(LN_S) ../alsa-store.service alsa-store.service )
+
+endif
+
+edit = \
+	sed $(SED) -r 's,@sbindir\@,$(sbindir),g' < $< > $@ || rm $@
+
+alsa-store.service: alsa-store.service.in
+	$(edit)
+
+alsa-restore.service: alsa-restore.service.in
+	$(edit)
+
+90-alsa-restore.rules: 90-alsa-restore.rules.in
+	$(edit)
+
+EXTRA_DIST += \
+	alsa-store.service.in \
+	alsa-restore.service.in \
+	90-alsa-restore.rules.in
+
+CLEANFILES = \
+	alsa-store.service \
+	alsa-restore.service \
+	90-alsa-restore.rules
+
 %.7: %.xml
 	xmlto man $?
diff --git a/alsactl/alsa-restore.service.in b/alsactl/alsa-restore.service.in
new file mode 100644
index 0000000..e97d196
--- /dev/null
+++ b/alsactl/alsa-restore.service.in
@@ -0,0 +1,11 @@
+[Unit]
+Description=Restore Sound Card State
+DefaultDependencies=no
+After=sysinit.target
+Before=shutdown.target
+Conflicts=shutdown.target
+
+[Service]
+Type=oneshot
+ExecStart=-@sbindir@/alsactl restore
+StandardOutput=syslog
diff --git a/alsactl/alsa-store.service.in b/alsactl/alsa-store.service.in
new file mode 100644
index 0000000..0e2823c
--- /dev/null
+++ b/alsactl/alsa-store.service.in
@@ -0,0 +1,9 @@
+[Unit]
+Description=Store Sound Card State
+DefaultDependencies=no
+Before=shutdown.target
+
+[Service]
+Type=oneshot
+ExecStart=@sbindir@/alsactl store
+StandardOutput=syslog
diff --git a/configure.in b/configure.in
index 31fd581..54ea74c 100644
--- a/configure.in
+++ b/configure.in
@@ -26,6 +26,7 @@ fi
 AC_PROG_CC
 dnl AC_PROG_CXX
 AC_PROG_INSTALL
+AC_PROG_MKDIR_P
 AC_PROG_LN_S
 AM_PATH_ALSA(1.0.16)
 
@@ -130,7 +131,7 @@ if test x$alsamixer = xtrue; then
       CURSES_CFLAGS=`ncursesw5-config --cflags`
       curseslib="ncursesw"
     else
-      AC_CHECK_LIB(ncursesw, initscr, 
+      AC_CHECK_LIB(ncursesw, initscr,
                  [ CURSESINC='<ncurses.h>'; CURSESLIB='-lncursesw'; curseslib="ncursesw"])
     fi
     if test -n "$CURSESINC"; then
@@ -147,12 +148,12 @@ if test x$alsamixer = xtrue; then
       CURSES_CFLAGS=`ncurses5-config --cflags`
       curseslib="ncurses"
     else
-      AC_CHECK_LIB(ncurses, initscr, 
+      AC_CHECK_LIB(ncurses, initscr,
                  [ CURSESINC='<ncurses.h>'; CURSESLIB='-lncurses'; curseslib="ncurses"])
     fi
   fi
   if test "$curseslib" = "curses" -o "$curseslib" = "auto"; then
-    AC_CHECK_LIB(curses, initscr, 
+    AC_CHECK_LIB(curses, initscr,
                  [ CURSESINC='<curses.h>'; CURSESLIB='-lcurses'; curseslib="curses"])
   fi
   if test -z "$CURSESINC"; then
@@ -278,6 +279,16 @@ SAVE_UTIL_VERSION
 
 AC_SUBST(LIBRT)
 
+dnl Check for systemd
+PKG_PROG_PKG_CONFIG
+AC_ARG_WITH([systemdsystemunitdir],
+        AS_HELP_STRING([--with-systemdsystemunitdir=DIR], [Directory for systemd service files]),
+        [], [with_systemdsystemunitdir=$($PKG_CONFIG --variable=systemdsystemunitdir systemd)])
+if test "x$with_systemdsystemunitdir" != xno; then
+        AC_SUBST([systemdsystemunitdir], [$with_systemdsystemunitdir])
+fi
+AM_CONDITIONAL(HAVE_SYSTEMD, [test -n "$with_systemdsystemunitdir" -a "x$with_systemdsystemunitdir" != xno ])
+
 AC_OUTPUT(Makefile alsactl/Makefile alsactl/init/Makefile \
 	  alsamixer/Makefile amidi/Makefile amixer/Makefile \
 	  m4/Makefile po/Makefile.in \
-- 
1.7.3.2


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--/04w6evG8XlLl3ft--
