From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH 3/6] pulse: get rid of redundant state variable
Date: Tue, 4 Aug 2009 23:54:42 +0200
Message-ID: <20090804215442.GA4844@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id A5189103803
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 23:54:42 +0200 (CEST)
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

snd_pulse_t::state was mostly shadowing the state of
pa_context_get_state(snd_pulse_t::context), so get rid of it and use the
state of the context directly.
---
 pulse/pulse.c |   14 +++-----------
 pulse/pulse.h |    6 ------
 2 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/pulse/pulse.c b/pulse/pulse.c
index c313182..9c05171 100644
--- a/pulse/pulse.c
+++ b/pulse/pulse.c
@@ -59,12 +59,6 @@ int pulse_wait_operation(snd_pulse_t * p, pa_operation * o)
 	assert(p);
 	assert(o);
 
-	if (p->state != PULSE_STATE_READY)
-		return -EBADFD;
-
-	if (!p->mainloop)
-		return -EBADFD;
-
 	for (;;) {
 		int err;
 
@@ -124,8 +118,6 @@ snd_pulse_t *pulse_new(void)
 	if (!p)
 		return NULL;
 
-	p->state = PULSE_STATE_INIT;
-
 	if (pipe(fd)) {
 		free(p);
 		return NULL;
@@ -192,13 +184,15 @@ void pulse_free(snd_pulse_t * p)
 int pulse_connect(snd_pulse_t * p, const char *server)
 {
 	int err;
+	pa_context_state_t state;
 
 	assert(p);
 
 	if (!p->context || !p->mainloop)
 		return -EBADFD;
 
-	if (p->state != PULSE_STATE_INIT)
+	state = pa_context_get_state(p->context);
+	if (state != PA_CONTEXT_UNCONNECTED)
 		return -EBADFD;
 
 	pa_threaded_mainloop_lock(p->mainloop);
@@ -221,8 +215,6 @@ int pulse_connect(snd_pulse_t * p, const char *server)
 
 	pa_threaded_mainloop_unlock(p->mainloop);
 
-	p->state = PULSE_STATE_READY;
-
 	return 0;
 
       error:
diff --git a/pulse/pulse.h b/pulse/pulse.h
index 51f9a11..e98124f 100644
--- a/pulse/pulse.h
+++ b/pulse/pulse.h
@@ -31,12 +31,6 @@ typedef struct snd_pulse {
 	pa_context *context;
 
 	int thread_fd, main_fd;
-
-	enum {
-		PULSE_STATE_INIT,
-		PULSE_STATE_READY,
-	} state;
-
 } snd_pulse_t;
 
 int pulse_check_connection(snd_pulse_t * p);
-- 
1.6.4



Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
