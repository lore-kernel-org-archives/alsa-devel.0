Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24F3C433EF
	for <alsa-devel@archiver.kernel.org>; Sat, 19 Feb 2022 18:25:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC33C16A2;
	Sat, 19 Feb 2022 19:24:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC33C16A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645295131;
	bh=0zYYqKwMS6ElXT4eg0xXO/aCG+oaMkSZJgGyHUtWHgA=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z7OXmAyGHXuzIizp0GgvKEIP3h2zzgqOCtn68ec/FOWWr1CECyAJwnIMKEUdC9n17
	 srhrCvAAjVBvta6fwRcOJBrNu4fz8o3zabIZAR1nk7DANO8RHJUC/uXz7xpSzMC4CY
	 +wwyVPR/GhPQFpVkNJv+rBwqcJ81Gm+fIsf0Q+1M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4AC3BF8014B;
	Sat, 19 Feb 2022 19:24:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE371F8016A; Sat, 19 Feb 2022 19:24:37 +0100 (CET)
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
 (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0DC0AF800AB
 for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2022 19:24:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0DC0AF800AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=quicinc.com header.i=@quicinc.com
 header.b="Of+jYbK1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1645295076; x=1676831076;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=VS6tHIKsBZ6g2gxigj4Akj9iPgXhXwpFwPyKfVPvOFM=;
 b=Of+jYbK1bkLylZmC5P6O+C1ZtC7tyRG+/esgxOIi0243qgkVx/tw5mCx
 5fr8viPwR+aP2fx4Oco8DGNfgH+KXKJtVid+7q+aXoPhEVgQDjEFThxqW
 xlPUdlnxcUGDYoEDFviMOR6h8Iw3tW4BTg8mTQv01e9oiiokcyomRtp1n A=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
 by alexa-out.qualcomm.com with ESMTP; 19 Feb 2022 10:24:31 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
 by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2022 10:24:31 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 19 Feb 2022 10:24:30 -0800
Received: from [10.216.20.52] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Sat, 19 Feb
 2022 10:24:23 -0800
Message-ID: <628bfaf8-7f3b-ad79-15cb-c45c4a2b3dd2@quicinc.com>
Date: Sat, 19 Feb 2022 23:54:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 4/7] pinctrl: qcom: Update lpi pin group structure
Content-Language: en-US
To: Stephen Boyd <swboyd@chromium.org>, Linus Walleij
 <linus.walleij@linaro.org>, <agross@kernel.org>,
 <alsa-devel@alsa-project.org>, <bgoswami@codeaurora.org>,
 <bjorn.andersson@linaro.org>, <broonie@kernel.org>,
 <devicetree@vger.kernel.org>, <judyhsiao@chromium.org>,
 <lgirdwood@gmail.com>, <linux-arm-msm@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <perex@perex.cz>, <quic_plai@quicinc.com>, <robh+dt@kernel.org>,
 <rohitkr@codeaurora.org>, <srinivas.kandagatla@linaro.org>, <tiwai@suse.com>
References: <1644851994-22732-1-git-send-email-quic_srivasam@quicinc.com>
 <1644851994-22732-5-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n51vhcUg5ng7FWzS0-09-zazCk5JKwpvLPfK4w15_r97kw@mail.gmail.com>
From: "Srinivasa Rao Mandadapu (Temp)" <quic_srivasam@quicinc.com>
Organization: Qualcomm
In-Reply-To: <CAE-0n51vhcUg5ng7FWzS0-09-zazCk5JKwpvLPfK4w15_r97kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Cc: Venkata Prasad Potturu <quic_potturu@quicinc.com>
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


On 2/19/2022 8:08 AM, Stephen Boyd wrote:
Thanks for your time Stephen!!!
> Quoting Srinivasa Rao Mandadapu (2022-02-14 07:19:51)
>> @@ -150,20 +148,20 @@ enum sm8250_lpi_functions {
>>          LPI_MUX__,
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
> Why do we lose const?
Const here is creating conflicts with gpio group_desc structure!!!
>
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
