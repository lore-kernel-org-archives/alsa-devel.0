From: Elimar Riesebieter <riesebie@lxtec.de>
Subject: Re: [PATCH] alsa-utils 1.0.27.1 still ships
 90-alsa-restore.rules
Date: Thu, 30 May 2013 15:41:45 +0200
Message-ID: <20130530134144.GB4131@galadriel.home.lxtec.de>
References: <20130530130813.GA25784@galadriel.home.lxtec.de>
 <20130530132826.GA4131@galadriel.home.lxtec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net
 [83.223.90.233])
 by alsa0.perex.cz (Postfix) with ESMTP id 579B32651B9
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 15:42:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130530132826.GA4131@galadriel.home.lxtec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>, pkg-alsa-devel <pkg-alsa-devel@lists.alioth.debian.org>
List-Id: alsa-devel@alsa-project.org

* Elimar Riesebieter <riesebie@lxtec.de> [2013-05-30 15:28 +0200]:

> * Elimar Riesebieter <riesebie@lxtec.de> [2013-05-30 15:08 +0200]:
> 
> > Hi all,
> > 
> > [0] tells:
> > alsactl: remove 90-alsa-restore.rules from the tar ball
> > 
> > but it still ships 90-alsa-restore.rules.in and installs the file as
> > 90-alsa-restore.rules
> > 
> > [0] http://www.alsa-project.org/main/index.php/Changes_v1.0.27_v1.0.27.1
> > 
> [...]
> > -90-alsa-restore.rules: 90-alsa-restore.rules.in
> >  	$(edit)
>    ^^^^^^^^
> Should be removed as well

Forgot two backslashes...

Signed-off-by: Elimar Riesebieter <riesebie@lxtec.de>
---
 alsactl/90-alsa-restore.rules.in |    8 --------
 alsactl/Makefile.am              |   11 ++---------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/alsactl/90-alsa-restore.rules.in b/alsactl/90-alsa-restore.rules.in
deleted file mode 100644
index 88e12e0..0000000
--- a/alsactl/90-alsa-restore.rules.in
+++ /dev/null
@@ -1,8 +0,0 @@
-ACTION=="add", SUBSYSTEM=="sound", KERNEL=="controlC*", KERNELS!="card*", GOTO="alsa_restore_go"
-GOTO="alsa_restore_end"
-
-LABEL="alsa_restore_go"
-TEST!="@daemonswitch@", RUN+="@sbindir@/alsactl restore $attr{number}"
-TEST=="@daemonswitch@", RUN+="@sbindir@/alsactl nrestore $attr{number}"
-
-LABEL="alsa_restore_end"
diff --git a/alsactl/Makefile.am b/alsactl/Makefile.am
index bac84eb..b933ce9 100644
--- a/alsactl/Makefile.am
+++ b/alsactl/Makefile.am
@@ -11,8 +11,6 @@ alsactl_SOURCES=alsactl.c state.c lock.c utils.c init_parse.c daemon.c
 alsactl_CFLAGS=$(AM_CFLAGS) -D__USE_GNU -DSYS_ASOUNDRC=\"$(ASOUND_STATE_DIR)/asound.state\" -DSYS_PIDFILE=\"$(ALSACTL_PIDFILE_DIR)/alsactl.pid\"
 noinst_HEADERS=alsactl.h list.h init_sysdeps.c init_utils_string.c init_utils_run.c init_sysfs.c
 
-udevrules_DATA = \
-	90-alsa-restore.rules
 
 if HAVE_SYSTEMD
 
@@ -49,20 +47,15 @@ alsa-restore.service: alsa-restore.service.in
 alsa-store.service: alsa-store.service.in
 	$(edit)
 
-90-alsa-restore.rules: 90-alsa-restore.rules.in
-	$(edit)
-
 EXTRA_DIST += \
 	alsa-state.service.in \
 	alsa-restore.service.in \
-	alsa-store.service.in \
-	90-alsa-restore.rules.in
+	alsa-store.service.in
 
 CLEANFILES = \
 	alsa-state.service \
 	alsa-restore.service \
-	alsa-store.service \
-	90-alsa-restore.rules
+	alsa-store.service
 
 %.7: %.xml
 	xmlto man $?
