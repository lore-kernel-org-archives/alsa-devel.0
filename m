From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm2000: Fix return of uninitialised
	varible
Date: Thu, 11 Aug 2016 14:40:04 +0100
Message-ID: <1470922804-15805-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 6649F268045
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 15:39:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Anything that sets ret in wm2000_anc_transition will have immediately
returned anyway as such we will always return an uninitialised ret at the
bottom of the function. Simply replace the return with a return 0;

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm2000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm2000.c b/sound/soc/codecs/wm2000.c
index 1ebaf99..199a3d8 100644
--- a/sound/soc/codecs/wm2000.c
+++ b/sound/soc/codecs/wm2000.c
@@ -581,7 +581,7 @@ static int wm2000_anc_transition(struct wm2000_priv *wm2000,
 	if (anc_transitions[i].dest == ANC_OFF)
 		clk_disable_unprepare(wm2000->mclk);
 
-	return ret;
+	return 0;
 }
 
 static int wm2000_anc_set_mode(struct wm2000_priv *wm2000)
-- 
2.1.4
