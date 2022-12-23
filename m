Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECA5C3DA7A
	for <alsa-devel@archiver.kernel.org>; Sun, 25 Dec 2022 18:52:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F4C04B3C;
	Sun, 25 Dec 2022 19:51:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F4C04B3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671994353;
	bh=BAeFRmGJPhMwVuDcTvyl+jy+9Z7wlHTB4D4a/uO2i8U=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=vFTbmGONb2hgi4QkPdZi1WovuxLmUaxYmPkQKtAcfHwhmNvEi8CbDR6x5A/QHYQ9L
	 eq3wNmCi7UflKu5300bgHZSWfuG7bK6fW2X+17D5J9LwwN3S09tKfxs/y7rfEjTLC7
	 gKeLxra87xt4C4JuNLfeO9HeUGWpiXkqXnGFwQaE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 91813F80563;
	Sun, 25 Dec 2022 19:49:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F0515F8047B; Sat, 24 Dec 2022 00:32:59 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ECF8EF8051D
 for <alsa-devel@alsa-project.org>; Sat, 24 Dec 2022 00:32:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ECF8EF8051D
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=quicinc.com header.i=@quicinc.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ZkKhDvgW
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BNNU9uV003339; Fri, 23 Dec 2022 23:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=qUCscePKihIFBMdxnTm5jSbbeyncpZ92egDlWPvRgW0=;
 b=ZkKhDvgWop6EVeKG3r16AkQu2rq/G3xyNaFMzP4+MohhsFJeKuhv48x6llbNz6sxCEmW
 AKWnvz2InpniLZqGYWEkOiU8LdzV5/g3eVCSjZzu7hSExP7PHQJfrYN2Ns6EaK30YPz3
 nX7HKBCoSlfSXtgkntRcw2RVXzQLZu/pi9RCzn3UEhamlKsrkOBnof9xe/vAJx/sSNGb
 7YLQIF3elihvpGRHSz304u91MdWtYVb2kRLeqD6NJYWD6smVHzlcV59EN7894B4t39m/
 2q9pKDJ2BzfdMatq42UT2fS3oZPSxfT8Yao2AzIgdzuwaAtYOvkhEjWaYjSA1LUnV6N6 3Q== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mm3cjx2m5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Dec 2022 23:32:48 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BNNWl84001241
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Dec 2022 23:32:47 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 23 Dec 2022 15:32:46 -0800
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
 <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
 <andersson@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <gregkh@linuxfoundation.org>, <Thinh.Nguyen@synopsys.com>,
 <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
 <agross@kernel.org>
Subject: [RFC PATCH 12/14] sound: soc: qcom: qusb6: Ensure PCM format is
 supported by USB audio device
Date: Fri, 23 Dec 2022 15:31:58 -0800
Message-ID: <20221223233200.26089-13-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221223233200.26089-1-quic_wcheng@quicinc.com>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: NpacJDGBM8v1OaWa7CaWQa7WYsAkJ64T
X-Proofpoint-ORIG-GUID: NpacJDGBM8v1OaWa7CaWQa7WYsAkJ64T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-23_08,2022-12-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=970
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212230197
X-Mailman-Approved-At: Sun, 25 Dec 2022 19:49:45 +0100
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Wesley Cheng <quic_wcheng@quicinc.com>,
 quic_jackp@quicinc.com, quic_plai@quicinc.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Check for if the PCM format is supported during the hw_params callback.  If
the profile is not supported then the userspace ALSA entity will receive an
error, and can take further action.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/soc/qcom/qdsp6/q6usb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6usb.c b/sound/soc/qcom/qdsp6/q6usb.c
index a9da6dec6c6f..128e0974db4e 100644
--- a/sound/soc/qcom/qdsp6/q6usb.c
+++ b/sound/soc/qcom/qdsp6/q6usb.c
@@ -42,7 +42,14 @@ static int q6usb_hw_params(struct snd_pcm_substream *substream,
 			   struct snd_pcm_hw_params *params,
 			   struct snd_soc_dai *dai)
 {
-	return 0;
+	struct q6usb_port_data *data = dev_get_drvdata(dai->dev);
+	int direction = substream->stream;
+	int ret;
+
+	ret = snd_soc_usb_find_format(data->active_idx, params, direction);
+
+	return ret;
+
 }
 static const struct snd_soc_dai_ops q6usb_ops = {
 	.hw_params	= q6usb_hw_params,
