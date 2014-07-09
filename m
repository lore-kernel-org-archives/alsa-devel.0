From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 4/7] ASoC: arizona: Coding standards,
	remove unneeded brackets
Date: Wed,  9 Jul 2014 17:41:46 +0100
Message-ID: <1404924109-1750-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1404924109-1750-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3F7C32650C3
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 18:53:32 +0200 (CEST)
In-Reply-To: <1404924109-1750-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 97cc80d..9a369bc 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1913,11 +1913,10 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 	fll->sync_freq = Fref;
 	fll->fout = Fout;
 
-	if (Fout) {
+	if (Fout)
 		arizona_enable_fll(fll);
-	} else {
+	else
 		arizona_disable_fll(fll);
-	}
 
 	return 0;
 }
-- 
1.7.2.5
