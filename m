From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: sgtl5000: Fix warning due to the lack of
	REGULATOR_CHANGE_VOLTAGE
Date: Tue,  3 Apr 2012 17:02:33 -0300
Message-ID: <1333483353-12273-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C0CDD103D27
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Apr 2012 22:02:43 +0200 (CEST)
Received: by ggni2 with SMTP id i2so63834ggn.38
	for <alsa-devel@alsa-project.org>; Tue, 03 Apr 2012 13:02:41 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, broonie@opensource.wolfsonmicro.com, Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Fix the following warning during kernel boot:

0-000a: 850 <--> 1600 mV at 1200 mV normal 
0-000a: Voltage range but no REGULATOR_CHANGE_VOLTAGE

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 8e92fb8..bad5ba5 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -87,7 +87,8 @@ static struct regulator_init_data ldo_init_data = {
 		.min_uV                 = 850000,
 		.max_uV                 = 1600000,
 		.valid_modes_mask       = REGULATOR_MODE_NORMAL,
-		.valid_ops_mask         = REGULATOR_CHANGE_STATUS,
+		.valid_ops_mask         = REGULATOR_CHANGE_VOLTAGE  |
+						REGULATOR_CHANGE_STATUS,
 	},
 	.num_consumer_supplies = 1,
 	.consumer_supplies = &ldo_consumer[0],
-- 
1.7.1
