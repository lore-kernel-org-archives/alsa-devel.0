From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH 2/4] pulse: use PA_CONTEXT_IS_GOOD where
	applicable
Date: Fri, 31 Jul 2009 16:01:52 +0200
Message-ID: <20090731140152.GA31185@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id D17B1103928
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Jul 2009 16:01:53 +0200 (CEST)
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
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

PA_CONTEXT_IS_GOOD is a safer way to check whether a context is still
valid.

This patch also bumps the version requirement of libpulse to 0.9.11.
---
 configure.in  |    2 +-
 pulse/pulse.c |    5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/configure.in b/configure.in
index 36740e9..f8bc669 100644
--- a/configure.in
+++ b/configure.in
@@ -30,7 +30,7 @@ AC_ARG_ENABLE([pulseaudio],
       AS_HELP_STRING([--disable-pulseaudio], [Disable building of pulseaudio plugin]))
 
 if test "x$enable_pulseaudio" != "xno"; then
-  PKG_CHECK_MODULES(pulseaudio, [libpulse >= 0.9.2], [HAVE_PULSE=yes], [HAVE_PULSE=no])
+  PKG_CHECK_MODULES(pulseaudio, [libpulse >= 0.9.11], [HAVE_PULSE=yes], [HAVE_PULSE=no])
 fi
 AM_CONDITIONAL(HAVE_PULSE, test x$HAVE_PULSE = xyes)
 
diff --git a/pulse/pulse.c b/pulse/pulse.c
index 95d8dde..dd17384 100644
--- a/pulse/pulse.c
+++ b/pulse/pulse.c
@@ -38,7 +38,7 @@ int pulse_check_connection(snd_pulse_t * p)
 
 	state = pa_context_get_state(p->context);
 
-	if (state != PA_CONTEXT_READY)
+	if (!PA_CONTEXT_IS_GOOD(state))
 		return -EIO;
 
 	return 0;
@@ -127,8 +127,7 @@ int pulse_wait_stream_state(snd_pulse_t * p, pa_stream * stream,
 		if (state == target)
 			break;
 
-		if (state == PA_STREAM_FAILED ||
-		    state == PA_STREAM_TERMINATED)
+		if (!PA_STREAM_IS_GOOD(state))
 			return -EIO;
 
 		pa_threaded_mainloop_wait(p->mainloop);
-- 
1.6.3.3



Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
