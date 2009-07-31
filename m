From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH 3/4] pulse: unify destruction of snd_pulse_t
Date: Fri, 31 Jul 2009 16:02:05 +0200
Message-ID: <20090731140205.GA31215@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C40210392F
	for <alsa-devel@alsa-project.org>;
	Fri, 31 Jul 2009 16:02:06 +0200 (CEST)
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

---
 pulse/pulse.c |   31 ++++++++++++-------------------
 1 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/pulse/pulse.c b/pulse/pulse.c
index dd17384..ae66b0c 100644
--- a/pulse/pulse.c
+++ b/pulse/pulse.c
@@ -217,36 +217,29 @@ snd_pulse_t *pulse_new(void)
 	return p;
 
 fail:
+	pulse_free(p);
+
+	return NULL;
+}
+
+void pulse_free(snd_pulse_t * p)
+{
 	if (p->mainloop)
 		pa_threaded_mainloop_stop(p->mainloop);
 
-	if (p->context)
+	if (p->context) {
+		pa_context_disconnect(p->context);
 		pa_context_unref(p->context);
+	}
 
 	if (p->mainloop)
 		pa_threaded_mainloop_free(p->mainloop);
 
-	if (p->main_fd >= 0)
-		close(p->main_fd);
-
 	if (p->thread_fd >= 0)
 		close(p->thread_fd);
 
-	free(p);
-
-	return NULL;
-}
-
-void pulse_free(snd_pulse_t * p)
-{
-	pa_threaded_mainloop_stop(p->mainloop);
-
-	pa_context_disconnect(p->context);
-	pa_context_unref(p->context);
-	pa_threaded_mainloop_free(p->mainloop);
-
-	close(p->thread_fd);
-	close(p->main_fd);
+	if (p->main_fd >= 0)
+		close(p->main_fd);
 
 	free(p);
 }
-- 
1.6.3.3



Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
