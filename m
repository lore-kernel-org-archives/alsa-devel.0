From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 6/7] phycore-ac97: add ac97 to cardname
Date: Thu,  4 Nov 2010 17:05:44 +0100
Message-ID: <1288886745-25977-7-git-send-email-s.hauer@pengutronix.de>
References: <1288886745-25977-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id CE0951038A1
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 17:05:48 +0100 (CET)
In-Reply-To: <1288886745-25977-1-git-send-email-s.hauer@pengutronix.de>
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
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

We have different codecs on the pcm038 (ac97 wm9712 and mc13783).
To make alsactl restore work correctly these should have different
names.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/phycore-ac97.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/imx/phycore-ac97.c b/sound/soc/imx/phycore-ac97.c
index cf46a17..39f2373 100644
--- a/sound/soc/imx/phycore-ac97.c
+++ b/sound/soc/imx/phycore-ac97.c
@@ -38,7 +38,7 @@ static struct snd_soc_dai_link imx_phycore_dai_ac97[] = {
 };
 
 static struct snd_soc_card imx_phycore = {
-	.name		= "PhyCORE-audio",
+	.name		= "PhyCORE-ac97-audio",
 	.dai_link	= imx_phycore_dai_ac97,
 	.num_links	= ARRAY_SIZE(imx_phycore_dai_ac97),
 };
-- 
1.7.2.3
