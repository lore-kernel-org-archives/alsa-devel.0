From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH] alsa-plugins: fix minor memory leak
Date: Thu, 25 Sep 2008 21:01:55 +0200
Message-ID: <20080925190155.GA30224@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 7411624435
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Sep 2008 21:01:56 +0200 (CEST)
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

If we fail, we need to free the device string
---
 pulse/pcm_pulse.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
index 9a50aff..a5f794f 100644
--- a/pulse/pcm_pulse.c
+++ b/pulse/pcm_pulse.c
@@ -917,6 +917,7 @@ error:
 	if (pcm->p)
 		pulse_free(pcm->p);
 
+	free(pcm->device);
 	free(pcm);
 
 	return err;
-- 
1.6.0.1



Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
