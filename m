From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: [PATCH 09/16] arm: ux500: Add audio-regulators
Date: Tue, 13 Mar 2012 16:11:36 +0100
Message-ID: <1331651503-16917-10-git-send-email-ola.o.lilja@stericsson.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog103.obsmtp.com (eu1sys200aog103.obsmtp.com
	[207.126.144.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 2315310438B
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 16:12:55 +0100 (CET)
In-Reply-To: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: Ola Lilja <ola.o.lilja@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org

Add regulators Vaud, Vamic1, Vamic2 and Vdmic
used by audio.

Signed-off-by: Ola Lilja <ola.o.lilja@stericsson.com>
---
 arch/arm/mach-ux500/board-mop500-regulators.c |   28 +++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-regulators.c b/arch/arm/mach-ux500/board-mop500-regulators.c
index 2735d03..52426a4 100644
--- a/arch/arm/mach-ux500/board-mop500-regulators.c
+++ b/arch/arm/mach-ux500/board-mop500-regulators.c
@@ -74,6 +74,26 @@ static struct regulator_consumer_supply ab8500_vtvout_consumers[] = {
 	REGULATOR_SUPPLY("vddadc", "ab8500-gpadc.0"),
 };
 
+static struct regulator_consumer_supply ab8500_vaud_consumers[] = {
+	/* AB8500 audio-codec main supply */
+	REGULATOR_SUPPLY("vaud", "ab8500-codec.0"),
+};
+
+static struct regulator_consumer_supply ab8500_vamic1_consumers[] = {
+	/* AB8500 audio-codec Mic1 supply */
+	REGULATOR_SUPPLY("vamic1", "ab8500-codec.0"),
+};
+
+static struct regulator_consumer_supply ab8500_vamic2_consumers[] = {
+	/* AB8500 audio-codec Mic2 supply */
+	REGULATOR_SUPPLY("vamic2", "ab8500-codec.0"),
+};
+
+static struct regulator_consumer_supply ab8500_vdmic_consumers[] = {
+	/* AB8500 audio-codec DMic supply */
+	REGULATOR_SUPPLY("vdmic", "ab8500-codec.0"),
+};
+
 static struct regulator_consumer_supply ab8500_vintcore_consumers[] = {
 	/* SoC core supply, no device */
 	REGULATOR_SUPPLY("v-intcore", NULL),
@@ -323,6 +343,8 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.name = "V-AUD",
 			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vaud_consumers),
+		.consumer_supplies = ab8500_vaud_consumers,
 	},
 	/* supply for v-anamic1 VAMic1-LDO */
 	[AB8500_LDO_ANAMIC1] = {
@@ -330,6 +352,8 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.name = "V-AMIC1",
 			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vamic1_consumers),
+		.consumer_supplies = ab8500_vamic1_consumers,
 	},
 	/* supply for v-amic2, VAMIC2 LDO, reuse constants for AMIC1 */
 	[AB8500_LDO_ANAMIC2] = {
@@ -337,6 +361,8 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.name = "V-AMIC2",
 			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vamic2_consumers),
+		.consumer_supplies = ab8500_vamic2_consumers,
 	},
 	/* supply for v-dmic, VDMIC LDO */
 	[AB8500_LDO_DMIC] = {
@@ -344,6 +370,8 @@ struct regulator_init_data ab8500_regulators[AB8500_NUM_REGULATORS] = {
 			.name = "V-DMIC",
 			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
 		},
+		.num_consumer_supplies = ARRAY_SIZE(ab8500_vdmic_consumers),
+		.consumer_supplies = ab8500_vdmic_consumers,
 	},
 	/* supply for v-intcore12, VINTCORE12 LDO */
 	[AB8500_LDO_INTCORE] = {
-- 
1.7.8.3
