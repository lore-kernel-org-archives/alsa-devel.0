From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5110: Add missing routes for AEC
	Loopback
Date: Sat, 26 Oct 2013 15:29:50 +0100
Message-ID: <1382797790-20575-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9335F2610B0
 for <alsa-devel@alsa-project.org>; Sat, 26 Oct 2013 16:41:27 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index bbd6438..8c91be5 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -983,24 +983,36 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	ARIZONA_MUX_ROUTES("ASRC2L", "ASRC2L"),
 	ARIZONA_MUX_ROUTES("ASRC2R", "ASRC2R"),
 
+	{ "AEC Loopback", "HPOUT1L", "OUT1L" },
+	{ "AEC Loopback", "HPOUT1R", "OUT1R" },
 	{ "HPOUT1L", NULL, "OUT1L" },
 	{ "HPOUT1R", NULL, "OUT1R" },
 
+	{ "AEC Loopback", "HPOUT2L", "OUT2L" },
+	{ "AEC Loopback", "HPOUT2R", "OUT2R" },
 	{ "HPOUT2L", NULL, "OUT2L" },
 	{ "HPOUT2R", NULL, "OUT2R" },
 
+	{ "AEC Loopback", "HPOUT3L", "OUT3L" },
+	{ "AEC Loopback", "HPOUT3R", "OUT3R" },
 	{ "HPOUT3L", NULL, "OUT3L" },
 	{ "HPOUT3R", NULL, "OUT3L" },
 
+	{ "AEC Loopback", "SPKOUTL", "OUT4L" },
 	{ "SPKOUTLN", NULL, "OUT4L" },
 	{ "SPKOUTLP", NULL, "OUT4L" },
 
+	{ "AEC Loopback", "SPKOUTR", "OUT4R" },
 	{ "SPKOUTRN", NULL, "OUT4R" },
 	{ "SPKOUTRP", NULL, "OUT4R" },
 
+	{ "AEC Loopback", "SPKDAT1L", "OUT5L" },
+	{ "AEC Loopback", "SPKDAT1R", "OUT5R" },
 	{ "SPKDAT1L", NULL, "OUT5L" },
 	{ "SPKDAT1R", NULL, "OUT5R" },
 
+	{ "AEC Loopback", "SPKDAT2L", "OUT6L" },
+	{ "AEC Loopback", "SPKDAT2R", "OUT6R" },
 	{ "SPKDAT2L", NULL, "OUT6L" },
 	{ "SPKDAT2R", NULL, "OUT6R" },
 
-- 
1.7.2.5
