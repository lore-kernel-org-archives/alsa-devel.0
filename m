From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Fix leak of rtd in soc_bind_dai_link
Date: Thu, 11 Aug 2016 14:39:00 +0100
Message-ID: <1470922740-15694-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 83369267F53
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 15:38:54 +0200 (CEST)
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

If we fail to find a platform we simply return EPROBE_DEFER,
but we have allocated the rtd pointer. All error paths before
soc_add_pcm_runtime need to call soc_free_pcm_runtime first to
avoid leaking the rtd pointer. A suitable error path already
exists and is used else where in the function so simply use that
here as well.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 054d94f..84e3fa1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1056,7 +1056,7 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	if (!rtd->platform) {
 		dev_err(card->dev, "ASoC: platform %s not registered\n",
 			dai_link->platform_name);
-		return -EPROBE_DEFER;
+		goto _err_defer;
 	}
 
 	soc_add_pcm_runtime(card, rtd);
-- 
2.1.4
