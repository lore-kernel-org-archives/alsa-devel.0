Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CFDC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Feb 2022 10:57:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F332818A8;
	Fri, 25 Feb 2022 11:56:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F332818A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645786659;
	bh=z2fin+a/aEVI5P57wxXBouHP7wWuYfQMyGeqqubpfrk=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LdtgpmLen+x6HS2vcydtHoGYJ8V/BvEqyxL0RK+JIaswQMm5R9WjIAC7EjUTdjDD8
	 dCvu/kQC/EcA0yTXy0F/WIFFLTyV/tKhNZRVNticZfqSv4zq1Ddf9QLUl7WU2L1tKK
	 H0G4yBHdG/8KOC+2H+nFVF48VcbHr6xG+DARzw+Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 91182F800B6;
	Fri, 25 Feb 2022 11:56:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61E32F80132; Fri, 25 Feb 2022 11:56:46 +0100 (CET)
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com
 [199.106.114.39])
 (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BBA8CF800B6
 for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2022 11:56:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BBA8CF800B6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="wRWz2cUA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1645786604; x=1677322604;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=G9dzvbF/4cH2J4t8oHKAF2cRlYPFFAbxeUqSbhr+27A=;
 b=wRWz2cUAsSd0JTKQifDnufvoBojEJVOWtiO9MevJjxWDcGxt4XsGrO9q
 D3doloNCNTDmblug8OqzlTI51I1LyTQanHLLOzrtbfvirBDsmeYZ746fm
 h4XmLgdDUUmfwY0MtPYH272Y9YrJtQTqFmvopofdDHcPNP9aj6els+DFh M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Feb 2022 02:56:38 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2022 02:56:37 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 25 Feb 2022 02:56:37 -0800
Received: from [10.216.25.108] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Fri, 25 Feb
 2022 02:56:31 -0800
Message-ID: <206b65f8-90ba-e15d-d7b7-dce0a01fe936@quicinc.com>
Date: Fri, 25 Feb 2022 16:26:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3] ASoC: codecs: Add power domains support in digital
 macro codecs
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
References: <1645708759-8833-1-git-send-email-quic_srivasam@quicinc.com>
 <Yhfhgrvl38WcNOFu@sirena.org.uk>
From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <Yhfhgrvl38WcNOFu@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, Venkata Prasad Potturu <quic_potturu@quicinc.com>,
 linux-arm-msm@vger.kernel.org, swboyd@chromium.org, tiwai@suse.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, bjorn.andersson@linaro.org,
 rohitkr@codeaurora.org, agross@kernel.org, srinivas.kandagatla@linaro.org,
 quic_plai@quicinc.com, judyhsiao@chromium.org, linux-kernel@vger.kernel.org
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


On 2/25/2022 1:20 AM, Mark Brown wrote:
Thanks for your time Brown!!!
> On Thu, Feb 24, 2022 at 06:49:19PM +0530, Srinivasa Rao Mandadapu wrote:
>
>> +	l_pds->macro_pd = dev_pm_domain_attach_by_name(dev, "macro");
>> +	if (IS_ERR_OR_NULL(l_pds->macro_pd))
>> +		return NULL;
> Shouldn't there also be a DT binding update for the users?
Okay. Will send dt-bindings patch too.
