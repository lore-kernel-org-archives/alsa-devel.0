Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF84EB64DC
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Jul 2023 16:28:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C29D200;
	Fri, 21 Jul 2023 18:27:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C29D200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689956899;
	bh=iKn+OfuYg0Q2K9Wfol/dvpn8rCd3C49VeDo70O8Lqi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MwRV02v2QqL0GfVIroTKLJkvwmJeixHPSWRlA7o9vBuPGrZ/xKf51U49vSpnu67aR
	 zb+pdTRDtcp8WWZCk8JeAObfPu1Zatgpv27N2SbivRMsjRzmskh4Xs5kDtVAtaE8zO
	 pzIgTZU0y0V1sZIOWCn7s+77gx54t0DLCMfZ9sSc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 856DAF8032D; Fri, 21 Jul 2023 18:27:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 12ED7F80535;
	Fri, 21 Jul 2023 18:27:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B1694F8047D; Fri, 21 Jul 2023 18:26:55 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9881CF8007E
	for <alsa-devel@alsa-project.org>; Fri, 21 Jul 2023 18:26:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9881CF8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qL32q1cv
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0BE4D61D19;
	Fri, 21 Jul 2023 16:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC39C433C8;
	Fri, 21 Jul 2023 16:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689956808;
	bh=iKn+OfuYg0Q2K9Wfol/dvpn8rCd3C49VeDo70O8Lqi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qL32q1cvGF+Ksf+s+pmMKZhN+4IMrRlywFKRaFA3QW21CTe1TtIChVgCHWsa6jr8j
	 inEQlmPYesd0GZUMsJsaOzhBMDjZrgYGQqVM67n3pe+seUhN8t2kZtx/YtuIqaqpTy
	 Eg6vcgfoLrokzqq657B+ssn5oTZMMCBV6DR6i95UQ14oaZsKzrliKyP6YZHmnCo3b+
	 TA5PIjYcb6hp3MkEc4sR2yORD+LTiqWkse4onxBCuKVWCnQ3lJEOIzUdRp29dF7fzp
	 4nrH0j1w71bFZcCnQTTFup+Wfc0z3RkFqkvnS3APzD+6/1fAOyEGew9Y5aFMBXArw4
	 FfNKJDL8/GoRg==
Date: Fri, 21 Jul 2023 17:26:41 +0100
From: Lee Jones <lee@kernel.org>
To: broonie@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	linus.walleij@linaro.org, vkoul@kernel.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: robh+dt@kernel.org, conor+dt@kernel.org, lgirdwood@gmail.com,
	yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
	pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v5 0/6] Add cs42l43 PC focused SoundWire CODEC
Message-ID: <20230721162641.GD1908841@google.com>
References: <20230619095623.1987742-1-ckeepax@opensource.cirrus.com>
 <168992615492.1924396.13464534208592126033.b4-ty@kernel.org>
 <20230721075854.GA1908841@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721075854.GA1908841@google.com>
Message-ID-Hash: QSX7YGIRYUFTWRMJMN6JKI5H5RDRIWO7
X-Message-ID-Hash: QSX7YGIRYUFTWRMJMN6JKI5H5RDRIWO7
X-MailFrom: lee@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QSX7YGIRYUFTWRMJMN6JKI5H5RDRIWO7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Fri, 21 Jul 2023, Lee Jones wrote:

> On Fri, 21 Jul 2023, Lee Jones wrote:
> 
> > On Mon, 19 Jun 2023 10:56:17 +0100, Charles Keepax wrote:
> > > This patch chain adds support for the Cirrus Logic cs42l43 PC focused
> > > SoundWire CODEC. The chain is currently based of Lee's for-mfd-next
> > > branch.
> > > 
> > > Thanks,
> > > Charles
> > > 
> > > [...]
> > 
> > Applied, thanks!
> > 
> > [2/6] dt-bindings: mfd: cirrus,cs42l43: Add initial DT binding
> >       commit: e62ba8443b11f12b45c61444249458a2f8c2f4ef
> > [3/6] mfd: cs42l43: Add support for cs42l43 core driver
> >       commit: 843079209e1506c94fde797fc0ff914e2c9e6645
> > [4/6] pinctrl: cs42l43: Add support for the cs42l43
> >       commit: 85f034dd7ff0a66aded653cc91dbc406fba7cf1a
> 
> Pull-request to follow.

Doesn't build without the Soundwire header changes.

-- 
Lee Jones [李琼斯]
