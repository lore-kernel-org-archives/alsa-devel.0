Return-Path: <SRS0=Aiaa=GV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1A9C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 00:03:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642E2222BB
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Jan 2021 00:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642E2222BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0553177D;
	Mon, 18 Jan 2021 01:02:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0553177D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610928220;
	bh=+8YVB5gGYdBy+8afZ2DY9A+IkC0voKBqovGOaqvDNw4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E+2GUcwD85Y/A4W4pq+LbyrOafP2qKlwXLWsl+NzDHfAzWHFpqu1aSFqBoCgV5yff
	 0iFkxBChr5DgJ0+rIPR31o8CzLNV40m29GyIL6LJL7hYPGXnbeXJKETEcmRbGPWkvd
	 N9wIeag9SbwO0I3C6QdHDMwcyxKLNiYPtAajmvos=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B74DF800C0;
	Mon, 18 Jan 2021 01:02:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A6938F80257; Mon, 18 Jan 2021 01:02:48 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26135F800C0
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2021 01:02:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26135F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="lfho4XP9"
Received: by mail-lj1-x22b.google.com with SMTP id m10so16445718lji.1
 for <alsa-devel@alsa-project.org>; Sun, 17 Jan 2021 16:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pw1+hLYn2JEcquNck3UFBQ0wnTeToO3O8iHRUlofEyY=;
 b=lfho4XP9TDb4OXFlcCHozgchA2+O0wiV/Px4hhbEW1N0+RQbemVCyqJ5ANsgz6YXB9
 qg6jn5Fw6rAagT+q9rsDHFnSkSe3zxzcWfB705i9IfEUpWQguIgLuUte1zWjumCy9NHc
 Zr1R+fPf9C1P6DiGACtVbWd4qWm23YAclswEu1bludi1Tfq3HoZytJPCoMKK0ByDaTEi
 TYMdJ9y0R9LxKqqELnTjTV021lo6bDPpxaqSReFXmWEwN9jkPi6eOxvB+Vu7S6BOxMqr
 zPOEUP+2scgnIfwOM3ruJBnhHVwR/FlU62UGalhGN7kuhFH8as0gwlJfZmiv5s3XF/5f
 yTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pw1+hLYn2JEcquNck3UFBQ0wnTeToO3O8iHRUlofEyY=;
 b=BuT7x7ADmCqAgyNol5U11wAutPB2EEr+JM/CF3k/bnYdRyqzIlDl+9ksJM/HHqEK9O
 NUn2w5KMX1Eu4eWp6PpS0NZwp2lS5TQ2WXQPoLgPRE+SsQdJaaqXGT2b5buhcCDar939
 skaZ64/bIzZqYWWuRK5gKx95eu7BzLBMKk5/Nup8mv5KQd0Zlk6htg5sr1bx0qS986zk
 y1ftABH5hs2SX1GwB5yNqdztLEW87V4nzTnaARtCmusacQje0h7HG8pCsnKKZEoFQmSJ
 qlOW9aZ0ZrZ24C3t7aui1my4GXVgzLvMiGH/7lwevOsiEnJLhcoU/dfXhlpnhOUOdIKj
 33nw==
X-Gm-Message-State: AOAM5307xkClAYuLdG/zNVPXVNbiXdXs4eILX8Faa3lanu1pxU7lhOfm
 2JBYwQg3HMJ2hio956idBT0=
X-Google-Smtp-Source: ABdhPJxeybrzkgl0vuGHulMBJf3JOFIvuy1UWfaeFhbL0aScHR/h49K85FH+KomPRSkNaxkYTeoFLA==
X-Received: by 2002:a2e:b0d2:: with SMTP id g18mr9246073ljl.357.1610928160186; 
 Sun, 17 Jan 2021 16:02:40 -0800 (PST)
Received: from [192.168.2.145] (109-252-192-57.dynamic.spd-mgts.ru.
 [109.252.192.57])
 by smtp.googlemail.com with ESMTPSA id 192sm1701965lfa.219.2021.01.17.16.02.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Jan 2021 16:02:39 -0800 (PST)
Subject: Re: [PATCH v1 5/5] ASoC: tegra: ahub: Reset hardware properly
To: Thierry Reding <thierry.reding@gmail.com>
References: <20210112125834.21545-1-digetx@gmail.com>
 <20210112125834.21545-6-digetx@gmail.com> <YAG4aFADwo7dh/oR@ulmo>
