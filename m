Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEBEC3F6B0
	for <alsa-devel@archiver.kernel.org>; Thu, 28 Jul 2022 13:07:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 06B191638;
	Thu, 28 Jul 2022 15:06:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 06B191638
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1659013641;
	bh=qv+oUCMtEKYuwXz5FJ/D1vECfnU6sYKYG+qSSUVQFiE=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yqg0aD6MQpx+APtCFNp6p9eKzuN3C/wkrnUKlSPgxmEZq/ei7cWjlUrQPx6h9GaPy
	 nDPMMezQGls0zZ89jap2loC7JoQzDnlwYe0Tv9Nh2R+/O6/AgsCch5SGnJQfnqtnwQ
	 rYc0biWhI1Vx+Y7sxpunQNer48SrZP6IR9U8Je0U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7EA7BF8015B;
	Thu, 28 Jul 2022 15:06:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BE343F80430; Thu, 28 Jul 2022 15:06:28 +0200 (CEST)
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com
 [199.106.114.38])
 (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2112F80141
 for <alsa-devel@alsa-project.org>; Thu, 28 Jul 2022 15:06:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2112F80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="Bw0dPARJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1659013587; x=1690549587;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=b/wEQ01RTadmT60aE0Fd5qVRKAPrU1I1CCnWHz9Go5Y=;
 b=Bw0dPARJng9fH9Q4nftN0CFrJTxVl8OJNL2h4IbRnHNG4DOBvi3BL/ZQ
 PZlCQ+8ztyCG06ptuTr9jukK7X//NaopPOg5o1J86Im27rA7oxuhfZl38
 TYNYNJVgIN6MT0o+gpFkiRT7H3BWgRwJ41E6V1s/JaW2+rxWcWQzuuCkE Y=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 28 Jul 2022 06:06:21 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2022 06:06:21 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 28 Jul 2022 06:06:20 -0700
Received: from [10.216.53.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 28 Jul
 2022 06:06:15 -0700
Message-ID: <00cd5620-a276-6e55-8997-fbf8285d9a9a@quicinc.com>
Date: Thu, 28 Jul 2022 18:36:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: qcom: SC7280: Add support for external DMIC bias
 supply
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
References: <1658992233-28372-1-git-send-email-quic_srivasam@quicinc.com>
 <YuJpxSuPBB++pl/o@sirena.org.uk>
From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YuJpxSuPBB++pl/o@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
 tiwai@suse.com, lgirdwood@gmail.com, robh+dt@kernel.org,
 bjorn.andersson@linaro.org, agross@kernel.org, srinivas.kandagatla@linaro.org,
 bgoswami@quicinc.com, quic_plai@quicinc.com, judyhsiao@chromium.org,
 linux-kernel@vger.kernel.org
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


On 7/28/2022 4:19 PM, Mark Brown wrote:
Thanks for your time Mark!!!
> On Thu, Jul 28, 2022 at 12:40:33PM +0530, Srinivasa Rao Mandadapu wrote:
>
>> +static int sc7280_dmic_micbias(struct snd_soc_dapm_widget *w,
>> +				struct snd_kcontrol *kcontrol, int event)
>> +{
>> +	struct snd_soc_card *card = w->dapm->card;
>> +	struct sc7280_snd_data *data = snd_soc_card_get_drvdata(card);
>> +	int ret = 0;
>> +
> This is open coding SND_SOC_DAPM_REGULATOR_SUPPLY() isn't it?

Yes, agree that SND_SOC_DAPM_REGULATOR_SUPPLY can be used here. As I was 
using two different names for

VDD supply property and widget name, got confused. I will re post the 
patch, with single name for both and replace with above macro .

