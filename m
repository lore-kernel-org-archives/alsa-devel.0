Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8583BC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Mar 2022 15:18:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDE6918B4;
	Tue, 15 Mar 2022 16:17:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDE6918B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647357484;
	bh=3WvKzHi62qq/bV8PSE7q7/zwRkseaboCWK9sVZgqT+Q=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RQAFOzNBeHUT7vfDTdFpKzprKbnjhIqo6g/N37anM0vZt2+wNCkwK3P03EokV4Gkr
	 VfiRdg6Cf9US9UMb8Fe4RQZlEa+z46ow3weDf1hDt77lSB6UoGx0OJV76JkWCiJXs9
	 7/7n8WiCob9Zww/egio7V4VEo85xf5knLESClLQw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 82C2CF80515;
	Tue, 15 Mar 2022 16:16:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4EF84F80162; Tue, 15 Mar 2022 16:16:32 +0100 (CET)
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
 (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3068F8012C
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2022 16:16:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3068F8012C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="bau7MQaF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1647357387; x=1678893387;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=K/5VIbFRNZyUAomyRkJcvu1MFWQjXYbL+i+2czloWR4=;
 b=bau7MQaFrHgtbVrDZQGhai0rTP5GffZ5g0jfwFmA3HckoTsro3FKbjr8
 MyAmow+HAsoXgrXgoF2Xr+ZfOCJqI3CLEnx3Z8a+U58V5DAgq72JGQbSa
 c2Woz3CIJ0Jpa/p6LuiRr/8D4iPk1hGF09GWcA0f92jX2KXrPpHNvCGAc s=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
 by alexa-out.qualcomm.com with ESMTP; 15 Mar 2022 08:16:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2022 08:16:21 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Mar 2022 08:16:21 -0700
Received: from [10.216.59.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 15 Mar
 2022 08:16:15 -0700
Message-ID: <35e43f3a-8d48-5c2a-b5f6-9220cead7ff0@quicinc.com>
Date: Tue, 15 Mar 2022 20:46:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v10 4/7] pinctrl: qcom: Update lpi pin group structure
Content-Language: en-US
To: Bjorn Andersson <bjorn.andersson@linaro.org>
References: <1646737394-4740-1-git-send-email-quic_srivasam@quicinc.com>
 <1646737394-4740-5-git-send-email-quic_srivasam@quicinc.com>
 <YieYr00MRUfeSE1B@ripper>
From: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <YieYr00MRUfeSE1B@ripper>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, Venkata Prasad Potturu <quic_potturu@quicinc.com>,
 linux-arm-msm@vger.kernel.org, swboyd@chromium.org, tiwai@suse.com,
 agross@kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com,
 linux-gpio@vger.kernel.org, rohitkr@codeaurora.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, quic_plai@quicinc.com, judyhsiao@chromium.org,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org
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


On 3/8/2022 11:25 PM, Bjorn Andersson wrote:
Thanks for Your Time Bjorn!!!
> On Tue 08 Mar 03:03 PST 2022, Srinivasa Rao Mandadapu wrote:
>
>> Update lpi group structure with core group_desc structure
>> to avoid redundant struct params.
>>
> This fails to express why you're doing that, please see below.
>
>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
>> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
>> ---
>>   drivers/pinctrl/qcom/Kconfig             |  1 +
>>   drivers/pinctrl/qcom/pinctrl-lpass-lpi.c | 44 +++++++++++++++-----------------
>>   2 files changed, 22 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
>> index ca6f68a..31c4aa6 100644
>> --- a/drivers/pinctrl/qcom/Kconfig
>> +++ b/drivers/pinctrl/qcom/Kconfig
>> @@ -351,6 +351,7 @@ config PINCTRL_LPASS_LPI
>>   	select PINMUX
>>   	select PINCONF
>>   	select GENERIC_PINCONF
>> +	select GENERIC_PINCTRL_GROUPS
> This allow you to use struct group_desc, but what does that give you?
>
> I don't see a change where you're moving to use the common group_desc
> helpers that the framework supplies. Without that this just replace 3
> entries in struct lpi_pingroup with 4 entries in struct group_desc.
>
>
> Change looks good, iff it's followed by a transition to replace the
> driver's custom functions with pinctrl_generic_get_group_*().
>
> Regards,
> Bjorn
Okay. Will change and re send the patch set.
>
>>   	depends on GPIOLIB
>>   	help
>>   	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>> index 3c15f80..54750ba 100644
>> --- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>> +++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
>> @@ -51,11 +51,11 @@
>>   
>>   #define LPI_PINGROUP(id, soff, f1, f2, f3, f4)		\
>>   	{						\
>> -		.name = "gpio" #id,			\
>> -		.pins = gpio##id##_pins,		\
>> +		.group.name = "gpio" #id,			\
>> +		.group.pins = gpio##id##_pins,		\
>>   		.pin = id,				\
>>   		.slew_offset = soff,			\
>> -		.npins = ARRAY_SIZE(gpio##id##_pins),	\
>> +		.group.num_pins = ARRAY_SIZE(gpio##id##_pins),	\
>>   		.funcs = (int[]){			\
>>   			LPI_MUX_gpio,			\
>>   			LPI_MUX_##f1,			\
>> @@ -67,9 +67,7 @@
>>   	}
>>   
>>   struct lpi_pingroup {
>> -	const char *name;
>> -	const unsigned int *pins;
>> -	unsigned int npins;
>> +	struct group_desc group;
>>   	unsigned int pin;
>>   	/* Bit offset in slew register for SoundWire pins only */
>>   	int slew_offset;
>> @@ -150,20 +148,20 @@ enum sm8250_lpi_functions {
>>   	LPI_MUX__,
>>   };
>>   
>> -static const unsigned int gpio0_pins[] = { 0 };
>> -static const unsigned int gpio1_pins[] = { 1 };
>> -static const unsigned int gpio2_pins[] = { 2 };
>> -static const unsigned int gpio3_pins[] = { 3 };
>> -static const unsigned int gpio4_pins[] = { 4 };
>> -static const unsigned int gpio5_pins[] = { 5 };
>> -static const unsigned int gpio6_pins[] = { 6 };
>> -static const unsigned int gpio7_pins[] = { 7 };
>> -static const unsigned int gpio8_pins[] = { 8 };
>> -static const unsigned int gpio9_pins[] = { 9 };
>> -static const unsigned int gpio10_pins[] = { 10 };
>> -static const unsigned int gpio11_pins[] = { 11 };
>> -static const unsigned int gpio12_pins[] = { 12 };
>> -static const unsigned int gpio13_pins[] = { 13 };
>> +static int gpio0_pins[] = { 0 };
>> +static int gpio1_pins[] = { 1 };
>> +static int gpio2_pins[] = { 2 };
>> +static int gpio3_pins[] = { 3 };
>> +static int gpio4_pins[] = { 4 };
>> +static int gpio5_pins[] = { 5 };
>> +static int gpio6_pins[] = { 6 };
>> +static int gpio7_pins[] = { 7 };
>> +static int gpio8_pins[] = { 8 };
>> +static int gpio9_pins[] = { 9 };
>> +static int gpio10_pins[] = { 10 };
>> +static int gpio11_pins[] = { 11 };
>> +static int gpio12_pins[] = { 12 };
>> +static int gpio13_pins[] = { 13 };
>>   static const char * const swr_tx_clk_groups[] = { "gpio0" };
>>   static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio5" };
>>   static const char * const swr_rx_clk_groups[] = { "gpio3" };
>> @@ -262,7 +260,7 @@ static const char *lpi_gpio_get_group_name(struct pinctrl_dev *pctldev,
>>   {
>>   	struct lpi_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
>>   
>> -	return pctrl->data->groups[group].name;
>> +	return pctrl->data->groups[group].group.name;
>>   }
>>   
>>   static int lpi_gpio_get_group_pins(struct pinctrl_dev *pctldev,
>> @@ -272,8 +270,8 @@ static int lpi_gpio_get_group_pins(struct pinctrl_dev *pctldev,
>>   {
>>   	struct lpi_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
>>   
>> -	*pins = pctrl->data->groups[group].pins;
>> -	*num_pins = pctrl->data->groups[group].npins;
>> +	*pins = pctrl->data->groups[group].group.pins;
>> +	*num_pins = pctrl->data->groups[group].group.num_pins;
>>   
>>   	return 0;
>>   }
>> -- 
>> 2.7.4
>>
