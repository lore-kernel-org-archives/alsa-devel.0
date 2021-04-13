Return-Path: <SRS0=Dyxj=JK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80612C433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 07:33:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC773613B2
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Apr 2021 07:33:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC773613B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 942281662;
	Tue, 13 Apr 2021 09:32:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 942281662
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618299185;
	bh=+MsZrqM6Uo7P/JZH5Lk31zJzST6+HS2Q/nZlMQUqZAo=;
	h=References:From:To:Subject:In-reply-to:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OTxBaGcmr8Eo1yRFtStniDJJqRRrYIYBIvSLfXUfXhN2+rAjgJdqVN4lJek90k4iB
	 TSryDVWCx1QLhOA/eIASqn6TleiTenZxd5lK3zQTPpDZmFEphq/B+eFrTjBzYgBgwe
	 tccb1REDwk3xECEaRspEBt04zj8SFDxalQmImP/Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D709FF8021D;
	Tue, 13 Apr 2021 09:32:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7084F8022B; Tue, 13 Apr 2021 09:32:12 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 618E2F800EB
 for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2021 09:31:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 618E2F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com
 header.i=@baylibre-com.20150623.gappssmtp.com header.b="s9WMcgFo"
Received: by mail-wm1-x332.google.com with SMTP id
 y20-20020a1c4b140000b029011f294095d3so10038999wma.3
 for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2021 00:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=references:user-agent:from:to:cc:subject:in-reply-to:message-id
 :date:mime-version;
 bh=I0tKIcGAnmGzt7gEhrs4pRS1r2Q74lYwZyR49l7q3W4=;
 b=s9WMcgFohkgE20WsAj9CXlV7WD1zYY9OWiuDjIFtC6KA4jVR76cLXh09qK5IL7ZoG+
 Yue22tCXfmjieQ3qMNvUV4GBD0bRFkH6fVyEcqaS5jtOBfUi2+WfQzHRhwrp36hZstv7
 ZhudGEdVmABoHwZw5ag0jfU7Is3+wiBpwOq0MPGaemjfShNUaHZJr68vMjgp31dqYDNR
 Tr2/z1+BZY7d45OCTzmM6Z0CwwmlAkhCaLl9yqzmqvB+YMrCSvevAfLrL5bA7oL7I3dn
 qt5EEpbJdh9h6ml4uoCl5+GpaeBD2/pOGuNi9oADeL2P2apsVffNnBrcx/8gdM687olG
 dxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:message-id:date:mime-version;
 bh=I0tKIcGAnmGzt7gEhrs4pRS1r2Q74lYwZyR49l7q3W4=;
 b=PCkp1Iv/p11Q8X37wyICA+Hp6oPXni/J/3+65Uy7ZMVBTgOi97CecL+1xVUBvnRExF
 fgXLX6RQiIhwPaCRQCPrF4yvJr2awwnu3RHRS3NRq/+xLvra+5WpuGDdzeQiI+GbWzIr
 RqrBDfzRS8gbcfFA0TehIzhu1bNx8SrKz/AXHVDyte4f/gJe76F9pfhNIsR9PaURXEzn
 11M41NJzVgbCyxbSV7uwIvm8AZoQ7w1Fcalms4O2AiCY1lJqx/A4l7QkOIFrfM5rRWYk
 LYnecA9K7MxivIGea+VWadwMMW/KTuBRnjMzpDna/9X8guzup4HDzQca418TKPftLVSA
 03AA==
X-Gm-Message-State: AOAM533rznrX7HNKth3LZnSnHcITqz6uXOJhcQhMQbPCv1/cJjOG1XKR
 2vxKxBURBMITicE45Iclc/aDLg==
X-Google-Smtp-Source: ABdhPJyVk1h6gk/4Qj2FC3S5U0X0xGwrQZewBKjbRr9KD4g/hHEh1n+0fYFf1yNyALe2v30aVv5MgQ==
X-Received: by 2002:a05:600c:4f14:: with SMTP id
 l20mr2689930wmq.71.1618299118162; 
 Tue, 13 Apr 2021 00:31:58 -0700 (PDT)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
 by smtp.gmail.com with ESMTPSA id z17sm7197599wro.1.2021.04.13.00.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Apr 2021 00:31:57 -0700 (PDT)
References: <20210410111356.467340-1-jbrunet@baylibre.com>
 <20210410111356.467340-4-jbrunet@baylibre.com>
 <161825923642.3764895.16526540466177115640@swboyd.mtv.corp.google.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/5] ASoC: rt5682: clock driver must use the clock
 provider API
In-reply-to: <161825923642.3764895.16526540466177115640@swboyd.mtv.corp.google.com>
Message-ID: <1jlf9m63o3.fsf@starbuckisacylon.baylibre.com>
Date: Tue, 13 Apr 2021 09:31:56 +0200
MIME-Version: 1.0
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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


On Mon 12 Apr 2021 at 22:27, Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Jerome Brunet (2021-04-10 04:13:54)
>> Clock drivers ops should not the clk API but the clock provider (clk_hw)
>> instead.
>> 
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  sound/soc/codecs/rt5682.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
>> index 0e2a10ed11da..2eee02ac8d49 100644
>> --- a/sound/soc/codecs/rt5682.c
>> +++ b/sound/soc/codecs/rt5682.c
>> @@ -2634,7 +2634,7 @@ static int rt5682_wclk_set_rate(struct clk_hw *hw, unsigned long rate,
>>                 container_of(hw, struct rt5682_priv,
>>                              dai_clks_hw[RT5682_DAI_WCLK_IDX]);
>>         struct snd_soc_component *component = rt5682->component;
>> -       struct clk *parent_clk;
>> +       struct clk_hw *parent_hw;
>>         const char * const clk_name = clk_hw_get_name(hw);
>>         int pre_div;
>>         unsigned int clk_pll2_out;
>> @@ -2649,8 +2649,8 @@ static int rt5682_wclk_set_rate(struct clk_hw *hw, unsigned long rate,
>>          *
>>          * It will set the codec anyway by assuming mclk is 48MHz.
>>          */
>> -       parent_clk = clk_get_parent(hw->clk);
>> -       if (!parent_clk)
>> +       parent_hw = clk_hw_get_parent(hw);
>> +       if (!parent_hw)
>>                 dev_warn(component->dev,
>>                         "Parent mclk of wclk not acquired in driver. Please ensure mclk was provided as %d Hz.\n",
>>                         CLK_PLL2_FIN);
>
> Can this code be removed? I don't know why we care to check if the clk
> has a parent or not.

I'm focusing on removing "hw->clk" where they are - w/o changing too
much what the driver does. I don't have the HW nor the story behind it
and there is about 50 more drivers to be fixed ... thankfully, most are
in drivers/clk/ ;)

Here, at least the clock consummer API is not longer used within a clock
ops, which is not great considering the locking scheme (among other things)
