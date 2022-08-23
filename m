Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA6DC32772
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Aug 2022 16:21:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0393D1675;
	Tue, 23 Aug 2022 18:20:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0393D1675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661271679;
	bh=2xJn1WWK1At2p7Qx2VZJ2urwi9MS7Qonux9saTi6cxE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dEnjEQ0YbWztNQWrx7XSHE1+TaG/MYt5g+itpARjlBeLNDCanYky+CWJDaxRXTr90
	 4Jz3jGRM1k2WlgvpP6NxoBW9qqslF02xkDT+LW2Q5F3Z8tLBzjuVnrJC8K7nAOU1Uy
	 y5MDMxqNUc9ZJJ/veZsvYDmR6RLe++7yF5UwV7Os=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85712F80152;
	Tue, 23 Aug 2022 18:20:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B8AA2F8020D; Tue, 23 Aug 2022 18:20:26 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0CDCF800C9
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2022 18:20:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0CDCF800C9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="nmOPq5WQ"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id F1503B81E60;
 Tue, 23 Aug 2022 16:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A689DC433C1;
 Tue, 23 Aug 2022 16:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661271617;
 bh=2xJn1WWK1At2p7Qx2VZJ2urwi9MS7Qonux9saTi6cxE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nmOPq5WQGWQ96KnwtoHrxZfM58H0paONa/YhufZgpdFYMrpLSVIu1VvFWNi/PSC1r
 BYpUGrpSLVBinRyu1otFZCOxYHdsMMK6kmsQIkhF1p0wRu8DY0Pdv/aKogb5SVEJuL
 MhrLkk+POT8MXMMibXJnpWil4tLZVnXcwijMHuebjHDDVoZKtqMKQCBLDq31CkkVy0
 BDuowVxTMMtgcHxq0EHnAeqrDZxdoJpVOv3tpNOHbUJZRZOvoTHGAAgJUH7A0JShCO
 qXSlXppXAkC3deVaAd97+PO+u/8ix3k/qfIij5qTTdJGfDmwe6IJcXSpOI7/9lE7Ex
 jdtXrUts8uahg==
Date: Tue, 23 Aug 2022 17:20:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Subject: Re: [PATCH] drm/bridge: dw-hdmi-i2s: set insert_pcuv bit if hardware
 supports it
Message-ID: <YwT+POnqJGHOHYcw@sirena.org.uk>
References: <YwF+JYR5DxLBnE8F@geday> <YwOEPpO0gux+njQe@sirena.org.uk>
 <YwToTmr4DI3k+STF@geday>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jAC6LpYhj9svfUcr"
Content-Disposition: inline
In-Reply-To: <YwToTmr4DI3k+STF@geday>
X-Cookie: You can't take damsel here now.
Cc: Sugar Zhang <sugar.zhang@rock-chips.com>,
 ALSA-devel <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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


--jAC6LpYhj9svfUcr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 23, 2022 at 11:46:38AM -0300, Geraldo Nascimento wrote:

> I think we may be able to restrict the fix for L-PCM only by checking
> byte 0 of iec.status, specifically bit 1. Our define is called
> IEC958_AES0_NONAUDIO but https://tech.ebu.ch/docs/tech/tech3250.pdf
> calls it the "Linear PCM identification" bit. There's also a
> supplement to AES/EBU 3250 in https://tech.ebu.ch/docs/n/n009_1.pdf

> Let me know if the following is OK. I'll be happy to submit V2 if
> it is.

LGTM, though I don't really know anything about the hardware
specifically.

--jAC6LpYhj9svfUcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmME/jwACgkQJNaLcl1U
h9DtYQf+Lxv7tyWQXUfDGmrjE2KgJ3xMGZ3h/nGiqNv0pJuF52cCuSAhGiG8kV7B
nMyFqlov/r/Ukq62PQiZiEVLpbSgT046M4unsnbbBDDCcK2x7O1i17I7h7vbjIlS
IVGJAGmCG5YHopNC5UWxlmelTkC/7dtUON+5amuRzKKQ8XdnESKGPeIGsexAqdOx
V1mQdY28AVXVDrwFxWZiHHkk5UYlVPREmFPVdEOgXaWDCng40mHQmEzt8jMQhq6C
kRLkE137LUMOtRSST6nKs7h7RWGFySpay8qMRoN7KyNEVgFNuBvlRug+ckvXpMjf
GDhDmcB81MpEKFenbFYhuE08DTzY1g==
=fnfJ
-----END PGP SIGNATURE-----

--jAC6LpYhj9svfUcr--
