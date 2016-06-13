From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/4] ASoC: wm5110: Add missing route from OUT3R
	to SYSCLK
Date: Mon, 13 Jun 2016 13:35:15 +0100
Message-ID: <1465821317-28449-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1465821317-28449-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id D0469265471
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 14:35:12 +0200 (CEST)
In-Reply-To: <1465821317-28449-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, ajit.pandey@soctronics.com, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

From: Ajit Pandey <ajit.pandey@soctronics.com>

Output 3 is stereo on wm5110 and all inputs/outputs should have a
connection to SYSCLK. This patch adds the missing DAPM route.

Signed-off-by: Ajit Pandey <ajit.pandey@soctronics.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 3b8db83..1565470 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1728,6 +1728,7 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	{ "OUT2L", NULL, "SYSCLK" },
 	{ "OUT2R", NULL, "SYSCLK" },
 	{ "OUT3L", NULL, "SYSCLK" },
+	{ "OUT3R", NULL, "SYSCLK" },
 	{ "OUT4L", NULL, "SYSCLK" },
 	{ "OUT4R", NULL, "SYSCLK" },
 	{ "OUT5L", NULL, "SYSCLK" },
-- 
2.1.4
