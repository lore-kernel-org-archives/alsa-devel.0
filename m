Return-Path: <SRS0=4IlU=II=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AFBC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 18:15:45 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C1064FB5
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Mar 2021 18:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C1064FB5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=walle.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E08521709;
	Wed, 10 Mar 2021 19:14:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E08521709
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615400142;
	bh=6LfS2j2Hmu/WYZZaDuQamAENhBJealZxjGpnopl3B/I=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kYXQsOqCp+Fndg7622mL6RiwNBXx9xYjo5+hzmA/CBT8sd7chIYEEx6oM4++/XPls
	 Pnb/MERQ3is4HJ4omNtaQ3IoW60ibV4cup56btwBiyuSt7Q3/n1V2/mjQJejvu5gz3
	 jEZ7H0X2U+rwkGGpYzgQtEKyn2w3naqa7cuFcE6I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 67BEAF8016C;
	Wed, 10 Mar 2021 19:14:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA2EAF801D8; Wed, 10 Mar 2021 19:14:50 +0100 (CET)
Received: from ssl.serverraum.org (ssl.serverraum.org
 [IPv6:2a01:4f8:151:8464::1:2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 940DDF8010D
 for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2021 19:14:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 940DDF8010D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc
 header.b="tAwIfuHQ"
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ssl.serverraum.org (Postfix) with ESMTPSA id 9317522173;
 Wed, 10 Mar 2021 19:14:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc;
 s=mail2016061301; t=1615400078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=raaT8hRIbeIkMsfmgVYBm7wNKoVMABIhHxKLm28T03s=;
 b=tAwIfuHQ1UIEuWmKANx46QXvrhsMsjpXyVkGLtwNTP9g8WVpCMp5mWUEl8E4vRPOUuGyxE
 TmKC4VGVy2+RcPD116dB0ZQRCT050viuhioJA1P7mJ0uLYGwYp+WAsBEFBtEguybdf2GJT
 wnA4WYCP+dBI/SQFOBLog3Oi+jE1IN4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 10 Mar 2021 19:14:37 +0100
From: Michael Walle <michael@walle.cc>
To: Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org
Subject: Re: [PATCH 1/3] ASoC: simple-card-utils: Fix device module clock
In-Reply-To: <ca540fb6-2ea7-90b0-66ad-097e99b6e585@nvidia.com>
References: <1612939421-19900-2-git-send-email-spujar@nvidia.com>
 <20210309144156.18887-1-michael@walle.cc>
 <e8b80188-978c-29fa-b5d4-9788a9f2282f@nvidia.com>
 <611ed3362dee3b3b7c7a80edfe763fd0@walle.cc>
 <ca540fb6-2ea7-90b0-66ad-097e99b6e585@nvidia.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <6e6b312eb91b8b86ceaa8a52311ea437@walle.cc>
X-Sender: michael@walle.cc
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, robh@kernel.org,
 linux-kernel@vger.kernel.org, jonathanh@nvidia.com, sharadg@nvidia.com,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org
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

Hi Sameer, Hi Mark,

Am 2021-03-10 15:50, schrieb Sameer Pujar:
> On 3/10/2021 4:00 AM, Michael Walle wrote:
>> Am 2021-03-09 17:27, schrieb Sameer Pujar:
>>> On 3/9/2021 8:11 PM, Michael Walle wrote:
>>>>> If "clocks = <&xxx>" is specified from the CPU or Codec component
>>>>> device node, the clock is not getting enabled. Thus audio playback
>>>>> or capture fails.
>>>>> 
>>>>> Fix this by populating "simple_dai->clk" field when clocks property
>>>>> is specified from device node as well. Also tidy up by 
>>>>> re-organising
>>>>> conditional statements of parsing logic.
>>>>> 
>>>>> Fixes: bb6fc620c2ed ("ASoC: simple-card-utils: add
>>>>> asoc_simple_card_parse_clk()")
>>>>> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>>> 
>>>> This actually breaks sound on my board
>>>> (arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts).
>>>> The codec on this board (wm8904) has a fixed clock input (only
>>>> distinct
>>>> frequencies are supported) and uses the FLL of the codec to generate
>>>> the
>>>> desired sample rate.
>>>> 
>>>> It seems that after this patch the clock rate of the codecs clock
>>>> (rather
>>>> than the FLL) is tried to be changed. Which fails, because it 
>>>> doesn't
>>>> support arbitrary frequencies.
>>> 
>>> Yes, after the given change the clock will be updated if "*mclk-fs"
>>> property is specified.
>>> 
>>> DT you mentioned has property "simple-audio-card,mclk-fs = <256>",
>>> which means you need a clock that is a function of sample rate. But 
>>> as
>>> per above you want a fixed clock for MCLK. I think if you drop this
>>> property, the clock updates won't happen. Earlier for your case, this
>>> property was not used at all because the clock handle was not
>>> populated.
>> 
>> You mean to drop the mclk-fs property? I can't do that because I
>> actually need a frequency of 256 * sample rate. But that doesn't
>> necessarily need to be the MCLK, because the codec itself has a
>> FLL/PLL which can be used to generate any frequency for a given
>> MCLK. So that is a valid scenario. See also commit 13409d27cb39
>> ("ASoC: wm8904: configure sysclk/FLL automatically").
>> 
> 
> If I read this correctly below is the configuration you need,
> SoC -> MCLK(fixed rate) -> PLL(wm8904) -> PLL output (256 * fs) -> 
> sysclk
> 
> From the doc simple-card.txt, "simple-audio-card,mclk-fs" is a scaling
> factor for MCLK and hence I am not sure if it is correct to have
> "*mclk-fs" property when MCLK is fixed. In simple cases, codec sysclk
> direclty depends on MCLK and set_sysclk() callback helps. Your case
> requires PLL configuration and set_pll() may be a better alternative.
> However simple-card does not offer this yet. But even if this is
> added, there should be a way to suggest PLL output requirement as a
> function of sample rate.

But its also a scaling factor for the sysclk, then maybe the property
has a wrong name. And you might be right with your suggestion, but
as I said, this breaks sound on my board and whats even worse, it
breaks it for older kernel too, because of the Fixes tag.

Btw I'm pretty sure, the MCLK was enabled and disabled depending on
whether there was an audio stream, the last time I've measured the
clock.

Mark, can this patch please be reverted (with a Fixes tag) until
a proper fix is found which satisfies both needs?

-michael
