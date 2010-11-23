From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: [PATCHES] Integrate minimal systemd support in
 alsa-utils
Date: Tue, 23 Nov 2010 15:43:03 +0100
Message-ID: <20101123144303.GA6204@tango.0pointer.de>
References: <20101123021657.GA17275@tango.0pointer.de>
	<alpine.LNX.2.00.1011231035270.8433@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 31D09103A7A
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 15:43:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1011231035270.8433@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, jkysela@redhat.com
List-Id: alsa-devel@alsa-project.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, 23.11.10 10:44, Jaroslav Kysela (perex@perex.cz) wrote:

Heya,

> > Up to this point most distributions have been using different init
> > scripts/udev rules files to save/restore mixer settings at
> > boot/hotplug/shutdown. Please see my two attached patches for alsa-utils
> > which add standardized, simplified support for this.
> >
> > The first patch is stolen from Debian/Ubuntu, which moves asound.state
> > to /var/lib, which is a more appropriate place, since /etc might be
> > read-only.
> 
> This will break users which upgrade the package manually from sources and
> /var/lib/alsa directory is not created. I think that the 'make 
> install' rules should create this directory and also alsaconf should 
> check/create this directory if it does not exists.

See attached patch. This will now ensure the directory is created both
at install time and when alsaconf is run.

Also, I made the path configurable, as requested by Takashi, however
set the default to /var/lib/alsa.

> > Given that most big distributions are moving to adopt systemd sooner or
> > later it would be great to have support for this in the upstream package
> > to avoid further balkanization how things are done here.
> 
> I applied this second patch to the alsa-utils repo.

Thanks!

Lennart

-- 
Lennart Poettering - Red Hat, Inc.

--Q68bSM7Ycu6FN28Q
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-Move-asound.state-location-to-var-lib-alsa-and-add-c.patch"

>From 9751c6f8f13116d12a4d8393d5f0b8d43e328e1d Mon Sep 17 00:00:00 2001
From: Lennart Poettering <lennart@poettering.net>
Date: Tue, 23 Nov 2010 02:59:18 +0100
Subject: [PATCH] Move asound.state location to /var/lib/alsa/ and add configure switch for it.

/etc might be on a read-only partition which is not suitable for dynamic
data such as the mixer settings. Hence move the location of asound.state
to /var/lib.

This is based on a patch from Ubuntu/Debian which hardcoded the pah in
/var/lib.
---
 Makefile.am          |    3 +++
 alsaconf/alsaconf.in |    5 +++--
 alsactl/Makefile.am  |    1 +
 alsactl/alsactl.1    |    4 ++--
 alsactl/alsactl.c    |    4 +++-
 configure.in         |    6 ++++++
 6 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 62e1ba6..48a4780 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -38,5 +38,8 @@ dist-hook:
 		$(TAR) --create --verbose --file=- $(distdir) | bzip2 -c -9 > $(distdir).tar.bz2 ; \
 	fi
 
+install-data-hook:
+	$(MKDIR_P) -m 0755 $(DESTDIR)$(ASOUND_STATE_DIR)
+
 DISTCHECK_CONFIGURE_FLAGS = \
         --with-systemdsystemunitdir=$$dc_install_base/$(systemdsystemunitdir)
diff --git a/alsaconf/alsaconf.in b/alsaconf/alsaconf.in
index ccc1b37..cf87784 100644
--- a/alsaconf/alsaconf.in
+++ b/alsaconf/alsaconf.in
@@ -956,8 +956,9 @@ If you have a big amplifier, lower your volumes or say no.
 	  aplay -N $TESTSOUND
       fi
     fi
-    if [ ! -r /etc/asound.state ]; then
-	xecho "Saving the mixer setup used for this in /etc/asound.state."
+    mkdir -p -m 0755 @ASOUND_STATE_DIR@
+    if [ ! -r @ASOUND_STATE_DIR@/asound.state ]; then
+	xecho "Saving the mixer setup used for this in @ASOUND_STATE_DIR@/asound.state."
 	$sbindir/alsactl store
     fi
     clear
diff --git a/alsactl/Makefile.am b/alsactl/Makefile.am
index 9a2d30e..721b619 100644
--- a/alsactl/Makefile.am
+++ b/alsactl/Makefile.am
@@ -8,6 +8,7 @@ endif
 EXTRA_DIST=alsactl.1 alsactl_init.xml
 
 alsactl_SOURCES=alsactl.c state.c utils.c init_parse.c
+alsactl_CFLAGS=$(AM_CFLAGS) -DSYS_ASOUNDRC=\"$(ASOUND_STATE_DIR)/asound.state\"
 noinst_HEADERS=alsactl.h list.h init_sysdeps.c init_utils_string.c init_utils_run.c init_sysfs.c
 
 udevrulesdir=/lib/udev/rules.d
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
index 3b5dfda..57436f7 100644
--- a/alsactl/alsactl.c
+++ b/alsactl/alsactl.c
@@ -30,7 +30,9 @@
 #include <alsa/asoundlib.h>
 #include "alsactl.h"
 
-#define SYS_ASOUNDRC "/etc/asound.state"
+#ifndef SYS_ASOUNDRC
+#define SYS_ASOUNDRC "/var/lib/alsa/asound.state"
+#endif
 
 int debugflag = 0;
 int force_restore = 1;
diff --git a/configure.in b/configure.in
index 54ea74c..94a2b17 100644
--- a/configure.in
+++ b/configure.in
@@ -289,6 +289,12 @@ if test "x$with_systemdsystemunitdir" != xno; then
 fi
 AM_CONDITIONAL(HAVE_SYSTEMD, [test -n "$with_systemdsystemunitdir" -a "x$with_systemdsystemunitdir" != xno ])
 
+AC_ARG_WITH(ASOUND_STATE_DIR,
+        AS_HELP_STRING([--with-asound-state-dir=DIR], [Directory to place asound.state file in]),
+        [ASOUND_STATE_DIR="$withval"],
+        [ASOUND_STATE_DIR="/var/lib/alsa"])
+AC_SUBST(ASOUND_STATE_DIR)
+
 AC_OUTPUT(Makefile alsactl/Makefile alsactl/init/Makefile \
 	  alsamixer/Makefile amidi/Makefile amixer/Makefile \
 	  m4/Makefile po/Makefile.in \
-- 
1.7.3.2


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Q68bSM7Ycu6FN28Q--
