Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACCFEEAA60
	for <alsa-devel@archiver.kernel.org>; Thu, 14 Sep 2023 18:04:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1BC1B950;
	Thu, 14 Sep 2023 20:04:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1BC1B950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1694714690;
	bh=8NOwEimiz5utIwlrYbbH86DF07k5LPS1/j4o7pD0F/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RTvnng+ibnP/Um+JeBRLa6XRJ5rLI7lOL5cHorPQ8nx4Aa7silTMoqjXTuO4Tyx+O
	 gkPDRc4TinMmegLyCiUJP8+KefmMmSE0GiQbU7ydJVJ8ZMsG701w+B18pOV9f6tgOy
	 yy1AGUUVkl+NUSgZ1eJGGPMW+/g4SwC50cISG51c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E7850F80431; Thu, 14 Sep 2023 20:03:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 88F13F80425;
	Thu, 14 Sep 2023 20:03:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2099FF80425; Wed, 13 Sep 2023 06:17:01 +0200 (CEST)
Received: from smtp4.hiworks.co.kr (smtp4.hiworks.co.kr [121.254.168.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B5846F80212
	for <alsa-devel@alsa-project.org>; Wed, 13 Sep 2023 06:16:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5846F80212
Received: (qmail 79719 invoked from network); 13 Sep 2023 13:16:45 +0900
Received: from unknown (HELO hiworks.co.kr) (192.168.10.38)
	by 0 (qmail 1.03 + ejcp v14) with SMTP;
	13 Sep 2023 13:16:45 +0900
Received: (qmail 9269 invoked from network); 13 Sep 2023 13:16:45 +0900
Received: from unknown (HELO saram-MINIPC-PN53..)
 (mwkim@gaonchips.com@220.88.49.178)
	by 0 (qmail 1.03 + ejcp v14) with SMTP;
	13 Sep 2023 13:16:45 +0900
X-Authinfo: HIWORKS SMTP authenticated
 <mwkim@gaonchips.com|220.88.49.178|mwkim@gaonchips.com|230913131645_26618989>
X-MailFrom-INFO: Info <country_code:KR|rbl_level:0>
From: Myunguk Kim <mwkim@gaonchips.com>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	fido_max@inbox.ru,
	joabreu@synopsys.com,
	krzysztof.kozlowski+dt@linaro.org,
	kuninori.morimoto.gx@renesas.com,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	mwkim@gaonchips.com,
	perex@perex.cz,
	robh+dt@kernel.org,
	tiwai@suse.com,
	u.kleine-koenig@pengutronix.de,
	xingyu.wu@starfivetech.com
Subject: Re: [PATCH] ASoC: dwc: Add Single DMA mode support
Date: Wed, 13 Sep 2023 13:09:03 +0900
Message-Id: <20230913040902.1496711-1-mwkim@gaonchips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZP8Irf6g+sG6Ax9j@finisterre.sirena.org.uk>
References: <ZP8Irf6g+sG6Ax9j@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: mwkim@gaonchips.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: DN6YOAS4ZQGOFBAAYPHCFDQ5A3H5GFKU
X-Message-ID-Hash: DN6YOAS4ZQGOFBAAYPHCFDQ5A3H5GFKU
X-Mailman-Approved-At: Thu, 14 Sep 2023 18:03:22 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DN6YOAS4ZQGOFBAAYPHCFDQ5A3H5GFKU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> This feels like something we ought to be discovering from the DMA API
> somehow, while it's not quite a property of the DMA controller (but
> rather of the SoC integration) in this case it could be a property of
> some DMA controller elsewhere and the whole process of finding and
> figuring out the properties of the DMA controler is handled by the DMA
> API.

In this case, it is not used through the DMA API. 
The connection relationship is as follows.
  i2s --- pcm_dmaengine ---  DMA IP (ie. pl330)
So, control was possible only by directly setting the maxburst property.

And, I will send v2 (separate code and bindings)

Thanks,
myunguk

