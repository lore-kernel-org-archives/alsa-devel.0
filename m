From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH] alsa-plugins: Fix destruction logic on failed
	construction
Date: Thu, 25 Sep 2008 21:03:01 +0200
Message-ID: <20080925190301.GA30284@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id B18A924431
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Sep 2008 21:03:02 +0200 (CEST)
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

We need to stop the main loop first, then free the context and finally
free the mainloop.
---
 pulse/pulse.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/pulse/pulse.c b/pulse/pulse.c
index 022ca55..3940238 100644
--- a/pulse/pulse.c
+++ b/pulse/pulse.c
@@ -208,6 +208,12 @@ snd_pulse_t *pulse_new(void)
 
 fail:
 	if (p->mainloop)
+		pa_threaded_mainloop_stop(p->mainloop);
+
+	if (p->context)
+		pa_context_unref(p->context);
+
+	if (p->mainloop)
 		pa_threaded_mainloop_free(p->mainloop);
 
 	if (p->main_fd >= 0)
-- 
1.6.0.1

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
