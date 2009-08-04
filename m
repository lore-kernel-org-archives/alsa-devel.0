From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH 6/6] pulse: immediately trigger EIO when
	connection is	dropped
Date: Tue, 4 Aug 2009 23:56:00 +0200
Message-ID: <20090804215600.GA4934@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 6834D103808
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 23:56:01 +0200 (CEST)
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

When the connection is dropped notify the application immediately
instead of waiting until the applications calls into us the next time.

This makes "aplay" handle connections shutdown similar to hardware
unplugs: an immediate EIO is thrown.
---
 pulse/pulse.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/pulse/pulse.c b/pulse/pulse.c
index 9c05171..a94caaf 100644
--- a/pulse/pulse.c
+++ b/pulse/pulse.c
@@ -77,10 +77,17 @@ int pulse_wait_operation(snd_pulse_t * p, pa_operation * o)
 
 static void context_state_cb(pa_context * c, void *userdata)
 {
+	pa_context_state_t state;
 	snd_pulse_t *p = userdata;
 	assert(c);
 
-	switch (pa_context_get_state(c)) {
+	state = pa_context_get_state(c);
+
+	/* When we get disconnected, tell the process */x
+	if (!PA_CONTEXT_IS_GOOD(state))
+		pulse_poll_activate(p);
+
+	switch (state) {
 	case PA_CONTEXT_READY:
 	case PA_CONTEXT_TERMINATED:
 	case PA_CONTEXT_FAILED:
-- 
1.6.4



Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
