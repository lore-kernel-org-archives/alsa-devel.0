Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488CDC4167B
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Dec 2022 21:08:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BEACD7E0F;
	Tue, 27 Dec 2022 22:07:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BEACD7E0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1672175323;
	bh=TKok3JobIwyGo4EHV6lMfILMEkttNQSETmCffIv0M+4=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=QrbvXzf0qQKUOcasyFMEw9g84FKN9BSItimOUE892lhpOnqFFQx+Y0s78wZ27cNql
	 UuoD192jfEkJ9h8hVZwPP698WlM1fu2YcFJL5L+S13JaaL/BOryQR0X/V0E3Pvnw/E
	 KA9/Q0lCZMqFab7buxY5RO12F+gT6eYUHmIHXYBE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 617B0F804E4;
	Tue, 27 Dec 2022 22:07:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 059CCF80524; Tue, 27 Dec 2022 22:07:52 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B886F804B4
 for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2022 22:07:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B886F804B4
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=quicinc.com header.i=@quicinc.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=E0uUFz9M
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2BRKnHDb006665; Tue, 27 Dec 2022 21:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=90sLDS6yNbgqGEPFzP0/hRUZPRIlPL5t8sK528cXKO0=;
 b=E0uUFz9MVA+yMRs3Bti3+ySQOfCnyun5gJVUOOr+9wT8yJcKTmmNbngO+tFNaLr/ID52
 X++1tu8bS7m4oB1tcIv4SfdLbzJ1TWmx94glIULu/KgGhOM6ghEpgUL07l1VwTV13Qbd
 E+W3uO+1cbjOS16roenEZrR3F+pgvHVs4PvXraMrK+IYNJ8umm4QRQmc5cqhegsb9weL
 JO/o/bgm3FJDXHCYhmD2DcX5kM2Y6Hn9hRb30WspBRErHRcfJnH5P2EqdT8uCHUg8khf
 JNQXxhjzM/eaUO1GkfceYQxUtBkTaFUZApbVh4j+GfnXEgDO8g7vBEkkdVW83I8iHzOU Yg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mr1r1guy7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Dec 2022 21:07:48 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com
 [10.47.209.197])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BRL7l2P020720
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Dec 2022 21:07:47 GMT
Received: from [10.110.31.102] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 27 Dec
 2022 13:07:46 -0800
Message-ID: <e1203849-01b4-b196-36f3-76d58dd7c724@quicinc.com>
Date: Tue, 27 Dec 2022 13:07:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 06/14] usb: core: hcd: Introduce USB HCD APIs for
 interrupter management
Content-Language: en-US
To: Alan Stern <stern@rowland.harvard.edu>
References: <20221223233200.26089-1-quic_wcheng@quicinc.com>
 <20221223233200.26089-7-quic_wcheng@quicinc.com>
 <Y6ca8IKLK9g497Qv@rowland.harvard.edu>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <Y6ca8IKLK9g497Qv@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: KdP-7w-uMKR4pSh2fA3koT6YVSP7mIVD
X-Proofpoint-ORIG-GUID: KdP-7w-uMKR4pSh2fA3koT6YVSP7mIVD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_16,2022-12-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=549 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212270176
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
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, bgoswami@quicinc.com,
 mathias.nyman@intel.com, gregkh@linuxfoundation.org, andersson@kernel.org,
 tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, agross@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, Thinh.Nguyen@synopsys.com,
 quic_plai@quicinc.com, linux-kernel@vger.kernel.org, quic_jackp@quicinc.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi Alan,

On 12/24/2022 7:29 AM, Alan Stern wrote:
> On Fri, Dec 23, 2022 at 03:31:52PM -0800, Wesley Cheng wrote:
>> For USB HCDs that can support multiple USB interrupters, expose functions
>> that class drivers can utilize for setting up secondary interrupters.
>> Class drivers can pass this information to its respective clients, i.e.
>> a dedicated DSP.
>>
>> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
>> ---
>>   drivers/usb/core/hcd.c  | 86 +++++++++++++++++++++++++++++++++++++++++
>>   include/linux/usb.h     |  7 ++++
>>   include/linux/usb/hcd.h | 16 +++++++-
>>   3 files changed, 108 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>> index 8300baedafd2..90ead90faf1d 100644
>> --- a/drivers/usb/core/hcd.c
>> +++ b/drivers/usb/core/hcd.c
> 
>> +/**
>> + * usb_hcd_stop_endpoint - Halt USB EP transfers
>> + * @udev: usb device
>> + * @ep: usb ep to stop
>> + *
>> + * Stop pending transfers on a specific USB endpoint.
>> + **/
>> +int usb_hcd_stop_endpoint(struct usb_device *udev,
>> +					struct usb_host_endpoint *ep)
>> +{
>> +	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
>> +	int ret = 0;
>> +
>> +	if (hcd->driver->stop_endpoint)
>> +		ret = hcd->driver->stop_endpoint(hcd, udev, ep);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_hcd_stop_endpoint);
> 
> You know, there already is a function that does this.  It's named
> usb_hcd_flush_endpoint().  No need to add another function that does the
> same thing.
> 

Thanks for the suggestion and review.

Hmmm...maybe I should change the name of the API then to avoid the 
confusion.  Yes, usb_hcd_flush_endpoint() does ensure that URBs 
submitted to the EP are stopped.  However, with this offloading concept, 
we aren't actually submitting URBs from the main processor, so the 
ep->urb_list will be empty.

This means the usb_hcd_flush_endpoint() API won't actually do anything. 
  What we need is to ensure that we send a XHCI stop ep command to the 
controller.

Thanks
Wesley Cheng
