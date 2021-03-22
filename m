Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6922AC433C1
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 10:27:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48CF661993
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 10:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CF661993
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D6852950;
	Mon, 22 Mar 2021 11:26:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D6852950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616408845;
	bh=GL5zJ4eQS6oj2SkfOjQSPa2HWUxM35RJk48nZCDZLRs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F/lg6kkWZe1vOWmQlkrwRHCP1HdXyM5as4y6Ig1kH5OYIBUW9i/TumP328d/lh2Us
	 T8j+vfHvtdW+YTvlXrUXYqLxW1/3+dM54VJpjXmT/Hztf7yfzv/kF3JakKZl7AzaqH
	 m5XlPEN6Bk4fALI6hls3GlVd0cOEEqkW9i93J2uM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 63D95F80155;
	Mon, 22 Mar 2021 11:26:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 850F6F8016B; Mon, 22 Mar 2021 11:26:34 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B252FF80155
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 11:26:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B252FF80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="qidjlqXa"
Received: by mail-wr1-x42f.google.com with SMTP id b9so16062403wrt.8
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 03:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OSkS8klzMM+4/NTgGz09ceK75610Ius88Sv2HzyZb5o=;
 b=qidjlqXaQCI2EWyfh0TVmaLz9gqEHLl/iklW8EIbKVTuXg+vOJHtobt/ZmjyzMmark
 92I4FNxkZ+jpfHMtD9K7u8Q/XJfoMtPjEq99A73jO4pIkGD96K6JUWLY8RFygUTuhZUd
 3Rwg0HTV8CbPMECJseV3LDUnfNmBeAqxg4qx/N9V2zXU8WyQOJ2yPhUOEeAcMITnRUqP
 zEaAi0GS8gXGI3JxvoLDIkOoGPa5iTrBpaBHwAZu1wIvfH3D/vKxKmTWt9lYkM5raRDK
 6BK2/grg/Qw5Z0AjLOZXuK9hPcqtGfeDCgv1pmQw8hTyn1EDMP9gAGsb1IGOwxMB38gs
 oPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OSkS8klzMM+4/NTgGz09ceK75610Ius88Sv2HzyZb5o=;
 b=otu3vKliaCiN1Sh0RjuHRErmXENIZKxh1HSfcgkYWOWkx5PzMY2a4FRUud8FLWuyu+
 hEjZZEDEu26M5Sh+bzOlaycZ7MJY0oNQbu/LCwL5uKISdZJKSYVUYmNd14jH0GCrbdhf
 oK2t+QQKCSpQ/rAYz3ds6vbba+EHpfV5aJUHBsbWqQ36iX96tgEepEbjmGsIxRtDQh/i
 Lf9kp3t9W9G4KWYUl1kgO0Pe1sQuuB7fsEQpdWbKfBV5XrkSlpUURWw9GWcBWDyZda9W
 fneGnMovcFeo//my/KIby+F8LPK0EyZL+oyqz/Oq8k6O5gL5M9mJLo1T9//1U3GiLRAe
 3Iug==
X-Gm-Message-State: AOAM530fUqNwobERRtBLX5Qxz/T2cT9Jqi8rxcEsh+ENp1q3IPREqGZ7
 PeN0vlB0krolThNhwJkjcjV1dA==
X-Google-Smtp-Source: ABdhPJxKLdTlVU+Al3YSaiI/ZgS4AoFun1Gz+b2uECwV24sFgpR6uQTG69gnEy3luXXRJxoXiyO0GA==
X-Received: by 2002:a5d:5088:: with SMTP id a8mr17620390wrt.294.1616408782813; 
 Mon, 22 Mar 2021 03:26:22 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
 by smtp.googlemail.com with ESMTPSA id w131sm16544911wmb.8.2021.03.22.03.26.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Mar 2021 03:26:22 -0700 (PDT)
Subject: Re: [PATCH v3 2/7] ASoC: codecs: wcd-clsh: add new version support
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org
References: <20210319092919.21218-1-srinivas.kandagatla@linaro.org>
 <20210319092919.21218-3-srinivas.kandagatla@linaro.org>
 <26038ba1-e8f6-08e3-bee5-673d69d7decd@linux.intel.com>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <585401cc-4248-7769-4d9a-84553b2d0ea6@linaro.org>
Date: Mon, 22 Mar 2021 10:26:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <26038ba1-e8f6-08e3-bee5-673d69d7decd@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: robh@kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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



