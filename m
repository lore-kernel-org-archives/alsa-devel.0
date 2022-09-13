Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70351C54EE9
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Sep 2022 22:20:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A425717AD;
	Wed, 14 Sep 2022 00:19:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A425717AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663107625;
	bh=2d1K7ubo9Lwjea1+lrxcdrGgZkzwqp3cP5OiFJHWeBM=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WuANtyhdo/iBSEJJkvJYS0UGiQFDY3p/Zs8LEyMhESaDl+LAarw2JDlrE5oT1LDCS
	 YaEkAeNG/0ahhnXvv1OM6lmbrOyNQUZ08eQiZbqpfPSQ/l+LHiJpSNshrj+5k//9UZ
	 ihnFz3MNA68F1i4Ilwt8ry4uq+dm1sotd+buCoS8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3D414F801EC;
	Wed, 14 Sep 2022 00:19:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 91726F8008E; Wed, 14 Sep 2022 00:19:33 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4929DF8008E
 for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2022 00:19:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4929DF8008E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="eizo4ukj"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DLjgDe004063;
 Tue, 13 Sep 2022 22:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=yzzZB1SxLFlIvl1Xn7ozpnDBNdbA2+CmLlEXeuuFAdc=;
 b=eizo4ukjNNJrHLlrqwZuBVI7en3QTz0RVVFrrNwGb88hJlVdyUB8DqMUDtM0MG/4Rmf2
 J1GJ6oPyDkmsqhzqo1Ley5kKMtNEtuvd9xleVBCK5znZDdPdfpLHENcl0b/dI4dJ76vE
 GUF9I7Zvg2NOOMu1JEoSmF1IebQGVZpvISNfK7yuc1e8otq5DGb3DkiPSv0SlFrf46y7
 wY9E+KC91pyfd96JhlbiCQTktlA+0THj8jPYOa203qBLRaAuy9g58MCPycmNbayZn4Re
 SQpJXF+JRQJJ+i9/FFy+mY0m17PNsFy4PlGWbgf2mLRnaM7us+O62wbIBH2roDbxZjhj hA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjxyu8h10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Sep 2022 22:19:23 +0000
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 28DMJNDl007615; 
 Tue, 13 Sep 2022 22:19:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 3jj1uby63r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Sep 2022 22:19:23 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28DMJMtM007607;
 Tue, 13 Sep 2022 22:19:22 GMT
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 28DMJMAF007606
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 13 Sep 2022 22:19:22 +0000
Received: from [10.110.52.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 15:19:21 -0700
Message-ID: <9928eb0a-ffa2-8798-315c-1de6c2de20e4@quicinc.com>
Date: Tue, 13 Sep 2022 15:19:20 -0700
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
 <5b0543dc-4db8-aa33-d469-0e185c82b221@quicinc.com>
 <ac428312-745c-490e-dfb4-2208913c27c1@ieee.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ac428312-745c-490e-dfb4-2208913c27c1@ieee.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: Rjs1ao0nM8fb0h5knp2-TA3UDknUCU8n
X-Proofpoint-ORIG-GUID: Rjs1ao0nM8fb0h5knp2-TA3UDknUCU8n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_10,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=919 bulkscore=0
 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209130103
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

On 9/13/2022 1:21 PM, Alex Elder wrote:
> I cherry-picked the one commit, and downloaded the series
> and found no new build warnings.  Checkpatch would prefer
> you used "ff6d365898d4" rather than "ff6d365898d" for the
> commit ID, but that's OK.

I'll clean that up in a v2

> 
> Anyway, for the whole series:
> 
> Reviewed-by: Alex Elder <elder@linaro.org>

Thanks!


