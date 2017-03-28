From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 2/8] regulator: arizona-ldo1: Avoid
	potential memory leak reading init_data
Date: Tue, 28 Mar 2017 15:14:38 +0100
Message-ID: <1490710484-25277-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1490710484-25277-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 26CB626648D
 for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2017 16:13:56 +0200 (CEST)
In-Reply-To: <1490710484-25277-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

The device argument passed to of_get_regulator_init_data is used to
do some devres memory allocation. Currently the driver passes the MFD
device pointer to this function, this could result in the init_data
allocation being leaked if the regulator is unbound but the MFD isn't.

Correct this issue by correctly passing the local platform device.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---

New patch in the series since v1.

 drivers/regulator/arizona-ldo1.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index e76d094..b726fa1 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -186,7 +186,8 @@ static const struct regulator_init_data arizona_ldo1_wm5110 = {
 	.num_consumer_supplies = 1,
 };
 
-static int arizona_ldo1_of_get_pdata(struct arizona *arizona,
+static int arizona_ldo1_of_get_pdata(struct device *dev,
+				     struct arizona *arizona,
 				     struct regulator_config *config,
 				     const struct regulator_desc *desc)
 {
@@ -212,8 +213,7 @@ static int arizona_ldo1_of_get_pdata(struct arizona *arizona,
 	if (init_node) {
 		config->of_node = init_node;
 
-		init_data = of_get_regulator_init_data(arizona->dev, init_node,
-						       desc);
+		init_data = of_get_regulator_init_data(dev, init_node, desc);
 
 		if (init_data) {
 			init_data->consumer_supplies = &ldo1->supply;
@@ -283,7 +283,8 @@ static int arizona_ldo1_probe(struct platform_device *pdev)
 
 	if (IS_ENABLED(CONFIG_OF)) {
 		if (!dev_get_platdata(arizona->dev)) {
-			ret = arizona_ldo1_of_get_pdata(arizona, &config, desc);
+			ret = arizona_ldo1_of_get_pdata(&pdev->dev, arizona,
+							&config, desc);
 			if (ret < 0)
 				return ret;
 		}
-- 
2.1.4
