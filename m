From: Mike Gorse <mgorse@mgorse.dhs.org>
Subject: [patch] snd_pcm_dmix_close: raise semaphore if unable
	to discard
Date: Wed, 17 Oct 2007 20:55:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710172049440.8705@mgorse.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rwcrmhc15.comcast.net (rwcrmhc15.comcast.net [216.148.227.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D1E3244F2
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Oct 2007 02:53:44 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

This patch causes snd_pcm_dmix_close() to up a semaphore after downing it 
if it is unable to discard it.  It prevents some deadlock that I am 
getting when a couple of applications interact and one of them closes the 
device and later re-opens it.

--

--- src/pcm/pcm_dmix.c.orig	2007-10-17 20:19:47.000000000 -0400
+++ src/pcm/pcm_dmix.c	2007-10-17 20:50:46.000000000 -0400
@@ -652,8 +652,11 @@
   	if (dmix->client)
   		snd_pcm_direct_client_discard(dmix);
   	shm_sum_discard(dmix);
-	if (snd_pcm_direct_shm_discard(dmix))
-		snd_pcm_direct_semaphore_discard(dmix);
+	if (snd_pcm_direct_shm_discard(dmix)) {
+		if (snd_pcm_direct_semaphore_discard(dmix)) {
+			snd_pcm_direct_semaphore_up(dmix, DIRECT_IPC_SEM_CLIENT);
+		}
+	}
  	else
  		snd_pcm_direct_semaphore_up(dmix, DIRECT_IPC_SEM_CLIENT);
  	free(dmix->bindings);
