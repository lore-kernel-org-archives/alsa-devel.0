From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH 2/4] ASoC: pxa-ssp: PXA2xx/3xx SSP ports start
	from 1, not 0
Date: Tue,  3 Feb 2009 17:19:41 +0100
Message-ID: <1233677983-23710-3-git-send-email-philipp.zabel@gmail.com>
References: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f16.google.com (mail-ew0-f16.google.com
	[209.85.219.16])
	by alsa0.perex.cz (Postfix) with ESMTP id AF99C10384F
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 17:21:46 +0100 (CET)
Received: by ewy9 with SMTP id 9so59198ewy.8
	for <alsa-devel@alsa-project.org>; Tue, 03 Feb 2009 08:21:46 -0800 (PST)
In-Reply-To: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Mark Brown <broonie@sirena.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
---
 sound/soc/pxa/pxa-ssp.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/pxa-ssp.c b/sound/soc/pxa/pxa-ssp.c
index 73cb6b4..5ee544b 100644
--- a/sound/soc/pxa/pxa-ssp.c
+++ b/sound/soc/pxa/pxa-ssp.c
@@ -785,7 +785,7 @@ static void pxa_ssp_remove(struct platform_device *pdev,
 struct snd_soc_dai pxa_ssp_dai[] = {
 	{
 		.name = "pxa2xx-ssp1",
-		.id = 0,
+		.id = 1,
 		.probe = pxa_ssp_probe,
 		.remove = pxa_ssp_remove,
 		.suspend = pxa_ssp_suspend,
@@ -816,7 +816,7 @@ struct snd_soc_dai pxa_ssp_dai[] = {
 		},
 	},
 	{	.name = "pxa2xx-ssp2",
-		.id = 1,
+		.id = 2,
 		.probe = pxa_ssp_probe,
 		.remove = pxa_ssp_remove,
 		.suspend = pxa_ssp_suspend,
@@ -848,7 +848,7 @@ struct snd_soc_dai pxa_ssp_dai[] = {
 	},
 	{
 		.name = "pxa2xx-ssp3",
-		.id = 2,
+		.id = 3,
 		.probe = pxa_ssp_probe,
 		.remove = pxa_ssp_remove,
 		.suspend = pxa_ssp_suspend,
@@ -880,7 +880,7 @@ struct snd_soc_dai pxa_ssp_dai[] = {
 	},
 	{
 		.name = "pxa2xx-ssp4",
-		.id = 3,
+		.id = 4,
 		.probe = pxa_ssp_probe,
 		.remove = pxa_ssp_remove,
 		.suspend = pxa_ssp_suspend,
-- 
1.5.6.5
