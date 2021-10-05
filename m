Return-Path: <SRS0=jGB1=OZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420CCC433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Oct 2021 17:27:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D8E61350
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Oct 2021 17:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 80D8E61350
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 96BB51657;
	Tue,  5 Oct 2021 19:26:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 96BB51657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633454867;
	bh=c1/OLzR8tMnoKwUI/lCBwWX7fp+J2Fgb3rYYU36SGek=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mrRjGdWYoFVXk6+w1Xtf6ZCcdAtU91gRY+hkzyOLpaapLepTHaPRlrRpq/aiSQ3do
	 DGuMNxDEV2hTWFCkPrKK1wgpeJsdG35Z89k4hE996W9cENN53HhRXj2iZ1S76wTKQ5
	 7DHXr8R8TYQ+UlFz5n5qnesEUkSiA4kdTymjPyRE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 20FA9F8020D;
	Tue,  5 Oct 2021 19:26:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6856CF8027D; Tue,  5 Oct 2021 19:26:55 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 69701F8020D
 for <alsa-devel@alsa-project.org>; Tue,  5 Oct 2021 19:26:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69701F8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="OEM5ovPO"
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA8E361184;
 Tue,  5 Oct 2021 17:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633454808;
 bh=c1/OLzR8tMnoKwUI/lCBwWX7fp+J2Fgb3rYYU36SGek=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OEM5ovPOFfH933FVwLIC2aqzTTP/zgJlge/2cZqy7DQtWlqIpYJNzjEBOU3DXhDxS
 FOKz+NLNR76VeqQQOhfiYZ6DF439dBkXVTscuZ+IxYf1tzqucNzKEwBibxBGyMG4m5
 AECO1HFwvs9sNN4OGrociNCcOGiCwF2yf+kxOgIqli4fvg6hBQmqchibDvIjK07ksB
 GU/9rXnhI5wcDuinR8SFGnJKHKgtTnJfykl80Gb6BUbAGkqwc3rRaeYAWProp8YJLX
 JGs2IWcQns8tpUZZKqLCaL+3pAgQhSJ6RCfuHkJlgim2qUAL0uAL5zif1RIMhDRQp/
 ewlOEBLVEffWQ==
Date: Tue, 5 Oct 2021 18:26:45 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH v3 09/16] ASoC: add Rich Graph Card Yaml Document
Message-ID: <YVyK1UdPxB2lFRys@sirena.org.uk>
References: <87tuitusy4.wl-kuninori.morimoto.gx@renesas.com>
 <87h7etusv4.wl-kuninori.morimoto.gx@renesas.com>
 <20211001210642.GF5080@sirena.org.uk>
 <87mtnp5zij.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="safgnefJXTd1LIzR"
Content-Disposition: inline
In-Reply-To: <87mtnp5zij.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: A is for Apple.
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
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


--safgnefJXTd1LIzR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 04, 2021 at 10:50:44AM +0900, Kuninori Morimoto wrote:

> I'm looking forward to your detail review,
> and happy to create v4

Please just go ahead and send v4, I don't think I've got anything
really.

--safgnefJXTd1LIzR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFcitUACgkQJNaLcl1U
h9CwIQf/QPrJamCf2EXS1j+S4h4fDIBL8ek1XC8hoqF8GLKqC1QOSj8SKEo9LncN
F9A5mWwYiUn6jb/aiU/LHAXVRZvOSVsmBS7Uqal4RNaUyGBRSp6jRHfZmJR0XJ+M
nCVQ7jyLgkGI0M2s14yeLfqr4VAeuXSWzsmNb5YUR0HNdiOGBuTqYe2cGOXtzweh
DJ0X6fMGkEisptUzOncjIy8F3j7Fb9YR+KOKis4kJyotqtyq1A+/WxGhj/LlZpt7
CEauLwxpQW9Y0mXnBJfT+KgjIA/dIqyx6gBF92ASLANBLBjMWDEz2I+Zh3O3SdqW
VLk4gybCH5mA/5+81wel/cxERS/UnA==
=Un3b
-----END PGP SIGNATURE-----

--safgnefJXTd1LIzR--
