Return-Path: <SRS0=A1sP=CN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB5CC433E2
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 02:55:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98161206D4
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2020 02:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mmq5SkOk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="NZEOWGU5";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FE2CLV0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98161206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sholland.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1CA0F1AB0;
	Fri,  4 Sep 2020 04:54:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1CA0F1AB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599188149;
	bh=HsnZBWLbLAjmZRFZHZ7SDN/rfFRskuvm14yanyoCKE0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mmq5SkOkyChb0FcoFIX8grJDG4e3X9+Y07iKBRKC0CrAqKJvG0vUM4gG2okjxBVOc
	 kfg2UnxIgoa4m0csKk3jzLpwpuOgjCWfFeAg1wrr7VqyukEQpUYnjKOmX0Awq31qW5
	 FDkVBij+Vn458Xi2DyewbPiP8wE7/pv0+uQ15ojw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D61AF801DA;
	Fri,  4 Sep 2020 04:54:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 70C02F8024A; Fri,  4 Sep 2020 04:54:55 +0200 (CEST)
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E6099F801DA
 for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2020 04:54:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E6099F801DA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org
 header.b="NZEOWGU5"; 
 dkim=pass (2048-bit key) header.d=messagingengine.com
 header.i=@messagingengine.com header.b="FE2CLV0Q"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailnew.west.internal (Postfix) with ESMTP id 890341215;
 Thu,  3 Sep 2020 22:54:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Thu, 03 Sep 2020 22:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 subject:to:cc:references:from:message-id:date:mime-version
 :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=2
 MrtNsPdGNPef5FGEOgH91i69aC1KMGFVmVOimjCpVk=; b=NZEOWGU5IZzlKIvKW
 7A57X+yxV1mOcKljSbP52OK/teyu7AsGvGS7OKwPuT9N29Uojt5pepmCag47uXen
 7w2bSGGQGa3CQB4kaHwFsy25pHiibDST3NSZAyT9ZF4KqVCGpnrvLAztFAy3bgWm
 1C25Aw0glDKqL41niLNdtfgYqITATrcVlOvxbtumwWjinlmSbj6Qz2FNSQeUnVLZ
 wISaravx3QBJ+HF8v1m0C/ZrR1r5hI/lhTN4UcnvxhV8W6tgXz+prHousFZZsMEu
 ZSO0rWT11aQFE/6skGlxdnC7dqP4owB2go8COCoI6rcGTqUHsegmud5B6gKwGz51
 cDkhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :date:from:in-reply-to:message-id:mime-version:references
 :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; bh=2MrtNsPdGNPef5FGEOgH91i69aC1KMGFVmVOimjCp
 Vk=; b=FE2CLV0QUfcQ7FGV3QbSwgb8HtsdIn/zGP6Jam3SJNGIqFD+ya6f9vuWo
 9nRNmRRDTFsBT27S1hegzWdoD1ibVgWPHHHG5juE2kOb1UuZvTLkdhnG1u+bXFj2
 gT9Pxi9SpKyNQbmfnEXUA68/Rnv9g45tigDtwzc1WR89HPNfBavD0SY2UCjYnp7G
 oGbT2n+eQR7eA8SBV9AEh8WlV1rUanG5izgDYg2EoY68R8rWQH1DDNgYYyb5p7+q
 lcHgkOfEJMGyuVUdxbKcTO8Ds1BVTyK8w4xKD8cwaw84w/jQhwPMqgLgr9uepl3H
 +hmuSeiWbx8BZXLnZnloE5FzIftQg==
X-ME-Sender: <xms:cKxRX4RT2pMhAMn_YkI-TpoFMwfbFvM6PB1fMfnzUXgsOiC9TjRPDg>
 <xme:cKxRX1xDpNhS45dj975Rkrv2BfwBvH1HMOIbClaLyoCUia6dt9jIpr2SgGyjy0oTF
 o2CHJRLSGqcek69GQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegvddgieegucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepuddvleffkeejhfduieelheejteehleefieeikefgteeugefhtdev
 keefvefgheeinecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepjedtrddufe
 ehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
 lhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:cKxRX12upaoOiqkof3NsEibZYtSy5AY-ezAEzgX6QTQt3aKDRl2MPg>
 <xmx:cKxRX8A30is-bbvw5yq7suIZdXE7gdtEqMXZcEwI7111LlmrdoPnpA>
 <xmx:cKxRXxgB3KdIb4x6GNXpInTeVUvNE6yEsIrqJxXeBxGjRBacie7fGQ>
 <xmx:cqxRX8qsvBZR9o2fIGJPkqKi-HWeWSSTJ8Th7Fh-oR842UNtwT-SYRs_qvQ>
