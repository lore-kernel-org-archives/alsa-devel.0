Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F94BECAAA1
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Sep 2022 18:48:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AB3119FD;
	Thu, 15 Sep 2022 20:47:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AB3119FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663267723;
	bh=cVLUR/sctoZ9BH3lPsSsaaMa0uKZqEaM5dCYOsLBx7M=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TQbvjd6Ujj3NAfNW948yFCwbwb097W54PTUWGEcZwH80QMHldEW0uuY+H969gsp4A
	 4oAJ/dIn3yvDgNoVpNVMFbX7oyofclOJrMg8+KBYC5wlL5fYcb0gSZGmbJolSQN+Lw
	 AwjZ/Z+iu2xhtMVX35VsGHqD3f1S9UMt//G/UtxM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED812F8013D;
	Thu, 15 Sep 2022 20:47:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4DA9F80238; Thu, 15 Sep 2022 20:47:50 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DEA7AF800B5
 for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2022 20:47:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DEA7AF800B5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="jUvgwR3P"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FIKH4L025072;
 Thu, 15 Sep 2022 18:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cVLUR/sctoZ9BH3lPsSsaaMa0uKZqEaM5dCYOsLBx7M=;
 b=jUvgwR3PeqdZrI95QE9d0jXqQgjACRt6BB7HFgnLARV4EvWHpy6T0uxQepgSyyv/kg9I
 Pn5CItr7ZQgcUrT0GnOqYnKblEiWtyu2iBhb/BBMOL1KPI1XmTT7Ql7+tGbbDUznAkpy
 6WeAvqlzAcdX5DkkdTxtIhlfNyrkmg5cHv6ZT4Bfr9cyS4ME9KvOIySm7hz1JhBc9Fhs
 zJohHXaNrq4Hor6DClRh+21KfjsrtURHhraXPa7twhT9Su7Aviz7qccx0LnPVZGSWpxF
 b+TSmxjphL1Vc2qJijYhZjmHh5a3aWYE0HWplaQJFnV3h4v0Xtn7uPJQfFXX0lHjhCaV QA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jm90sg5y2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Sep 2022 18:47:45 +0000
Received: from pps.filterd (NASANPPMTA02.qualcomm.com [127.0.0.1])
 by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28FIliWb027849; 
 Thu, 15 Sep 2022 18:47:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 3jkv4cwn8q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Sep 2022 18:47:44 +0000
Received: from NASANPPMTA02.qualcomm.com (NASANPPMTA02.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28FIlh60027836;
 Thu, 15 Sep 2022 18:47:43 GMT
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com
 [10.53.140.1])
 by NASANPPMTA02.qualcomm.com (PPS) with ESMTPS id 28FIlhDX027832
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 Sep 2022 18:47:43 +0000
Received: from [10.110.31.243] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 15 Sep
 2022 11:47:41 -0700
Message-ID: <594aa631-a85f-6a69-e245-9cdd3d07fbd7@quicinc.com>
Date: Thu, 15 Sep 2022 11:47:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 0/4] Make QMI message rules const
Content-Language: en-US
To: Alex Elder <elder@ieee.org>, Alex Elder <elder@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, Kalle Valo <kvalo@kernel.org>, Andy Gross
 <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Konrad
 Dybcio <konrad.dybcio@somainline.org>
References: <20220912232526.27427-1-quic_jjohnson@quicinc.com>
 <f2fa19a1-4854-b270-0776-38993dece03f@ieee.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <f2fa19a1-4854-b270-0776-38993dece03f@ieee.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: yVfXJt7Zc5-wCv_6s3ZXE9OeX7-VYVLk
X-Proofpoint-ORIG-GUID: yVfXJt7Zc5-wCv_6s3ZXE9OeX7-VYVLk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxlogscore=634 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209150113
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
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

Following up on:
On 9/13/2022 6:58 AM, Alex Elder wrote:
> Why aren't you changing the "ei_array" field in
> the qmi_elem_info structure to be const?  Or the
> "ei" field of the qmi_msg_handler structure?  And
> the qmi_response_type_v01_ei array (and so on)?

All of these suggestions were actually part of the prerequisite patch:
<https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=for-next&id=ff6d365898d4d31bd557954c7fc53f38977b491c>

So I think all of the comments have been addressed.

Thanks!
/jeff

