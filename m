From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH 5/6] pulse: rework object destruction paths a
	bit
Date: Tue, 4 Aug 2009 23:55:28 +0200
Message-ID: <20090804215528.GA4904@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 953E710383D
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 23:55:29 +0200 (CEST)
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

Make sure we deal better with partially initialized structs.

Don't check for pointer state before calling free() since free() does
that anyway.
---
 pulse/ctl_pulse.c |    7 ++-----
 pulse/pcm_pulse.c |   19 ++++++++++---------
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/pulse/ctl_pulse.c b/pulse/ctl_pulse.c
index 879f260..85863ed 100644
--- a/pulse/ctl_pulse.c
+++ b/pulse/ctl_pulse.c
@@ -606,11 +606,8 @@ static void pulse_close(snd_ctl_ext_t * ext)
 	if (ctl->p)
 		pulse_free(ctl->p);
 
-	if (ctl->source)
-		free(ctl->source);
-	if (ctl->sink)
-		free(ctl->sink);
-
+	free(ctl->source);
+	free(ctl->sink);
 	free(ctl);
 }
 
diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
index 98983f8..02a837e 100644
--- a/pulse/pcm_pulse.c
+++ b/pulse/pcm_pulse.c
@@ -819,21 +819,22 @@ static int pulse_close(snd_pcm_ioplug_t * io)
 
 	assert(pcm);
 
-	pa_threaded_mainloop_lock(pcm->p->mainloop);
+	if (pcm->p && pcm->p->mainloop) {
 
-	if (pcm->stream) {
-		pa_stream_disconnect(pcm->stream);
-		pa_stream_unref(pcm->stream);
-	}
+		pa_threaded_mainloop_lock(pcm->p->mainloop);
 
-	pa_threaded_mainloop_unlock(pcm->p->mainloop);
+		if (pcm->stream) {
+			pa_stream_disconnect(pcm->stream);
+			pa_stream_unref(pcm->stream);
+		}
+
+		pa_threaded_mainloop_unlock(pcm->p->mainloop);
+	}
 
 	if (pcm->p)
 		pulse_free(pcm->p);
 
-	if (pcm->device)
-		free(pcm->device);
-
+	free(pcm->device);
 	free(pcm);
 
 	return 0;
-- 
1.6.4



Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