Received: from [192.168.50.169]
 (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
 by mail.messagingengine.com (Postfix) with ESMTPA id 1A946328005D;
 Thu,  3 Sep 2020 22:54:40 -0400 (EDT)
Subject: Re: [PATCH v3 3/7] ASoC: sun4i-i2s: Add support for H6 I2S
To: Maxime Ripard <maxime@cerno.tech>, =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?=
 <peron.clem@gmail.com>
References: <CAJiuCcdVs_drs40Q6537BYfz24F7NmC6B8S5-Lt4V4ggs-FXWA@mail.gmail.com>
 <20200429123529.y24dpy63wxq7uvkt@gilmour.lan>
 <CAJiuCcfXqizcq_JuXRCsqEqM2562cr1SGJ0pmy07jcJxAXojOw@mail.gmail.com>
 <20200430084600.samghw4zxb5zdbez@gilmour.lan>
 <CAJiuCcf_LHrJ6QdZgH8HyN6TRiT+GiD+t4UggFCrz-VwVHXV6w@mail.gmail.com>
 <20200504120942.lnrxnnmykqnvw3fb@gilmour.lan>
 <CAJiuCceF340FiLvyeXNZtvqftQMAmk=MtFDLT_9696ix+eH1Yw@mail.gmail.com>
 <20200729143927.47f5tbuaob4ph3lp@gilmour.lan>
 <20200729151548.GB5612@sirena.org.uk>
 <CAJiuCcdf=TNLPTUPzHP9NzPHqdxG06TRDkQfONY+ScK0DV_v5w@mail.gmail.com>
 <20200903205851.gdnpthserywsxrbs@gilmour.lan>
From: Samuel Holland <samuel@sholland.org>
Message-ID: <80b5a4e3-c8bc-9521-4ff1-12bb6424516f@sholland.org>
Date: Thu, 3 Sep 2020 21:54:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200903205851.gdnpthserywsxrbs@gilmour.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: devicetree <devicetree@vger.kernel.org>,
 Linux-ALSA <alsa-devel@alsa-project.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Jernej Skrabec <jernej.skrabec@siol.net>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Mark Brown <broonie@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

Maxime,

On 9/3/20 3:58 PM, Maxime Ripard wrote:
> On Thu, Sep 03, 2020 at 10:02:31PM +0200, Clément Péron wrote:
>> Hi Maxime,
>>
>> On Wed, 29 Jul 2020 at 17:16, Mark Brown <broonie@kernel.org> wrote:
>>>
>>> On Wed, Jul 29, 2020 at 04:39:27PM +0200, Maxime Ripard wrote:
>>>
>>>> It really looks like the polarity of LRCK is fine though. The first word
>>>> is sent with LRCK low, and then high, so we have channel 0 and then
>>>> channel 1 which seems to be the proper ordering?

Which image file is this in reference to?

>>> Yes, that's normal.
>>
>> Thank you very much for this test.
>>
>> So I will revert the following commit:
>>
>> ASoC: sun4i-i2s: Fix the LRCK polarity
>>
>> https://github.com/clementperon/linux/commit/dd657eae8164f7e4bafe8b875031a7c6c50646a9
> 
> Like I said, the current code is working as expected with regard to the
> LRCK polarity. The issue is that the samples are delayed and start to be
> transmitted on the wrong phase of the signal.

Since an I2S LRCK frame is radially symmetric, "wrong phase" and "inverted
polarity" look the same. The only way to definitively distinguish them is by
looking at the sample data.

In "i2s-h6.png", the samples are all zeroes, so you're assuming that the first
sample transmitted (that is, when the bit clock starts transitioning) was a
"left" sample.

However, in "h6-i2s-start-data.png", there are pairs of samples we can look at.
I'm still assuming that similar samples are a left/right pair, but that's
probably a safe assumption. Here we see the first sample in each pair is
transmitted with LRCK *high*, and the second sample in the pair is transmitted
with LRCK *low*. This is the opposite of your claim above.

An ideal test would put left/right markers and frame numbers in the data
channel. The Python script below can generate such a file. Then you would know
how much startup delay there is, which channel the "first sample" came from, and
how each channel maps to the LRCK level.

It would also be helpful to test DSP_A mode, where the LRCK signal is asymmetric
and an inversion would be obvious.

> But the LRCK polarity is fine.
> 
> Maxime
> 

Samuel

----8<----
import wave
from struct import Struct

markers = (0x2, 0xe)
rate    = 8000
seconds = 10

struct  = Struct('<' + 'H' * len(markers))
nframes = seconds * rate
data    = bytearray(nframes * struct.size)

for i in range(nframes):
    frame  = [(m << 12) + (i % 2**12) for m in markers]
    offset = i * struct.size
    struct.pack_into(data, offset, *frame)

with wave.open('test.wav', 'wb') as wf:
    wf.setparams((len(markers), 2, rate, nframes, 'NONE', ''))
    wf.writeframes(data)
