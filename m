From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2] ASoC: sgtl5000: Fix warning due to the lack
	of REGULATOR_CHANGE_VOLTAGE
Date: Tue,  3 Apr 2012 18:05:20 -0300
Message-ID: <1333487120-13500-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1169E104339
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Apr 2012 23:05:37 +0200 (CEST)
Received: by yenl1 with SMTP id l1so104602yen.38
	for <alsa-devel@alsa-project.org>; Tue, 03 Apr 2012 14:05:36 -0700 (PDT)
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
Changes since v1: Keep the voltage constant

 sound/soc/codecs/sgtl5000.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 8e92fb8..431c9c1 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -84,8 +84,8 @@ static struct regulator_consumer_supply ldo_consumer[] = {
 
 static struct regulator_init_data ldo_init_data = {
 	.constraints = {
-		.min_uV                 = 850000,
-		.max_uV                 = 1600000,
+		.min_uV                 = 1200000,
+		.max_uV                 = 1200000,
 		.valid_modes_mask       = REGULATOR_MODE_NORMAL,
 		.valid_ops_mask         = REGULATOR_CHANGE_STATUS,
 	},
-- 
1.7.1
