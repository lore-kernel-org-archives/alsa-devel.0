Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE450C77B75
	for <alsa-devel@archiver.kernel.org>; Mon,  8 May 2023 07:52:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F1E312E4;
	Mon,  8 May 2023 09:51:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F1E312E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683532320;
	bh=3PIiwwkiGJKz5j06qE3bKPL3ulql1gHeBE8eedPG2VU=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YiRh5nSQOQNTOC8uXsSK6yUe02+KcSa5zFdlbHUvuFi3/vNfjN8heeBgTvq57Q17y
	 eJyn694YWzN0j1/FlZzXr3KOGs8fz5MqRQvpDeEoLPfSRLyG/fpw3wzHWJb2D/jbiF
	 Fz9NcErlSvwxYH9/+fWGSyEZNdhWtIIc7CO9BsaI=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B4261F805F6;
	Mon,  8 May 2023 09:46:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B38E3F8032D; Mon,  8 May 2023 04:44:49 +0200 (CEST)
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3AC19F80087
	for <alsa-devel@alsa-project.org>; Mon,  8 May 2023 04:44:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3AC19F80087
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 4CCD524DBC2;
	Mon,  8 May 2023 10:44:33 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 8 May
 2023 10:44:33 +0800
Received: from [192.168.125.124] (183.27.98.219) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 8 May
 2023 10:44:32 +0800
Message-ID: <54494959-f2cb-d962-ca27-d5d08e70da93@starfivetech.com>
Date: Mon, 8 May 2023 10:44:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 1/3] dt-bindings: sound: Add TDM for StarFive JH7110
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
References: <20230506090116.9206-1-walker.chen@starfivetech.com>
 <20230506090116.9206-2-walker.chen@starfivetech.com>
 <ZFhQujhpbt/7yGGc@finisterre.sirena.org.uk>
From: Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <ZFhQujhpbt/7yGGc@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.98.219]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-MailFrom: walker.chen@starfivetech.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: I4FT5VPZATDTSNKIBCRPHWO3FXMOKYQJ
X-Message-ID-Hash: I4FT5VPZATDTSNKIBCRPHWO3FXMOKYQJ
X-Mailman-Approved-At: Mon, 08 May 2023 07:46:29 +0000
CC: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I4FT5VPZATDTSNKIBCRPHWO3FXMOKYQJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 2023/5/8 9:30, Mark Brown wrote:
> On Sat, May 06, 2023 at 05:01:14PM +0800, Walker Chen wrote:
>> Add bindings to describe the TDM driver for the StarFive JH7110 SoC.
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Thanks for your reminder, I will pay attention to this when submitting
 patches in the future.

Best regards,
Walker
