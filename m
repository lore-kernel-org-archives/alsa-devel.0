Return-Path: <SRS0=CVmM=PH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC45C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Oct 2021 19:45:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9BD060F6E
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Oct 2021 19:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C9BD060F6E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DDDA1698;
	Tue, 19 Oct 2021 21:45:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DDDA1698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634672755;
	bh=S7HUAsEBBESlNc4/I+ON75vYB4mdK5gg8TGkIrAVpqc=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X53wGhfF9nymBmKWtRc7oDkrc+Q+NLfdo9o6db+JS2ZfO0q35i64ivLRqv37Wnogp
	 EeBJ+a10YzFO/ksodC6El2HQDwy9rc8w9jakZp2/dCcUkiZDrrzxHdxCUz41trPnd9
	 XEc20TOneTQ1fCpTu56rbla98EGljdKSpP/fWERA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A7958F8019B;
	Tue, 19 Oct 2021 21:45:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 402A9F80240; Tue, 19 Oct 2021 21:45:01 +0200 (CEST)
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D139EF80155
 for <alsa-devel@alsa-project.org>; Tue, 19 Oct 2021 21:44:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D139EF80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="Xpz1VDBO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=ikxZZf5qplCBT+zQNa/Q3/V1ehE/BtQKefk6PvgVhMI=; b=Xpz1VDBO13VAz0YldOrMMO+3C9
 G3dnSCDwHIM98RYiz37ambGdNlG/vGfX8efOKBnMQzqXWktS3F9f2zNTePCuC/x7ZBofHbLyWWzII
 4XWJwmEKaSbzxNtk6uwmTBjA0WgWUhpispL3FuvyBYf5vvCpDE34UZU7tKE9ZWHmrQ6X/OVcSQZda
 P0cjI8Arj3PR+XBV47pDJVFdeKPGb7P8y3MLJ1mueVME0ArSY4+kVp6EyMO5vNQytMo7TauWCZwjl
 txjZLIyE4rB/W98cknDsGr6TVqsU+uwdt0G/+9p0lpEXsUAAMP4VWQeu/OtgHwJqA3mAA8aK7Gnwi
 8g793Wgw==;
Received: from [2601:1c0:6280:3f0::aa0b]
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcv2W-002XOP-Dm; Tue, 19 Oct 2021 19:44:48 +0000
Subject: Re: [v4] ASoC: max98520: add max98520 audio amplifier driver
To: George Song <george.song@maximintegrated.com>, lgirdwood@gmail.com,
 broonie@kernel.org, robh+dt@kernel.org
References: <20211019084914.14622-1-george.song@maximintegrated.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6c6d2ea5-e138-960b-bb83-fadf5c2996f7@infradead.org>
Date: Tue, 19 Oct 2021 12:44:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211019084914.14622-1-george.song@maximintegrated.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 steves.lee@maximintegrated.com, ryans.lee@maximintegrated.com,
 george.song@analog.com, linux-kernel@vger.kernel.org
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

On 10/19/21 1:49 AM, George Song wrote:
> +config SND_SOC_MAX98520
> +	tristate "Maxim Integrated MAX98520 Speaker Amplifier"
> +	depends on I2C
> +	help
> +	  Enable support for Maxim Integrated MAX98520 audio
> +	  amplifier, which implements a tripler charge pump

                                         ^^^^^^^ correct or typo?

> +	  based boost converter and support sample rates of

	                            supports

> +	  8KHz to 192KHz.


-- 
~Randy
