Return-Path: <SRS0=GC6S=PO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFE6C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 10:46:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B71B60E75
	for <alsa-devel@archiver.kernel.org>; Tue, 26 Oct 2021 10:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B71B60E75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E59B16E0;
	Tue, 26 Oct 2021 12:45:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E59B16E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635245194;
	bh=ttuMSMdKfO/8vL/8XwgI4pPgoy8Qb+Z1lOdVA9rTS24=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=de/uoB+XnXel2YFp/MWJ+Ij4k/UphsKzWZfQ78Loivjc+nOiZI/0N0fol9KM5ZBxp
	 Y2dXgzHoD8QYCzNvrTRRVyoaJvUf5+1HuvNP5hms7sisQFzoarPSQP5HFFyX63d4Gu
	 6RGKL+n9et37hU8/tC8O8X9cEC6+86Ix1iPg7t8Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7FD85F80105;
	Tue, 26 Oct 2021 12:43:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1C348F80105; Tue, 26 Oct 2021 12:43:25 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80991F80105
 for <alsa-devel@alsa-project.org>; Tue, 26 Oct 2021 12:43:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80991F80105
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Pn1ab9W0"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BA0660E75;
 Tue, 26 Oct 2021 10:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1635244999;
 bh=ttuMSMdKfO/8vL/8XwgI4pPgoy8Qb+Z1lOdVA9rTS24=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Pn1ab9W0iOXgbFH1YO71VMO1R/W4CV97vKsUfoENZpun08l9EVPS4JikWeLpzfHAY
 22uMmKer7aXSM5xyGixPD5DOJuWYAlEaLaWuL1dYWIGUv/544eY3+XLR8emZmAj0Kd
 ybIpazvd1urN0kUKr0Xb/diSm2fZUZfdCIwMc9EuJJMlNDO5/nn4Z4x2hFwtsmEFdQ
 VAd6tNHAHnyLKtYcpQIc1fUQnlkBN5XIs/WKe4Y1bmDe72fNzT8/o9FsjQ/HglqLoF
 0YSfI9K2a68jpCywOyBg2OZz7k7m3c7kanuNIXoheYV68u8zXWpw9hfUPgugZLmu64
 Ah2FnJJpgKy8g==
Date: Tue, 26 Oct 2021 11:43:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Ricard Wanderlof <ricardw@axis.com>
Subject: Re: [PATCH 2/2] ASoC: codec: tlv320adc3xxx: New codec driver
Message-ID: <YXfbw50xR9AQuQZ5@sirena.org.uk>
References: <alpine.DEB.2.21.2110041117540.14472@lnxricardw1.se.axis.com>
 <YVsETxqzhZI8Fb6D@sirena.org.uk>
 <alpine.DEB.2.21.2110041716190.14472@lnxricardw1.se.axis.com>
 <YVsu+QMjOQz8pAzY@sirena.org.uk>
 <alpine.DEB.2.21.2110251755410.26101@lnxricardw1.se.axis.com>
 <YXbXO1d1XDFwUXqA@sirena.org.uk>
 <alpine.DEB.2.21.2110260852120.26101@lnxricardw1.se.axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VtVOTpwNy9opdNZ+"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2110260852120.26101@lnxricardw1.se.axis.com>
X-Cookie: Times approximate.
Cc: alsa-devel <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>
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


--VtVOTpwNy9opdNZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 26, 2021 at 08:54:26AM +0200, Ricard Wanderlof wrote:
> On Mon, 25 Oct 2021, Mark Brown wrote:

> > In any design we really ought to have some explicit confirmation before
> > we allow users to go randomly changing voltages, it may cause damage if
> > someone gets it wrong.  This means that the feature really ought to be
> > an opt in one if it's going to be there.

> Good point.=20

> So like a module parameter, or perhaps governed something in sysfs?

I was more thinking a DT property TBH.

--VtVOTpwNy9opdNZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmF328IACgkQJNaLcl1U
h9BjAwf/VchI9msLvxF5a1H+k649r+KM5EuGg0nj0iDFLQW5Qo3VYLR+Z7CdL9sl
G5zGsjGBP9+Hf9mZ5fdH2huu8WgTXBehcit6i6isk5KRhf9FTOzHGmS3tfHgtELU
Utbr08jmld7NI357wlsMoY50P/EV1lZBbH1N3Ab1W/zhuPL/VCp8/pucZuYrgdmO
4ZO6IlfQBmkgGAXU7FsfbvaMMKO359liOEmJNnvNRE6TkP4Vn5LF3X2bmibMBVLw
DaAiGf4yDdqx/9UoSfqzHBxl1QTvhkgVy63DkB97FIDE1RyKUzgAPBmErRI/Ng/V
OlCPBrSehiMmjVcRFa8H52NnNw1p0g==
=AlGg
-----END PGP SIGNATURE-----

--VtVOTpwNy9opdNZ+--
