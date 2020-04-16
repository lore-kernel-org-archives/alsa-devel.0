Return-Path: <SRS0=OoyA=6A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638A5C2BB85
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 16:13:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E598B206E9
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2020 16:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rYntFFKY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIZX6WdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E598B206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 175C315E4;
	Thu, 16 Apr 2020 18:12:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 175C315E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587053611;
	bh=UBXmzFhBpFgoY6vyEgZDx/G29gEPaaN/4bc/3OJtawE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rYntFFKY2MjSg4YnatzMtMAFsHr6wg6b/t/9Ix2fRxnzCkB8AU8OWbNCr99kEbQ3B
	 8Q0PUZg/Xfn/bpOhExlw+BA1PYadVhzQSNwEyx/RA7Q5N3dVRv554nG6K1bzhJrS/j
	 mp0ut5p1vmefxNbsP0r530PupC3BQZ9Ipe4JXG/8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 94E3CF8013D;
	Thu, 16 Apr 2020 18:12:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C37EF8014E; Thu, 16 Apr 2020 18:12:34 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8BC75F800AB
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2020 18:12:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8BC75F800AB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="VIZX6WdX"
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 29CBC206B9;
 Thu, 16 Apr 2020 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587053548;
 bh=UBXmzFhBpFgoY6vyEgZDx/G29gEPaaN/4bc/3OJtawE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VIZX6WdXWGiQrMeDr2VMTqHBvMeh3c2VpUcozveNJsTJeaH7EW4QSN7gl+a5FZuLB
 6trTiRAk9+2FGitd9VrRmDcoYphRYgEFrXs2+/AZMTrMjueRSQwPhx4k43Rxh1xLQ/
 idLywQ7FmJEwBUTYf+Cb8idVbattvmERHkTFWLwk=
Date: Thu, 16 Apr 2020 17:12:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/7] ASoC: txx9: don't work around too small
 resource_size_t
Message-ID: <20200416161226.GN5354@sirena.org.uk>
References: <20200416150011.820984-1-hch@lst.de>
 <20200416150011.820984-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NJSRbAqOy4NeGDns"
Content-Disposition: inline
In-Reply-To: <20200416150011.820984-2-hch@lst.de>
X-Cookie: Tempt me with a spoon!
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-mips@vger.kernel.org
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


--NJSRbAqOy4NeGDns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 16, 2020 at 05:00:05PM +0200, Christoph Hellwig wrote:
> The txx9 sound driver deends on HAS_TXX9_ACLC, which is only set for
> three tx49xx SOCs, and thus always has a 64-bit phys_addr_t and
> resource_size_t.  Instead of poking into ioremap internals to work
> around a potentially too small resource_size_t just add a BUILD_BUG_ON
> to catch such a case.

Acked-by: Mark Brown <broonie@kernel.org>

or can I just apply this independently of the rest of the series?

--NJSRbAqOy4NeGDns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6Yg+kACgkQJNaLcl1U
h9DEbgf+JwzZc2jhXpAP4FvODQGQv1h0Vc/XAbA4UGDH2HWoKz9NJ+pIUCfuCnOw
DAysKMiHzprQKBvLH5LmrsMjHlzCGa8tzGqf3FjRxRTEcTZwwzlHk/1+e12JctPK
QZsERfcmkEvJcJajNoafnFi9DbHHzJvY2hd32zbrY97sgAXhqy7XhkFgvXKJBXZI
sGrWoQS+vxQeQUzLToCWwNLo8akrKGmBX0oSvOf+9vgeqg3PF5ShpxjOyJs74nOc
32mw8r9AB5A+K7QKVIe3Q4x9irWxv5kxQ7O09gqJ/PQZTeaJZ3XqnJ0uMMs5SadH
gV4+DtvO63MROj2M0JdqnVWDPMjvjw==
=uLa8
-----END PGP SIGNATURE-----

--NJSRbAqOy4NeGDns--
