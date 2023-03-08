Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2171C678D5
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Mar 2023 00:05:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA047189D;
	Thu,  9 Mar 2023 01:05:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA047189D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678320357;
	bh=APNZOKy8WyIVTugSnvyRdtQG0ls1rSHHumcPWAlJYZg=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=AHEof7WFuw00A5WumtQgbt+kzpSvxkL3Ocw0H8cWbnOkLTRckWMERXWzPNCSG+Q1f
	 JfDTkuuqD73SnjzqSACbOnJL+B70vmYVdOBILMDrDU6YU13XsmmUgCCTlz32BUsc2q
	 tszg5LUcqlp3eFyjSqsBqvTkmRkKwR31pNkAlXxI=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 00A1BF805FD;
	Thu,  9 Mar 2023 00:59:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2E60CF805C2; Thu,  9 Mar 2023 00:59:06 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7D0F4F80558
	for <alsa-devel@alsa-project.org>; Thu,  9 Mar 2023 00:58:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7D0F4F80558
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=quicinc.com header.i=@quicinc.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=ITSbkTxs
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 328JJAma027605;
	Wed, 8 Mar 2023 23:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=mH3cxz0vSi50A1zuyripsixnqQasru/MCDeZuPSh/Fk=;
 b=ITSbkTxsMmQX8cEzl7g+lekYGlnBZXogGauCWZj4aFQMvKKQt7qrXdwI4GLcQtG+E0Mq
 auzJVMxoEEq4s8QFIGFs2pKG62UnzVxGj8Cm1g2b50wusuJlY1n5EdJ287+e4MNkUxKl
 G8whPRmJXAkVrgYt1aakvA2SVff2ckaKv6gMi6rRwvMvL48n3pHzj8P6jwAhbbZLQd7C
 M2sqa2lvmnFxzxP8MwjqCi8ddyNFEfeQJKRZEoIKsdXvsJLUem/lDiQKBu62nMmsOxRX
 gURSpZZ52en3HfQDytTQIq8BlAOM1G50c62R0igu0U/H7oZCUO0dFQjkCoQV/cYVRQs5 tQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p6v2dsav6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Mar 2023 23:58:13 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id
 328NwCTA017176
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Mar 2023 23:58:12 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Wed, 8 Mar 2023 15:58:12 -0800
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <agross@kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <bgoswami@quicinc.com>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <tiwai@suse.com>
Subject: [PATCH v3 26/28] sound: usb: qc_audio_offload: Use card and PCM index
 from QMI request
Date: Wed, 8 Mar 2023 15:57:49 -0800
Message-ID: <20230308235751.495-27-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230308235751.495-1-quic_wcheng@quicinc.com>
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: BAbqpL8ZfQfh_1nXJ8Fd_jNAytSKX_F6
X-Proofpoint-ORIG-GUID: BAbqpL8ZfQfh_1nXJ8Fd_jNAytSKX_F6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303080200
Message-ID-Hash: T7RSYVUYE5Z7JAORBA3HSDIWHKED7RBG
X-Message-ID-Hash: T7RSYVUYE5Z7JAORBA3HSDIWHKED7RBG
X-MailFrom: quic_wcheng@quicinc.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-usb@vger.kernel.org, quic_jackp@quicinc.com, quic_plai@quicinc.com,
 Wesley Cheng <quic_wcheng@quicinc.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T7RSYVUYE5Z7JAORBA3HSDIWHKED7RBG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Utilize the card and PCM index coming from the USB QMI stream request.
This field follows what is set by the ASoC USB backend, and could
potentially carry information about a specific device selected through the
ASoC USB backend.  The backend also has information about the last USB
sound device plugged in, so it can choose to select the last device plugged
in, accordingly.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/usb/qcom/qc_audio_offload.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index 7d6e7f946a47..51241c4eafab 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -114,8 +114,6 @@ struct uaudio_qmi_dev {
 	bool er_mapped;
 	/* reference count to number of possible consumers */
 	atomic_t qdev_in_use;
-	/* idx to last udev card number plugged in */
-	unsigned int last_card_num;
 };
 
 struct uaudio_dev {
@@ -990,7 +988,7 @@ static int prepare_qmi_response(struct snd_usb_substream *subs,
 	assoc = iface->intf_assoc;
 	pcm_dev_num = (req_msg->usb_token & SND_PCM_DEV_NUM_MASK) >> 8;
 	xfer_buf_len = req_msg->xfer_buff_size;
-	card_num = uaudio_qdev->last_card_num;
+	card_num = (req_msg->usb_token & SND_PCM_CARD_NUM_MASK) >> 16;
 
 	alts = &iface->altsetting[subs->cur_audiofmt->altset_idx];
 	altsd = get_iface_desc(alts);
@@ -1375,8 +1373,7 @@ static void handle_uaudio_stream_req(struct qmi_handle *handle,
 
 	direction = (req_msg->usb_token & SND_PCM_STREAM_DIRECTION);
 	pcm_dev_num = (req_msg->usb_token & SND_PCM_DEV_NUM_MASK) >> 8;
-	pcm_card_num = req_msg->enable ? uaudio_qdev->last_card_num :
-				ffs(uaudio_qdev->card_slot) - 1;
+	pcm_card_num = (req_msg->usb_token & SND_PCM_CARD_NUM_MASK) >> 16;
 	if (pcm_card_num >= SNDRV_CARDS) {
 		ret = -EINVAL;
 		goto response;
@@ -1560,7 +1557,6 @@ static void qc_usb_audio_offload_probe(struct snd_usb_audio *chip)
 	mutex_unlock(&qdev_mutex);
 
 	uadev[chip->card->number].chip = chip;
-	uaudio_qdev->last_card_num = chip->card->number;
 
 	snd_soc_usb_connect(usb_get_usb_backend(udev), chip->card->number,
 				chip->index, chip->pcm_devs);
