From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH V2] ASoC: mcbsp: remove unnecessary null test
	before kfree
Date: Thu, 26 Jun 2014 21:47:43 +0200
Message-ID: <1403812063-12251-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay008.isp.belgacom.be (mailrelay008.isp.belgacom.be
 [195.238.6.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 91B0B265041
 for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2014 21:49:05 +0200 (CEST)
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
Cc: Fabian Frederick <fabf@skynet.be>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Fix checkpatch warning:
WARNING: kfree(NULL) is safe this check is probably not required

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
V2: replace subject "sound/soc/omap/mcbsp.c" by "ASoC: mcbsp:"
(suggested by Peter Ujfalusi)

 sound/soc/omap/mcbsp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/omap/mcbsp.c b/sound/soc/omap/mcbsp.c
index 86c7538..68a1252 100644
--- a/sound/soc/omap/mcbsp.c
+++ b/sound/soc/omap/mcbsp.c
@@ -621,8 +621,7 @@ void omap_mcbsp_free(struct omap_mcbsp *mcbsp)
 	mcbsp->reg_cache = NULL;
 	spin_unlock(&mcbsp->lock);
 
-	if (reg_cache)
-		kfree(reg_cache);
+	kfree(reg_cache);
 }
 
 /*
-- 
1.8.4.5
