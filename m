Return-Path: <SRS0=n5aI=CK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4718DC433E6
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:05:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFAB5207BC
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2020 11:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TcwWRorI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDd3LEdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFAB5207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EED9417AF;
	Tue,  1 Sep 2020 13:04:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EED9417AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598958336;
	bh=sCpI4sCnV3VGw7tpt2uhRXxYsas+I7NB/Odw+Dl23IY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TcwWRorIGweaS6x7War8ZlDCEuOzuR19YetI1xheh1UYgcoyAKX5WRFhEMuBf0x+L
	 qhiX+E5MPSx4m+PmleIHREwT9w6WysNaGVhMtGG7fQHSMgj8KQPZKfwo+ykeBhG7nW
	 CxKmrO4JtQOdf0BiaLSiVca9OD4my7TE4YGcjozE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 529B1F8020D;
	Tue,  1 Sep 2020 13:04:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D9A0F8020D; Tue,  1 Sep 2020 13:04:37 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C714BF801EB
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2020 13:04:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C714BF801EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="FDd3LEdd"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B6A09206EF;
 Tue,  1 Sep 2020 11:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598958269;
 bh=sCpI4sCnV3VGw7tpt2uhRXxYsas+I7NB/Odw+Dl23IY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FDd3LEddcQgT0dEr51HuI/Fty7nNad3vVXzB/Minh19fwULeTvHYJBVc55s4eLpbi
 Ezharmx8LU+LlA4FUvouooc2+VAvv/clRrm1h0zLWfMr02QvnX/a0TPzJTnB2FUQJz
 OGJ6uDai7gdiYK0TaEVL7t8ylfh+2c7WS7AXdI2g=
Date: Tue, 1 Sep 2020 12:03:49 +0100
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: sound: midas-audio: Correct parsing
 sound-dai phandles
Message-ID: <20200901110349.GC6262@sirena.org.uk>
References: <20200830112633.6732-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
In-Reply-To: <20200830112633.6732-1-krzk@kernel.org>
X-Cookie: Equal bytes for women.
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
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


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 30, 2020 at 01:26:32PM +0200, Krzysztof Kozlowski wrote:
> The "sound-dai" property has cells therefore phandle-array should be
> used, even if it is just one phandle.  This fixes dtbs_check warnings
> like:

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9OKpQACgkQJNaLcl1U
h9DsLwgAhvsY22laZUsm46wBuYEqas5QBnB4KMgxezBwkPaRr5NrJsVQMp2S9QI1
gZzZ5eFVZZYB6Ij8hFNZKlgGp5W+D1negXAJ8WhH8zFXsgg1F+SZmFFD9/6reT5M
1gab7+yPGHs6FLLJ1VbQnyv0xEcV6RnNgTKC3KuUH4Y2LHSDj6qzwYMZWl29Xu8t
p9VZtWTg5g/upxDxbsW8vLVddkjb6KcdhbVsZQ+qb0QxibK8nX+8XbTWyH6T3OeS
4FtJYdEsaHXhkrSDJtf1XpnXVG9RfBgNReqwmHTxdP2PSLDpFR7sCB6FLtNrJfAI
fpab8x1a5104UrbblCQD6ny1IGwvQg==
=Emty
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
