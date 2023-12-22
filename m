Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC93C46CD2
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jan 2024 18:54:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2BA0DF7A;
	Tue,  2 Jan 2024 19:54:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2BA0DF7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1704221669;
	bh=HFFoqpYdrroEwD3fY9XFdGIeZoeU6TPFj90wnzGUses=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=hhJ/Sr5F/mMEen23VH+WhnSLeSvSbtjMedEGdRg6RGaNsV+4fcfJE5XE/UJ2ddau8
	 oVqmIQEH58ZtClFVcSgNUTjk5eQ5FJ+JYH0dGyHE17F+7bfs8gQqnB/ZUSDbaNiYbG
	 okkfqd4IArGfciFS6DRXB78P1PCZ5KXnJsD5n9js=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4C45AF80845; Tue,  2 Jan 2024 19:51:05 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 27C90F80CC4;
	Tue,  2 Jan 2024 19:51:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5FE3FF8016E; Fri, 22 Dec 2023 10:20:01 +0100 (CET)
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5E3A2F80124
	for <alsa-devel@alsa-project.org>; Fri, 22 Dec 2023 10:19:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E3A2F80124
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 6A19C24E2E6;
	Fri, 22 Dec 2023 17:19:40 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 22 Dec
 2023 17:19:40 +0800
Received: from [192.168.125.131] (113.72.145.47) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 22 Dec
 2023 17:19:39 +0800
Message-ID: <c94b377a-1e21-4361-ae82-ca84d1dce60a@starfivetech.com>
Date: Fri, 22 Dec 2023 17:11:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] ASoC: starfive: Add drivers of Cadence
 Multi-Channel I2S Controller
To: Mark Brown <broonie@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Claudiu Beznea
	<Claudiu.Beznea@microchip.com>, Jaroslav Kysela <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor.dooley@microchip.com>, Walker Chen <walker.chen@starfivetech.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
References: <20231221033223.73201-1-xingyu.wu@starfivetech.com>
 <20231221033223.73201-3-xingyu.wu@starfivetech.com>
 <861f9b28-863d-48b0-8491-add4a286597e@sirena.org.uk>
Content-Language: en-US
From: Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <861f9b28-863d-48b0-8491-add4a286597e@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.47]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-MailFrom: xingyu.wu@starfivetech.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: LSPW3H7DHEEBT3HHZVZQK4ZVZE6GNDSS
X-Message-ID-Hash: LSPW3H7DHEEBT3HHZVZQK4ZVZE6GNDSS
X-Mailman-Approved-At: Mon, 01 Jan 2024 13:18:25 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LSPW3H7DHEEBT3HHZVZQK4ZVZE6GNDSS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 2023/12/21 20:55, Mark Brown wrote:
> On Thu, Dec 21, 2023 at 11:32:23AM +0800, Xingyu Wu wrote:
> 
>>  sound/soc/starfive/cdns-jh8100-i2s-pcm.c | 262 ++++++++
>>  sound/soc/starfive/cdns-jh8100-i2s.c     | 727 +++++++++++++++++++++++
>>  sound/soc/starfive/cdns-jh8100-i2s.h     | 171 ++++++
> 
> If this is a Cadence IP why is the entire driver SoC specific?

This a new driver about this Cadence I2S controller. Should I create a new folder and file like this:

sound/soc/cdns/cdns-i2s*

and I use different compatible to support other SoC like JH8100?

Best regards,
Xingyu Wu
