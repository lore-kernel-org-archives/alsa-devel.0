From: Valentin Corfu <corfuvalentin@gmail.com>
Subject: [PATCH] jack: Fixing a small memory leak
Date: Mon, 10 Aug 2015 17:58:26 +0300
Message-ID: <1439218706-30721-2-git-send-email-corfuvalentin@gmail.com>
References: <1439218706-30721-1-git-send-email-corfuvalentin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
 [209.85.212.180])
 by alsa0.perex.cz (Postfix) with ESMTP id D72802659ED
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 17:00:21 +0200 (CEST)
Received: by wibhh20 with SMTP id hh20so154686236wib.0
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 08:00:21 -0700 (PDT)
In-Reply-To: <1439218706-30721-1-git-send-email-corfuvalentin@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Valentin Corfu <corfuvalentin@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Valentin Corfu <corfuvalentin@gmail.com>
---
 jack/pcm_jack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index 568ec43..de9c46e 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -103,6 +103,7 @@ static void snd_pcm_jack_free(snd_pcm_jack_t *jack)
 		if (jack->io.poll_fd >= 0)
 			close(jack->io.poll_fd);
 		free(jack->areas);
+		free(jack->ports);
 		free(jack);
 	}
 }
-- 
1.9.1
