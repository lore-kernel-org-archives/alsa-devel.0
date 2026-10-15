Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B283CC6B30
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Oct 2026 00:55:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 757CF60203;
	Thu, 15 Oct 2026 02:55:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 757CF60203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792025713;
	bh=gPBXMDzmpIDAuVwm4MEAj5Pk1kjm+9mdF0/1JJH+6h4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=GLadNqWNIxqMwNaoIHIAok95EJJ+4JIS+s82VdXA2A6u+aV82NZ4DHXnFzcXdKcZq
	 Mhvm+VeHjIdrJsNUXPGxYSum33CC7Azc5ljSKjqNZalEZJUNk3+CtEXT0cr5O9ccAC
	 lHsrsfqyF/zlbW7RnB5AJUxOyma/nz++OfYRhmM8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 90E3AF805FB; Thu, 15 Oct 2026 02:54:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B9161F805F3;
	Thu, 15 Oct 2026 02:54:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 71785F804CF; Thu, 15 Oct 2026 02:54:33 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792025673;
	b=TQRn9/6NkqcVcVZIUB+MWjg7exYoskvyZPa+QQv/gukSu0e4xdDqn37f5Qk2ksGcVJva
	 bOemQlpGbhd1Xft7rllJ+Sj1JXaSjF3KYh/axJ4tyoV1Lh3XBiuI/es5wZ+iiIkF1b30m
	 krfbRIZC9YsxYlNSWdExgxsx7b7ka6Xm6k7R2SMq76jcUCLwDrtKQeYcqJvbqA081G4a0
	 G7NUqKqWOJgPmvPL3H4Smju43cdmn/mOV9uSBOEqOjZPlajt9U3Ii6Ok+820p85fFjswP
	 +Lby+VYrJmnahEIbW5umjbseZW4Ues+TwlhKvQ2kxnqg07O5YCMR6bkpFNov1svlJag==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792025673;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=gPBXMDzmpIDAuVwm4MEAj5Pk1kjm+9mdF0/1JJH+6h4=;
	b=gC5ILhqWyG/aD+507W51CmyoN0vjzxWpwI4yeEH8BWPUlSLwmvNjbp0qiATIsqV58KcV
	 Q04qiTQYN2qUSD04eKcI1XSe3d3o5AIE8SOg4pvGhIiQdpxSvxn8GkFG2GePAvNtBq3Bq
	 GH+eFtM9genxlTOAeoDDFy+7cQkzc/IIB9R91qUHCgo/gy0iHQQTfjw+pUKV2p3ZWmYzr
	 93YC16jLsOkHWB6MA20XtEMnrbkwm/mkU6rRWPmqy9rtyRqi4z6SiVfDwsJMNFDpY2eWP
	 SeTIQ7ma+Wg4Op44ahvbkkF7ozuKQH3LhG01rSyx5zPkhKyQXweEdPFnpNRACIQdyBg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 033F3F800BD
	for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2026 02:54:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 033F3F800BD
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18de8ddaa5052a00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/882@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/882@alsa-project.org>
Subject: USB-Audio: Steinberg UR44: support the non-class-compliant mode
Date: Thu, 15 Oct 2026 02:54:33 +0200 (CEST)
Message-ID-Hash: ZLI2XZZJN4NGFCR224PKOSCWQSDDWFS6
X-Message-ID-Hash: ZLI2XZZJN4NGFCR224PKOSCWQSDDWFS6
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZLI2XZZJN4NGFCR224PKOSCWQSDDWFS6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #882 was edited from peterix:

With its [CC MODE] switch off, the UR44 enumerates as 0499:150e and has six playback channels instead of four: DAW Mix 1, DAW Mix 2 and an FX Bus that feeds the built-in REV-X reverb (the channel order was checked with the device's own meters). Match that id, split the playback PCM from 4 or 6 channels, and add an "FX Bus" device when the FX Bus exists.

The Direct use case is defined inside the condition, as UCM evaluates Macro before If blocks.

I'm working on fully reverse engineering the UR-44 tools in both CC and non-CC mode and reimplementing a Linux version if them. This is in support of that work.

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/882
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/882.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