From: Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c2f3d149-0781-3d0a-1d68-f6820386e84d@gmail.com>
Date: Mon, 18 Jan 2021 03:02:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <YAG4aFADwo7dh/oR@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Nicolas Chauvet <kwizart@gmail.com>,
 linux-kernel@vger.kernel.org, Sameer Pujar <spujar@nvidia.com>,
 Takashi Iwai <tiwai@suse.com>, Peter Geis <pgwipeout@gmail.com>,
 linux-tegra@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>
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

15.01.2021 18:44, Thierry Reding пишет:
> On Tue, Jan 12, 2021 at 03:58:34PM +0300, Dmitry Osipenko wrote:
>> Assert hardware reset before clocks are enabled and then de-assert it
>> after clocks are enabled. This brings hardware into a predictable state
>> and removes relying on implicit de-assertion of resets which is done by
>> the clk driver.
>>
>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  sound/soc/tegra/tegra30_ahub.c | 33 ++++++++++++++++-----------------
>>  sound/soc/tegra/tegra30_ahub.h |  1 +
>>  2 files changed, 17 insertions(+), 17 deletions(-)
>>
>> diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
>> index 4dbb58f7ea36..246cf6a373a1 100644
>> --- a/sound/soc/tegra/tegra30_ahub.c
>> +++ b/sound/soc/tegra/tegra30_ahub.c
>> @@ -65,10 +65,20 @@ static int tegra30_ahub_runtime_resume(struct device *dev)
>>  {
>>  	int ret;
>>  
>> +	ret = reset_control_assert(ahub->reset);
>> +	if (ret)
>> +		return ret;
>> +
>>  	ret = clk_bulk_prepare_enable(ahub->nclocks, ahub->clocks);
>>  	if (ret)
>>  		return ret;
>>  
>> +	ret = reset_control_reset(ahub->reset);
>> +	if (ret) {
>> +		clk_bulk_disable_unprepare(ahub->nclocks, ahub->clocks);
>> +		return ret;
>> +	}
>> +
>>  	regcache_cache_only(ahub->regmap_apbif, false);
>>  	regcache_cache_only(ahub->regmap_ahub, false);
>>  
>> @@ -462,7 +472,6 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
>>  {
>>  	const struct of_device_id *match;
>>  	const struct tegra30_ahub_soc_data *soc_data;
>> -	struct reset_control *rst;
>>  	struct resource *res0;
>>  	void __iomem *regs_apbif, *regs_ahub;
>>  	int ret = 0;
>> @@ -475,22 +484,6 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
>>  		return -EINVAL;
>>  	soc_data = match->data;
>>  
>> -	/*
>> -	 * The AHUB hosts a register bus: the "configlink". For this to
>> -	 * operate correctly, all devices on this bus must be out of reset.
>> -	 * Ensure that here.
>> -	 */
>> -	rst = of_reset_control_array_get_exclusive(pdev->dev.of_node);
>> -	if (IS_ERR(rst)) {
>> -		dev_err(&pdev->dev, "Can't get reset: %p\n", rst);
>> -		return PTR_ERR(rst);
>> -	}
>> -
>> -	ret = reset_control_deassert(rst);
>> -	reset_control_put(rst);
>> -	if (ret)
>> -		return ret;
>> -
>>  	ahub = devm_kzalloc(&pdev->dev, sizeof(struct tegra30_ahub),
>>  			    GFP_KERNEL);
>>  	if (!ahub)
>> @@ -507,6 +500,12 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		return ret;
>>  
>> +	ahub->reset = devm_reset_control_array_get_exclusive(&pdev->dev);
>> +	if (IS_ERR(ahub->reset)) {
>> +		dev_err(&pdev->dev, "Can't get reset: %p\n", ahub->reset);
> 
> I didn't notice that the prior patch already introduced this, but I'd
> prefer for this to either be %pe so that the symbolic error name is
> printed, or %ld with PTR_ERR(ahub->reset) to format this in a more
> standard way that can be more easily grepped for and parsed.

This is already fixed in v2. Good catch anyways, thanks.

> It also seems like the prior patch that converts this to use
> of_reset_control_array_get_exclusive() is a bit pointless now. Why not
> just move to this directly instead?

These are two independent changes. The previous patch fixed the missing
resets, this patch changes the hardware initialization logic.
