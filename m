From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH v2 1/8] regulator: arizona-micsupp: Avoid
	potential memory leak reading init_data
Date: Tue, 28 Mar 2017 15:14:37 +0100
Message-ID: <1490710484-25277-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F842266DEE
 for <alsa-devel@alsa-project.org>; Tue, 28 Mar 2017 16:13:49 +0200 (CEST)
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

 drivers/regulator/arizona-micsupp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
index 22bd714..5e38861 100644
--- a/drivers/regulator/arizona-micsupp.c
+++ b/drivers/regulator/arizona-micsupp.c
@@ -199,7 +199,8 @@ static const struct regulator_init_data arizona_micsupp_ext_default = {
 	.num_consumer_supplies = 1,
 };
 
-static int arizona_micsupp_of_get_pdata(struct arizona *arizona,
+static int arizona_micsupp_of_get_pdata(struct device *dev,
+					struct arizona *arizona,
 					struct regulator_config *config,
 					const struct regulator_desc *desc)
 {
@@ -213,7 +214,7 @@ static int arizona_micsupp_of_get_pdata(struct arizona *arizona,
 	if (np) {
 		config->of_node = np;
 
-		init_data = of_get_regulator_init_data(arizona->dev, np, desc);
+		init_data = of_get_regulator_init_data(dev, np, desc);
 
 		if (init_data) {
 			init_data->consumer_supplies = &micsupp->supply;
@@ -268,8 +269,8 @@ static int arizona_micsupp_probe(struct platform_device *pdev)
 
 	if (IS_ENABLED(CONFIG_OF)) {
 		if (!dev_get_platdata(arizona->dev)) {
-			ret = arizona_micsupp_of_get_pdata(arizona, &config,
-							   desc);
+			ret = arizona_micsupp_of_get_pdata(&pdev->dev, arizona,
+							   &config, desc);
 			if (ret < 0)
 				return ret;
 		}
-- 
2.1.4
