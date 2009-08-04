From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH 1/6] pulse: replace manual mainloop by
	pa_mainloop_iterate()
Date: Tue, 4 Aug 2009 23:53:51 +0200
Message-ID: <20090804215351.GA4781@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 72EB81037FE
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 23:53:54 +0200 (CEST)
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

The pa_mainloop_prepare()/_poll()/_dispatch() can be simplified by
simply calling pa_mainloop_iterate() which does all this in one call.
---
 pulse/conf_pulse.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/pulse/conf_pulse.c b/pulse/conf_pulse.c
index 3f9e071..35dd383 100644
--- a/pulse/conf_pulse.c
+++ b/pulse/conf_pulse.c
@@ -61,15 +61,7 @@ conf_pulse_hook_load_if_running(snd_config_t * root, snd_config_t * config,
 		goto out;
 
 	do {
-		err = pa_mainloop_prepare(loop, -1);
-		if (err < 0)
-			goto out;
-
-		err = pa_mainloop_poll(loop);
-		if (err < 0)
-			goto out;
-
-		err = pa_mainloop_dispatch(loop);
+		err = pa_mainloop_iterate(loop, 1, NULL);
 		if (err < 0)
 			goto out;
 
-- 
1.6.4



Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
