Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4339CC7EE22
	for <alsa-devel@archiver.kernel.org>; Mon, 15 May 2023 12:29:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 272D31E3;
	Mon, 15 May 2023 14:28:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 272D31E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684153757;
	bh=mnBn2I7iZacDzDQ3pRjdJjSk6tXlv5R1B3tpPeni6tI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rAei3fcbnm4IULVvuiR6VtPMdMX7bZ9kx77hk3qRezRHAvEHjE9TWwcvhlTFHxAMr
	 KzoSIPywLsQCOdGCOsLjEBaOE1tHoe9tq4+pM6xglZ3n9ed7qf1Sa/77Svv4awbbDb
	 1wWccWIqndpXzlVTiGenMNjeLFlnMaGf0xgBv8Vs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 25B26F805D2; Mon, 15 May 2023 14:26:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 90334F805D2;
	Mon, 15 May 2023 14:26:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D46D6F80272; Mon, 15 May 2023 10:29:31 +0200 (CEST)
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B1C78F8016D
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2023 10:29:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1C78F8016D
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id B2F0A24E1B5;
	Mon, 15 May 2023 16:29:08 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 15 May
 2023 16:29:08 +0800
Received: from [192.168.125.124] (113.72.146.187) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 15 May
 2023 16:29:07 +0800
Message-ID: <21bc5b06-3d3e-5a30-a90d-ea9f7abc6575@starfivetech.com>
Date: Mon, 15 May 2023 16:29:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 2/3] ASoC: starfive: Add JH7110 TDM driver
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Claudiu Beznea <Claudiu.Beznea@microchip.com>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor.dooley@microchip.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>
CC: <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230511091549.28003-1-walker.chen@starfivetech.com>
 <20230511091549.28003-3-walker.chen@starfivetech.com>
From: Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <20230511091549.28003-3-walker.chen@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.146.187]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-MailFrom: walker.chen@starfivetech.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 3MBMVO5OOXUIOLENOSXEUCGAO4AVZEAL
X-Message-ID-Hash: 3MBMVO5OOXUIOLENOSXEUCGAO4AVZEAL
X-Mailman-Approved-At: Mon, 15 May 2023 12:26:01 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3MBMVO5OOXUIOLENOSXEUCGAO4AVZEAL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On 2023/5/11 17:15, Walker Chen wrote:
> Add tdm driver support for the StarFive JH7110 SoC.
> 
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
>  MAINTAINERS                     |   6 +
>  sound/soc/Kconfig               |   1 +
>  sound/soc/Makefile              |   1 +
>  sound/soc/starfive/Kconfig      |  15 +
>  sound/soc/starfive/Makefile     |   2 +
>  sound/soc/starfive/jh7110_tdm.c | 554 ++++++++++++++++++++++++++++++++
>  sound/soc/starfive/jh7110_tdm.h | 138 ++++++++
>  7 files changed, 717 insertions(+)
>  create mode 100644 sound/soc/starfive/Kconfig
>  create mode 100644 sound/soc/starfive/Makefile
>  create mode 100644 sound/soc/starfive/jh7110_tdm.c
>  create mode 100644 sound/soc/starfive/jh7110_tdm.h
> 

Hi Mark / Claudiu,

I have submitted new version of patch for TDM driver. Could you please help to review and give your comments? 
Thanks a lot!

Best regards,
Walker
