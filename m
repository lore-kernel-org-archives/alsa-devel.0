From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5/5] ALSA: pxa2xx: Replace BUG() with snd_BUG()
Date: Tue,  5 Nov 2013 18:10:43 +0100
Message-ID: <1383671443-13707-6-git-send-email-tiwai@suse.de>
References: <1383671443-13707-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 10F08261ABC
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:10:47 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E2A91A67FB
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:10:46 +0100 (CET)
In-Reply-To: <1383671443-13707-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

BUG() used in the driver is just to spit the stack trace on buggy
points, not really needed to stop the whole operation.  For that
purpose, it'd be more convenient to use snd_BUG() instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/arm/pxa2xx-ac97-lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 99a466822a7d..66de90ed30ca 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -208,7 +208,7 @@ bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97)
 		pxa_ac97_warm_pxa3xx();
 	else
 #endif
-		BUG();
+		snd_BUG();
 
 	while (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)) && timeout--)
 		mdelay(1);
@@ -245,7 +245,7 @@ bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97)
 		pxa_ac97_cold_pxa3xx();
 	else
 #endif
-		BUG();
+		snd_BUG();
 
 	while (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR)) && timeout--)
 		mdelay(1);
-- 
1.8.4.2
