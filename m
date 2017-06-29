From: Ion-Horia Petrisor <ion-horia.petrisor@nxp.com>
Subject: [PATCH] aplay: Fix header for raw format
Date: Thu, 29 Jun 2017 14:17:16 +0300
Message-ID: <1498735036-26126-1-git-send-email-ion-horia.petrisor@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0072.outbound.protection.outlook.com [104.47.41.72])
 by alsa0.perex.cz (Postfix) with ESMTP id EA4952668BF
 for <alsa-devel@alsa-project.org>; Thu, 29 Jun 2017 13:17:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, o-takashi@sakamocchi.jp
Cc: Ion-Horia Petrisor <ion-horia.petrisor@nxp.com>, daniel.baluta@nxp.com
List-Id: alsa-devel@alsa-project.org

Raw format has no header, so use 0 when calling playback_go.

Signed-off-by: Ion-Horia Petrisor <ion-horia.petrisor@nxp.com>
---
 aplay/aplay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 00af662..fe274ed 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -2831,7 +2831,7 @@ static void playback(char *name)
 		/* should be raw data */
 		init_raw_data();
 		pbrec_count = calc_count();
-		playback_go(fd, dta, pbrec_count, FORMAT_RAW, name);
+		playback_go(fd, 0, pbrec_count, FORMAT_RAW, name);
 	}
       __end:
 	if (fd != 0)
-- 
2.7.4
