From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH] alsa-plugins: Fix destruction order on failure
Date: Thu, 25 Sep 2008 21:02:32 +0200
Message-ID: <20080925190232.GA30247@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 5F8DB24438
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Sep 2008 21:02:33 +0200 (CEST)
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

If we failure we should make sure the event loop thread is not running
and hence not accessing our source/sink strings before we free those
strings.
---
 pulse/ctl_pulse.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/pulse/ctl_pulse.c b/pulse/ctl_pulse.c
index 0b10628..8a5546c 100644
--- a/pulse/ctl_pulse.c
+++ b/pulse/ctl_pulse.c
@@ -728,14 +728,11 @@ SND_CTL_PLUGIN_DEFINE_FUNC(pulse)
 	return 0;
 
 error:
-	if (ctl->source)
-		free(ctl->source);
-	if (ctl->sink)
-		free(ctl->sink);
-
 	if (ctl->p)
 		pulse_free(ctl->p);
 
+	free(ctl->source);
+	free(ctl->sink);
 	free(ctl);
 
 	return err;
-- 
1.6.0.1



Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
