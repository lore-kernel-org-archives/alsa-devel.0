From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 1/1] ASoC: sti-sas: fix x86 compilation issue.
Date: Thu, 16 Jul 2015 10:43:20 +0200
Message-ID: <1437036200-22760-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id AA3902661B0
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 10:45:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org

Fixes for compilation warnings and errors reported by Kbuild test robot
for x86_64 and i386.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/codecs/sti-sas.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/sti-sas.c b/sound/soc/codecs/sti-sas.c
index 32db2c2..39f3c8b 100644
--- a/sound/soc/codecs/sti-sas.c
+++ b/sound/soc/codecs/sti-sas.c
@@ -227,8 +227,8 @@ static int stih416_dac_probe(struct snd_soc_dai *dai)
 	dac->rst = devm_reset_control_get(codec->dev, "dac_rst");
 	if (IS_ERR(dac->rst)) {
 		dev_err(dai->codec->dev,
-			"%s: ERROR: DAC reset control not defined (%d)!\n",
-			__func__, (int)dac->rst);
+			"%s: ERROR: DAC reset control not defined !\n",
+			__func__);
 		dac->rst = NULL;
 		return -EFAULT;
 	}
@@ -547,6 +547,7 @@ static int sti_sas_driver_probe(struct platform_device *pdev)
 {
 	struct device_node *pnode = pdev->dev.of_node;
 	struct sti_sas_data *drvdata;
+	const struct of_device_id *of_id;
 
 	/* Allocate device structure */
 	drvdata = devm_kzalloc(&pdev->dev, sizeof(struct sti_sas_data),
@@ -555,12 +556,13 @@ static int sti_sas_driver_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* Populate data structure depending on compatibility */
-	if (!of_match_node(sti_sas_dev_match, pnode)->data) {
+	of_id = of_match_node(sti_sas_dev_match, pnode);
+	if (!of_id->data) {
 		dev_err(&pdev->dev, "data associated to device is missing");
 		return -EINVAL;
 	}
 
-	drvdata->dev_data = of_match_node(sti_sas_dev_match, pnode)->data;
+	drvdata->dev_data = (struct sti_sas_dev_data *)of_id->data;
 
 	/* Initialise device structure */
 	drvdata->dev = &pdev->dev;
-- 
1.9.1
