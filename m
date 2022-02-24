Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F09BC433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Feb 2022 15:38:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BE5B1ABC;
	Thu, 24 Feb 2022 16:37:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BE5B1ABC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645717109;
	bh=4k9SFBBHuKqDbJP+oEVQbRZq/ZBVsHPDC6LT4YJmuL0=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PGJ9Tg3+KthfjXDuYdG5+zBVbhC9XFVukpQtEVWjfDGtug41VMzOCxDLdgADaq16X
	 FKNq8btPuNiOe2gU28QCSdUH53EeUwEfC6HszLHM+eyd91Ja/nm9qXG/0cuDwE+64+
	 aojsBBOdy8LSrcrPjKLIGtcKvEKuBxd1FSqppRE4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4509CF804CF;
	Thu, 24 Feb 2022 16:36:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76A52F804D9; Thu, 24 Feb 2022 16:35:59 +0100 (CET)
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
 (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C9514F8030F
 for <alsa-devel@alsa-project.org>; Thu, 24 Feb 2022 16:35:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9514F8030F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="vmGmgP1t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1645716958; x=1677252958;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=bQCvdTZjOf13lFt0yVm8tSWeY3Lwx349NSceH/aq55g=;
 b=vmGmgP1tLyhguOEc6vceKkFVbK0CCWR30Uu7FnulUJJd5WNSSGTUmmQr
 syNr5BdGSZ/Jzuh08JEmtU5fNL3i4n5CZqEmM7vFLuxryFzQdo78a+aOJ
 +yCa2TIVdXcsyJpwW929bUmniNVdOWNBNWeWnQkgOZWQonS36NKybTXKV k=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
 by alexa-out.qualcomm.com with ESMTP; 24 Feb 2022 07:35:51 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2022 07:35:51 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 24 Feb 2022 07:35:51 -0800
Received: from [10.216.20.63] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 24 Feb
 2022 07:35:46 -0800
Message-ID: <5f80c155-cd17-43ca-1eb4-8c57938d306b@quicinc.com>
Date: Thu, 24 Feb 2022 21:05:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v15 01/10] ASoC: qcom: SC7280: Update config for building
 codec dma drivers
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
References: <1645630745-25051-1-git-send-email-quic_srivasam@quicinc.com>
 <1645630745-25051-2-git-send-email-quic_srivasam@quicinc.com>
 <YhZynroGqrGZXeek@sirena.org.uk>
From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YhZynroGqrGZXeek@sirena.org.uk>
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


On 2/23/2022 11:15 PM, Mark Brown wrote:
Thanks for Your time Brown!!!
> On Wed, Feb 23, 2022 at 09:08:56PM +0530, Srinivasa Rao Mandadapu wrote:
>
>> +snd-soc-lpass-cdc-dma-objs := lpass-cdc-dma.o
>>   snd-soc-lpass-hdmi-objs := lpass-hdmi.o
>>   snd-soc-lpass-platform-objs := lpass-platform.o
>>   snd-soc-lpass-ipq806x-objs := lpass-ipq806x.o
>>   snd-soc-lpass-apq8016-objs := lpass-apq8016.o
>>   snd-soc-lpass-sc7180-objs := lpass-sc7180.o
>> +snd-soc-lpass-sc7280-objs := lpass-sc7280.o
> This will break the build given that neither of these source files are
> present yet?
Okay. Sent new patch series with fix.
