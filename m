From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5110: Correct HPOUT3 DAPM route typo
Date: Tue, 17 Dec 2013 13:16:16 +0000
Message-ID: <1387286176-9259-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D6741261178
 for <alsa-devel@alsa-project.org>; Tue, 17 Dec 2013 14:22:58 +0100 (CET)
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

Reported-by: Kyung-Kwee Ryu <kyung-kwee.ryu@wolfsonmicro.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 9eb8517..e052ea5 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1340,7 +1340,7 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	{ "AEC Loopback", "HPOUT3L", "OUT3L" },
 	{ "AEC Loopback", "HPOUT3R", "OUT3R" },
 	{ "HPOUT3L", NULL, "OUT3L" },
-	{ "HPOUT3R", NULL, "OUT3L" },
+	{ "HPOUT3R", NULL, "OUT3R" },
 
 	{ "AEC Loopback", "SPKOUTL", "OUT4L" },
 	{ "SPKOUTLN", NULL, "OUT4L" },
-- 
1.7.2.5
