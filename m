From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH 4/4] pulse: call pa_threaded_mainloop_wait() to
	handle	spurious wakeups
Date: Fri, 31 Jul 2009 16:02:21 +0200
Message-ID: <20090731140221.GA31245@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id E4731103940
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Jul 2009 16:02:21 +0200 (CEST)
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

pa_threaded_mainloop_wait() can wake up for no reason, according to the
specs of the underlying POSIX ptrhead_cond_wait() docs, so we need to
call it in a loop here which should be cleaner anyway.
---
 pulse/pulse.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/pulse/pulse.c b/pulse/pulse.c
index ae66b0c..6f58a7e 100644
--- a/pulse/pulse.c
+++ b/pulse/pulse.c
@@ -262,10 +262,17 @@ int pulse_connect(snd_pulse_t * p, const char *server)
 	if (err < 0)
 		goto error;
 
-	pa_threaded_mainloop_wait(p->mainloop);
+	for (;;) {
+		pa_context_state_t state = pa_context_get_state(p->context);
 
-	if (pa_context_get_state(p->context) != PA_CONTEXT_READY)
-		goto error;
+		if (!PA_CONTEXT_IS_GOOD(state))
+			goto error;
+
+		if (state == PA_CONTEXT_READY)
+			break;
+
+		pa_threaded_mainloop_wait(p->mainloop);
+	}
 
 	pa_threaded_mainloop_unlock(p->mainloop);
 
-- 
1.6.3.3



Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
