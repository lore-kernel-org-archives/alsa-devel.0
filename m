Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B773BC4321E
	for <alsa-devel@archiver.kernel.org>; Mon, 28 Nov 2022 07:50:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F0C021638;
	Mon, 28 Nov 2022 08:49:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F0C021638
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669621824;
	bh=9wMt4XJ02uO136M3LKdeTxtfRlak5EJZqsYAf7hk75U=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=D06pYOhP5SSK8BTS/LC7Nq774cWlbVtRaK4jwvNiB6TAj+mgGvhhLpFMYrtP1svAU
	 4Ojp4Q38VLIHKmgMCLRaUxgZFLLcTdvZY1gbwMU9YdiTPOYxOGHomW/xVBxzeie5Av
	 0rGw3Qw9W/o2mLrOL1fLg2XGVX1ODEGO5UsGFPN0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6100BF800B6;
	Mon, 28 Nov 2022 08:49:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 481B1F8020D; Mon, 28 Nov 2022 08:49:31 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9996BF800B6
 for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2022 08:49:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9996BF800B6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="pRMT6liR"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AS5pvbm013085; Mon, 28 Nov 2022 07:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=EvOYNr5YwYsIS+9C2KVrBrkRa6q4/RNX1EkrAtgxSz0=;
 b=pRMT6liRzaCzEJ+gyyAB9TSBPVuSRM2WcXU9/mavI0Kkf4QQqKhYNqhf2GFRiqVxmoJ4
 if1wzu6Fb3WewGZxUy6u9a8z8d494yKiKvZBnK9SM4bubVGharcdcvAvcFyiOzk1RYds
 wAGJ2S5F2ncHHjbjZozbF2KCTC5NVXkJCyWUsMeA+kLcYe4jPE0KFbXHrCpQszCozQrv
 o6vhHFj0V1NXDQ0WnjFITdHdc2oGJgNsaKASUWZcPQvcUmlKNmEADFltw/OB3eAVhG/n
 rKuWSoccanMC2q/z9TJuXpNy8RD54Z+yXpEtCcF4dkuDQ09McUfzlUFsUK4DE70m2MVF dg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3m3bjrkpca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Nov 2022 07:49:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AS7nLi5009840
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Nov 2022 07:49:21 GMT
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 27 Nov 2022 23:49:15 -0800
From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <robh+dt@kernel.org>, <quic_plai@quicinc.com>,
 <bgoswami@quicinc.com>, <perex@perex.cz>, <tiwai@suse.com>,
 <srinivas.kandagatla@linaro.org>, <quic_rohkumar@quicinc.com>,
 <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
 <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
 <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>
Subject: [PATCH] ASoC: qcom: lpass-sc7180: Add system suspend/resume PM ops
Date: Mon, 28 Nov 2022 13:19:02 +0530
Message-ID: <1669621742-28524-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: oyKsuhqYmd0bM19Akig8BJRQ_oIBWATw
X-Proofpoint-GUID: oyKsuhqYmd0bM19Akig8BJRQ_oIBWATw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-28_06,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211280061
Cc: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Update lpass sc7180 platform driver with PM ops, such as
system supend and resume callbacks.
This update is required to disable clocks during supend and
avoid XO shutdown issue.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Tested-by: Rahul Ajmeriya <quic_rajmeriy@quicinc.com>
---
 sound/soc/qcom/lpass-sc7180.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/qcom/lpass-sc7180.c b/sound/soc/qcom/lpass-sc7180.c
index 77a556b..6ad1c5b 100644
--- a/sound/soc/qcom/lpass-sc7180.c
+++ b/sound/soc/qcom/lpass-sc7180.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <dt-bindings/sound/sc7180-lpass.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
@@ -156,10 +157,34 @@ static int sc7180_lpass_exit(struct platform_device *pdev)
 	struct lpass_data *drvdata = platform_get_drvdata(pdev);
 
 	clk_bulk_disable_unprepare(drvdata->num_clks, drvdata->clks);
+	return 0;
+}
+
+static int sc7180_lpass_dev_resume(struct device *dev)
+{
+	int ret = 0;
+	struct lpass_data *drvdata = dev_get_drvdata(dev);
 
+	ret = clk_bulk_prepare_enable(drvdata->num_clks, drvdata->clks);
+	if (ret) {
+		dev_err(dev, "sc7180 clk prepare and enable failed\n");
+		return ret;
+	}
+	return ret;
+}
+
+static int sc7180_lpass_dev_suspend(struct device *dev)
+{
+	struct lpass_data *drvdata = dev_get_drvdata(dev);
+
+	clk_bulk_disable_unprepare(drvdata->num_clks, drvdata->clks);
 	return 0;
 }
 
+static const struct dev_pm_ops sc7180_lpass_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sc7180_lpass_dev_suspend, sc7180_lpass_dev_resume)
+};
+
 static struct lpass_variant sc7180_data = {
 	.i2sctrl_reg_base	= 0x1000,
 	.i2sctrl_reg_stride	= 0x1000,
@@ -293,6 +318,7 @@ static struct platform_driver sc7180_lpass_cpu_platform_driver = {
 	.driver = {
 		.name = "sc7180-lpass-cpu",
 		.of_match_table = of_match_ptr(sc7180_lpass_cpu_device_id),
+		.pm = &sc7180_lpass_pm_ops,
 	},
 	.probe = asoc_qcom_lpass_cpu_platform_probe,
 	.remove = asoc_qcom_lpass_cpu_platform_remove,
-- 
2.7.4

