From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH] alsa-plugins: Start PA event loop after we
	have created	the context.
Date: Thu, 25 Sep 2008 21:01:22 +0200
Message-ID: <20080925190122.GA30171@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id D3F1524431
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Sep 2008 21:01:25 +0200 (CEST)
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

Heya!

We shouldn't be passing the main loop object to the pa_context while
that loop is running and not locked. Push the main loop startup after we
created the main loop.
---
 pulse/pulse.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/pulse/pulse.c b/pulse/pulse.c
index 617851e..022ca55 100644
--- a/pulse/pulse.c
+++ b/pulse/pulse.c
@@ -188,9 +188,6 @@ snd_pulse_t *pulse_new(void)
 	if (!p->mainloop)
 		goto fail;
 
-	if (pa_threaded_mainloop_start(p->mainloop) < 0)
-		goto fail;
-
 	if (pa_get_binary_name(proc, sizeof(proc)))
 		snprintf(buf, sizeof(buf), "ALSA plug-in [%s]",
 			 pa_path_get_filename(proc));
@@ -204,6 +201,9 @@ snd_pulse_t *pulse_new(void)
 
 	pa_context_set_state_callback(p->context, context_state_cb, p);
 
+	if (pa_threaded_mainloop_start(p->mainloop) < 0)
+		goto fail;
+
 	return p;
 
 fail:
-- 
1.6.0.1



Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