On 19/03/2021 15:23, Pierre-Louis Bossart wrote:
> 
>> +static void wcd_clsh_v3_set_hph_mode(struct snd_soc_component 
>> *component,
>> +                  int mode)
>> +{
>> +    u8 val = 0;
> 
> initialization not needed.
> 
I agree, will remove this in next spin.

>> +
>> +    switch (mode) {
>> +    case CLS_H_NORMAL:
>> +        val = 0x00;
>> +        break;
>> +    case CLS_AB:
>> +    case CLS_H_ULP:
>> +        val = 0x0C;
>> +        break;
>> +    case CLS_AB_HIFI:
>> +    case CLS_H_HIFI:
>> +        val = 0x08;
>> +        break;
>> +    case CLS_H_LP:
>> +    case CLS_H_LOHIFI:
>> +    case CLS_AB_LP:
>> +    case CLS_AB_LOHIFI:
>> +        val = 0x04;
>> +        break;
>> +    default:
>> +        dev_err(component->dev, "%s:Invalid mode %d\n", __func__, mode);
>> +        return;
>> +    };
>> +
>> +    snd_soc_component_update_bits(component, WCD9XXX_ANA_HPH, 0x0C, 
>> val);
>> +}
>> +
>> +
> 
> extra line
> 
will remove this in next spin.

>> +void wcd_clsh_set_hph_mode(struct wcd_clsh_ctrl *ctrl, int mode)
>> +{
>> +    struct snd_soc_component *comp = ctrl->comp;
>> +
>> +    if (ctrl->codec_version >= WCD937X)
>> +        wcd_clsh_v3_set_hph_mode(comp, mode);
>> +    else
>> +        wcd_clsh_v2_set_hph_mode(comp, mode);
>> +
>> +}
>> +
>>   static void wcd_clsh_set_flyback_current(struct snd_soc_component 
>> *comp,
>>                        int mode)
>>   {
>> @@ -289,6 +388,130 @@ static void 
>> wcd_clsh_set_buck_regulator_mode(struct snd_soc_component *comp,
>>                       WCD9XXX_A_ANA_RX_REGULATOR_MODE_CLS_H);
>>   }
>> +static void wcd_clsh_v3_set_buck_regulator_mode(struct 
>> snd_soc_component *component,
>> +                        int mode)
>> +{
>> +    snd_soc_component_update_bits(component, WCD9XXX_ANA_RX_SUPPLIES,
>> +                0x02, 0x00);
>> +}
>> +
>> +static inline void wcd_clsh_v3_set_flyback_mode(struct 
>> snd_soc_component *component,
>> +                        int mode)
>> +{
>> +    if (mode == CLS_H_HIFI || mode == CLS_H_LOHIFI ||
>> +        mode == CLS_AB_HIFI || mode == CLS_AB_LOHIFI) {
>> +        snd_soc_component_update_bits(component,
>> +                WCD9XXX_ANA_RX_SUPPLIES,
>> +                0x04, 0x04);
>> +        snd_soc_component_update_bits(component,
>> +                WCD9XXX_FLYBACK_VNEG_CTRL_4,
>> +                0xF0, 0x80);
>> +    } else {
>> +        snd_soc_component_update_bits(component,
>> +                WCD9XXX_ANA_RX_SUPPLIES,
>> +                0x04, 0x00); /* set to Default */
>> +        snd_soc_component_update_bits(component,
>> +                WCD9XXX_FLYBACK_VNEG_CTRL_4,
>> +                0xF0, 0x70);
>> +    }
>> +}
>> +
>> +static inline void wcd_clsh_v3_force_iq_ctl(struct snd_soc_component 
>> *component,
>> +                     int mode, bool enable)
>> +{
>> +    if (enable) {
>> +        snd_soc_component_update_bits(component,
>> +                WCD9XXX_FLYBACK_VNEGDAC_CTRL_2,
>> +                0xE0, 0xA0);
>> +        /* 100usec delay is needed as per HW requirement */
>> +        usleep_range(100, 110);
>> +        snd_soc_component_update_bits(component,
>> +                WCD9XXX_CLASSH_MODE_3,
>> +                0x02, 0x02);
>> +        snd_soc_component_update_bits(component,
>> +                WCD9XXX_CLASSH_MODE_2,
>> +                0xFF, 0x1C);
>> +        if (mode == CLS_H_LOHIFI || mode == CLS_AB_LOHIFI) {
>> +            snd_soc_component_update_bits(component,
>> +                    WCD9XXX_HPH_NEW_INT_PA_MISC2,
>> +                    0x20, 0x20);
>> +            snd_soc_component_update_bits(component,
>> +                    WCD9XXX_RX_BIAS_HPH_LOWPOWER,
>> +                    0xF0, 0xC0);
>> +            snd_soc_component_update_bits(component,
>> +                    WCD9XXX_HPH_PA_CTL1,
>> +                    0x0E, 0x02);
>> +        }
>> +    } else {
>> +        snd_soc_component_update_bits(component,
>> +                WCD9XXX_HPH_NEW_INT_PA_MISC2,
>> +                0x20, 0x00);
>> +        snd_soc_component_update_bits(component,
>> +                WCD9XXX_RX_BIAS_HPH_LOWPOWER,
>> +                0xF0, 0x80);
>> +        snd_soc_component_update_bits(component,
>> +                WCD9XXX_HPH_PA_CTL1,
>> +                0x0E, 0x06);
>> +    }
>> +}
> 
> do you need the inline for the two functions above?
yes, these are totally unnecessary.

--srini
> 
> 
