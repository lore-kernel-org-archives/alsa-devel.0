From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] Don't check if period size is equal to buffer
	size
Date: Tue, 15 Sep 2009 17:01:02 +0200
Message-ID: <1253026862-15411-1-git-send-email-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bimbo.localdomain (r11na27.net.upc.cz [94.113.108.27])
	by alsa0.perex.cz (Postfix) with ESMTP id E971B1037E3
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Sep 2009 08:18:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Lubomir Rintel <lkundrak@v3.sk>
List-Id: alsa-devel@alsa-project.org

At least some drivers seem to allow a single period and those which
don't would correct us anyway. Moreover, Pulseaudio with tsched sets
this frequently.
---
 aplay/aplay.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index c7c82a1..4fa36cb 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -1044,11 +1044,6 @@ static void set_params(void)
 	}
 	snd_pcm_hw_params_get_period_size(params, &chunk_size, 0);
 	snd_pcm_hw_params_get_buffer_size(params, &buffer_size);
-	if (chunk_size == buffer_size) {
-		error(_("Can't use period equal to buffer size (%lu == %lu)"),
-		      chunk_size, buffer_size);
-		exit(EXIT_FAILURE);
-	}
 	snd_pcm_sw_params_current(handle, swparams);
 	if (avail_min < 0)
 		n = chunk_size;
-- 
1.6.2.5
