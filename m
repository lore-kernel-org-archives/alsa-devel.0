Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71980C04FFE
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Apr 2024 15:58:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DCAB32972;
	Thu, 18 Apr 2024 17:58:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DCAB32972
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1713455925;
	bh=8M0cP8H9SmjO68TUZQ2nfeZxnXcBncMZDGae/QHKAmc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=n13dIyfnMJViuEDqN0WUxyfyenv/6O5pgXNcjnuSKx1Kpdwk0z6nSwfz2y/dKbdBj
	 bnzaFXFQMl1CVHuKljaEg6thCE0J+kjk1dfO+aBmzKcmSP4lc3FbUmbbKLHg03/Fu5
	 tMA75N+vKRlSdWWLv0GRusKadtKPDq7AHqZ/naM4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 95206F80CBF; Thu, 18 Apr 2024 17:53:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F125F89614;
	Thu, 18 Apr 2024 17:53:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C37DCF8025A; Wed, 17 Apr 2024 11:34:47 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7BFE2F80124
	for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2024 11:34:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7BFE2F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=quicinc.com header.i=@quicinc.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=AMSbUtKA
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43H4tNdD004668;
	Wed, 17 Apr 2024 09:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=ebN3LYyo3nXC
	VircSI3raiUdshoMu646eNhmWXeH6PE=; b=AMSbUtKAoSWaqwXGyC64sY1F80Cx
	9voYOAUomppVn4sK0dm+rxyf5ysVsozn5qI1/ZEPTyuwyvHLgbGsmxe9k7bOZrUa
	pVIbTDZLeIo/woCldonMbgVh5pZthaTHoa+KNh1o37DnjNipB+LFhTbD7cREy3UG
	JlMROHckYXDx8wD0ltgUBO4LCGR3abh5M+q/Pxzzy4/MFwmbd5PYKIczs0r60JrC
	ORPjt/vIbz/fFj3MrlscWQcVSJEXoxl8mMC3Jc8C8J4Cv4a1hRVWS9HrqS56ksVl
	Y+TG0kIAz0jRkKsZZ0SUNMoBIIQ60CZzWg9f0rYANVwP6kWXBFg4fPdvXw==
Received: from apblrppmta01.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj7tr0jq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 09:34:33 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id
 43H9YBJV008391;
	Wed, 17 Apr 2024 09:34:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3xfk4kteec-1;
	Wed, 17 Apr 2024 09:34:11 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com
 [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43H9YB87008382;
	Wed, 17 Apr 2024 09:34:11 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-vdadhani-hyd.qualcomm.com
 [10.213.106.28])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 43H9YBMF008381;
	Wed, 17 Apr 2024 09:34:11 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 4047106)
	id F0ACE500C6C; Wed, 17 Apr 2024 15:04:09 +0530 (+0530)
From: Viken Dadhaniya <quic_vdadhani@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
        quic_anupkulk@quicinc.com, quic_cchiluve@quicinc.com,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>
Subject: [PATCH v2] slimbus: stream: Add null pointer check for client APIs
Date: Wed, 17 Apr 2024 15:04:08 +0530
Message-Id: <20240417093408.28639-1-quic_vdadhani@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: vyo812iT0-97hYtBDcbyzii2LPC1_bTk
X-Proofpoint-GUID: vyo812iT0-97hYtBDcbyzii2LPC1_bTk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_08,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxlogscore=925
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170066
X-MailFrom: vdadhani@qualcomm.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: FO7DXEYZDWGC2SIUOSUQGIQTBJOOVXAC
X-Message-ID-Hash: FO7DXEYZDWGC2SIUOSUQGIQTBJOOVXAC
X-Mailman-Approved-At: Thu, 18 Apr 2024 15:52:30 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Due to incorrect sequrnce of slimbus APIs called by client
driver, facing system crash in slimbus framework APIs.

To prevent system crash, add NULL pointer check in
enable/disable/prepare/unprepare/free APIs.

Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
---
v1 -> v2:
- Update commit log.
- Update debug logs.

v1 Link: https://lore.kernel.org/linux-arm-msm/ZhgIHHP1FUeCr+vx@hu-bjorande-lv.qualcomm.com/T/
---
---
 drivers/slimbus/stream.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
index 1d6b38657917..76d0579cbf53 100644
--- a/drivers/slimbus/stream.c
+++ b/drivers/slimbus/stream.c
@@ -202,10 +202,16 @@ static int slim_get_prate_code(int rate)
 int slim_stream_prepare(struct slim_stream_runtime *rt,
 			struct slim_stream_config *cfg)
 {
-	struct slim_controller *ctrl = rt->dev->ctrl;
+	struct slim_controller *ctrl;
 	struct slim_port *port;
 	int num_ports, i, port_id, prrate;
 
+	if (!rt || !cfg) {
+		pr_err("Invalid stream rt or cfg\n");
+		return -EINVAL;
+	}
+
+	ctrl = rt->dev->ctrl;
 	if (rt->ports) {
 		dev_err(&rt->dev->dev, "Stream already Prepared\n");
 		return -EINVAL;
@@ -358,9 +364,15 @@ int slim_stream_enable(struct slim_stream_runtime *stream)
 {
 	DEFINE_SLIM_BCAST_TXN(txn, SLIM_MSG_MC_BEGIN_RECONFIGURATION,
 				3, SLIM_LA_MANAGER, NULL);
-	struct slim_controller *ctrl = stream->dev->ctrl;
+	struct slim_controller *ctrl;
 	int ret, i;
 
+	if (!stream) {
+		pr_err("Invalid stream\n");
+		return -EINVAL;
+	}
+
+	ctrl = stream->dev->ctrl;
 	if (ctrl->enable_stream) {
 		ret = ctrl->enable_stream(stream);
 		if (ret)
@@ -411,12 +423,18 @@ int slim_stream_disable(struct slim_stream_runtime *stream)
 {
 	DEFINE_SLIM_BCAST_TXN(txn, SLIM_MSG_MC_BEGIN_RECONFIGURATION,
 				3, SLIM_LA_MANAGER, NULL);
-	struct slim_controller *ctrl = stream->dev->ctrl;
+	struct slim_controller *ctrl;
 	int ret, i;
 
+	if (!stream) {
+		pr_err("Invalid stream");
+		return -EINVAL;
+	}
+
 	if (!stream->ports || !stream->num_ports)
 		return -EINVAL;
 
+	ctrl = stream->dev->ctrl;
 	if (ctrl->disable_stream)
 		ctrl->disable_stream(stream);
 
@@ -448,6 +466,11 @@ int slim_stream_unprepare(struct slim_stream_runtime *stream)
 {
 	int i;
 
+	if (!stream) {
+		pr_err("Invalid stream\n");
+		return -EINVAL;
+	}
+
 	if (!stream->ports || !stream->num_ports)
 		return -EINVAL;
 
@@ -476,8 +499,14 @@ EXPORT_SYMBOL_GPL(slim_stream_unprepare);
  */
 int slim_stream_free(struct slim_stream_runtime *stream)
 {
-	struct slim_device *sdev = stream->dev;
+	struct slim_device *sdev;
+
+	if (!stream) {
+		pr_err("Invalid stream\n");
+		return -EINVAL;
+	}
 
+	sdev = stream->dev;
 	spin_lock(&sdev->stream_list_lock);
 	list_del(&stream->node);
 	spin_unlock(&sdev->stream_list_lock);
-- 
2.17.1

