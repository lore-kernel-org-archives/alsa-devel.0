From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Make FLL lock timeout very high
Date: Thu,  6 Dec 2012 15:30:48 +0900
Message-ID: <1354775449-19256-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9A1542615FF
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2012 07:30:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Provide robustness against low quality FLL sync clocks by increasing the
timeout for lock to an absurdly high point; we should never get anywhere
near hitting the timeout in a real system unless it is failing.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 5fc11bc..ef68f7a 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1083,7 +1083,7 @@ int arizona_set_fll(struct arizona_fll *fll, int source,
 				   ARIZONA_FLL1_SYNC_ENA);
 
 	ret = wait_for_completion_timeout(&fll->ok,
-					  msecs_to_jiffies(25));
+					  msecs_to_jiffies(250));
 	if (ret == 0)
 		arizona_fll_warn(fll, "Timed out waiting for lock\n");
 
-- 
1.7.10.4
