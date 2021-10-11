Return-Path: <SRS0=u8hq=O7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40105C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Oct 2021 11:09:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE5B460EB4
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Oct 2021 11:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CE5B460EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A04AB74C;
	Mon, 11 Oct 2021 13:08:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A04AB74C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633950578;
	bh=ogwMBxl7EB0c9hPuRe/PSgNEtronfXBPeJVozAbhz8k=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GBbizAfLrcpOn5QBPV8ebbjsN/cI4FBi+RzpCAoOwCVIUZVutK3R5OMhUrAk612Ul
	 bkIK/JdPaeDFpyFDgEDoZsIsKD71XjsfT+N2lVlqjfUtgZw25XD1kj397na43cnD2l
	 qWRoOFiIJYTHGOm+06mP9wk7vYGA64bIRyCfQL7k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CFCDF8025B;
	Mon, 11 Oct 2021 13:08:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C07F3F80269; Mon, 11 Oct 2021 13:08:46 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5FF89F8016D
 for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2021 13:08:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5FF89F8016D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bv5oXmmG"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 346C161039;
 Mon, 11 Oct 2021 11:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633950518;
 bh=ogwMBxl7EB0c9hPuRe/PSgNEtronfXBPeJVozAbhz8k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bv5oXmmGObfks3Qg7a1USYhA0d+LvgBfSsWY4fxP4TE27MBaR/CteU+SUowrs8Rpp
 2sByqpD4p0zn0hiIj4QtFu1qATV5346JUG1U6unb79W+jNKj0lPKUIkKgbXL2dF4sT
 JVTrhwQCbdno4HUdVg2zPLxhXRWL5FoyisTPDK3UVrE8te0LHXmZ0Cxu2yXNfhwlHn
 FmUECORViZRAAv7MIdzdE6haDJEeYBdjg+6hXdwoXfof86L8X6cndAe98MckF2lDhK
 NRLkWzZxnUyVWljwfekPANRvOBRPgaZM6UC5V6HGTSTX0klK0ClKBdJi3RufWFeLdn
 3zoi08Y6XtvJQ==
Date: Mon, 11 Oct 2021 12:08:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH v4 00/16] ASoC: Add Audio Graph Card2 support
Message-ID: <YWQbNH1k4vVpe6Jq@sirena.org.uk>
References: <87a6jn56x0.wl-kuninori.morimoto.gx@renesas.com>
 <87ee8sm7ke.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vhqnq2aASXYS/kLq"
Content-Disposition: inline
In-Reply-To: <87ee8sm7ke.wl-kuninori.morimoto.gx@renesas.com>
X-Cookie: Your ignorance cramps my conversation.
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


--vhqnq2aASXYS/kLq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 11, 2021 at 02:52:49PM +0900, Kuninori Morimoto wrote:

> I will wait your review if you have something, then merge fixup into v5.
> Please let me know if no review/comment, I will post v5 soon.

I don't really have anything - I was actually just leaving it a little
bit in case anyone else had any comments.  Please just go ahead and
post.

--vhqnq2aASXYS/kLq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFkGzMACgkQJNaLcl1U
h9Acagf/VOCgH/OjT1l/BWh1EHg2D8JZzVCDNdiuYSQL0eckOV8Ki+Z/dBeAtQ4f
mTscw2t9IbqR8n1bJI1Ef7z8gdlrxK2PswwbjNyKj7qrwL46RM0wkncQ0nIzSoKy
iWgQB0u8X8OqeFkSR9rrtMjBctomsHtcXwa8bV4T1WwxmS0tHOTsO5I8kUL47gs9
GVEnCFBELiSEiXeemyplez5fpCts/F9WSi541rKrDjSLhvaL/KsffDVADrQ0IQ/h
ePCOq0gDkahwV+OuOcKjhl+iZoJjifCGQDWLk8i8gbXE43xup8IjMMmFcO4XsqEp
PkxMkw5scgC1rQAmRukBbl0AYz6qtg==
=+K0g
-----END PGP SIGNATURE-----

--vhqnq2aASXYS/kLq--
