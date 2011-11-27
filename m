From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Correct name of Speyside Main Speaker
	widget
Date: Sun, 27 Nov 2011 15:55:15 +0000
Message-ID: <1322409315-462-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5F21B24462
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 16:55:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/samsung/speyside.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 1925316..e0f55cb5 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -164,7 +164,7 @@ static int speyside_late_probe(struct snd_soc_card *card)
 	snd_soc_dapm_ignore_suspend(&card->dapm, "Headset Mic");
 	snd_soc_dapm_ignore_suspend(&card->dapm, "Main AMIC");
 	snd_soc_dapm_ignore_suspend(&card->dapm, "Main DMIC");
-	snd_soc_dapm_ignore_suspend(&card->dapm, "Speaker");
+	snd_soc_dapm_ignore_suspend(&card->dapm, "Main Speaker");
 	snd_soc_dapm_ignore_suspend(&card->dapm, "WM1250 Output");
 	snd_soc_dapm_ignore_suspend(&card->dapm, "WM1250 Input");
 
-- 
1.7.7.3
