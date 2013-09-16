From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: bells: Add missing route to power up DSP
	clock
Date: Mon, 16 Sep 2013 15:38:15 +0100
Message-ID: <1379342295-18423-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 60227261A9B
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 16:48:54 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, sbkim73@samsung.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, ben-linux@fluff.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/bells.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/bells.c b/sound/soc/samsung/bells.c
index 29e2468..84f5d8b 100644
--- a/sound/soc/samsung/bells.c
+++ b/sound/soc/samsung/bells.c
@@ -356,6 +356,7 @@ static struct snd_soc_dapm_widget bells_widgets[] = {
 
 static struct snd_soc_dapm_route bells_routes[] = {
 	{ "Sub CLK_SYS", NULL, "OPCLK" },
+	{ "CLKIN", NULL, "OPCLK" },
 
 	{ "DMIC", NULL, "MICBIAS2" },
 	{ "IN2L", NULL, "DMIC" },
-- 
1.7.2.5
