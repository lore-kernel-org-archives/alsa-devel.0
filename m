Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32972CDB471
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:44:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2709560235;
	Mon, 22 Jun 2026 09:44:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2709560235
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782114284;
	bh=9NGg8hDxj2vdLvxEygzDIHhkUl++kdXXyURUQkJD64k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bhZ+WJ70RhKVwVvESN4yi0ltQQ9piuxz7gScq+bZIPeGIS8S7ERuYKNmk6TBSiYQO
	 wCT3xCLwxAFZ2V8gEFjZWKbuywl7axi4tg0S3H3/PXpZGSFRDeZcwRlGJd3rFdgUYk
	 nXgTiJl005voj/ai4zhaIl4/5YO8+AoR5pA2DEaM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 77256F80697; Mon, 22 Jun 2026 09:43:25 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A051F806B6;
	Mon, 22 Jun 2026 09:43:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 53B89F8047D; Mon, 15 Jun 2026 12:14:34 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=202.108.3.71
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781518473;
	b=rYEuqG9yOv6NvVB2cjGb/CyU3ZhRhtiRYL+7zkyk8Xl9KOFaCFOh45XSypl4d/z0+ZCm
	 W9kY81LPKsUPMw/a08OibQWiK8wacXONhO/+WK80n56Z/ZA+/MirUy6OXG/Ja9a2vKD+7
	 kbxAlO+C8b2VFb/VkCYxOLU8pH8xpHFhXDy4ePlXFbDciA13y6a/7wl84dzL2UeJTqSDi
	 u6xGtN8PYAfa/QKK0KVWTQjkyPWFy8bL3AboR/p50Gn1Uv1kWwo2ydNaMyQwbOTYWHcUQ
	 KH5tORH1+0TSuRuYRiOCF9xw9LkpjrL6LKgBOqpSPwG9QwEF816+asUlMeRcjjo6RyQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781518473;
	h=From:To:Subject:Date:Message-Id;
	bh=9NGg8hDxj2vdLvxEygzDIHhkUl++kdXXyURUQkJD64k=;
	b=O9UoOI9AWideJWrBjdSw33giUxzrp/eUQKNawy9SBFALPx3IRdzr42dceJbthcd5mWfW
	 LFbFTFM9fiL5OfrP3riqIjH/U0SmrqBXQbpXfngLwPydY/DK1jsZf649qKGaDxsJl2m1X
	 lFd3tnI6wiATiZ6qoUkGShInSU+LazOaBOY9ajDWOViF2NugDFfORTIF3BoblI/HS6q6v
	 jpAZOA6vJLO4Bl/9gWVlwHLhW3kAdlD40UJMoprD3Ii3ZW0np9QpquO7qm2pAsOSdp+Xn
	 SbHKcSX07Ui6mWecOlEiFPbG+xl+GyQ8sCuVp+DcNvVgnmLuw6PRo+t1hJWj+jdxbfQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=202.108.3.71
Received: from r3-71.sinamail.sina.com.cn (r3-71.sinamail.sina.com.cn
 [202.108.3.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BC4BFF800D0
	for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2026 12:14:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC4BFF800D0
Received: from unknown (HELO zy-virtual-machine.localdomain)([58.38.107.94])
	by sina.net (10.54.253.39) with ESMTP
	id 6A2FD08000007C99; Mon, 15 Jun 2026 18:14:25 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 889CB02C459244E5BEE42764EBC27718
X-SMAIL-UIID: 889CB02C459244E5BEE42764EBC27718-20260615-181425
From: Zhang Yi <zhangyi@everest-semi.com>
To: krzk@kernel.org
Cc: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	tiwai@suse.com,
	zhangyi@everest-semi.com
Subject: RE: [PATCH 7/7] ASoC: dt-bindings: ES8389: Add members about HPF and
 clock
Date: Mon, 15 Jun 2026 18:14:23 +0800
Message-Id: <20260615101423.19781-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <241d0fab-26ea-4c06-9928-e256f2cc5d1c@kernel.org>
References: <241d0fab-26ea-4c06-9928-e256f2cc5d1c@kernel.org>
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: ZYOU53XZ37JD7VUZAMCUITMG6K7Z5D2A
X-Message-ID-Hash: ZYOU53XZ37JD7VUZAMCUITMG6K7Z5D2A
X-Mailman-Approved-At: Mon, 22 Jun 2026 07:43:14 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZYOU53XZ37JD7VUZAMCUITMG6K7Z5D2A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> >>> Yes, setting mclk-from-sclk does not affect the MCLK connection.
> >>
> >> I am asking about wiring of the device. If MCLK is used from SCLK, but
> >> SCLK is used as the internal clock, then how can you still have MCLK
> >> connected?
> > 
> > If MCLK is derived from SCLK, whether the 'MCLK' pin on the device is
> > connected or not has no effect on operation.
> 
> If MCLK is connected, why would you derive it from SCLK? That's the
> point - your clocks property already might be telling everything needed
> here.

This is because sometimes the codec does not work properly
when using the MCLK provided by the CPU.

> >>>>> +
> >>>>> +  everest,hpfl:
> >>>>> +    $ref: /schemas/types.yaml#/definitions/uint8
> >>>>> +    description:
> >>>>> +      the HPF value of ADCL.
> >>>>
> >>>> Is HPF value in dB? If so, use proper unit suffix and proper units.
> >>>
> >>> No, the values here correspond to the values in the registers.
> >>> The value is not in dB
> >>
> >> What are the meanings of the register values?
> > 
> > The value of everest,hpfl is equal to the value of the corresponding register,
> > not the cutoff frequency of the HPF.
> 
> You keep avoiding answers.
> 
> I don't want you to encode standard units as register values.

I think I understand what you mean.
Do you want me to enter the physical values in DTS and then convert them to register values in the code?
