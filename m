Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B317C47258
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Jan 2024 13:07:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A484857;
	Tue, 23 Jan 2024 14:07:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A484857
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1706015267;
	bh=K7kvBmJeqF04W+pnqptclIFdMZFoZ8/xaXv5/7yq+fM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=P0fZfK8SaA0rxQzUA0qgA8VqDGhtwonpPvWuKef+oirPErSaG+Grjsflw84Ys3Xtm
	 3dRQ6oBH5VcglHGTYXsg0amKh254n6+skJc3oXp+mepjiXcW5YlRGAwmHs1b0aEe+T
	 PoKbzfuazOvlvuEst7tuIzTHXKBdk/7kMeIcg44I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 49EAEF8056F; Tue, 23 Jan 2024 14:07:13 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C5BFBF8055C;
	Tue, 23 Jan 2024 14:07:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 70277F802E8; Tue, 23 Jan 2024 14:07:09 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 71F50F800C1
	for <alsa-devel@alsa-project.org>; Tue, 23 Jan 2024 14:06:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71F50F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=hZdjJEUc
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9468861DBF;
	Tue, 23 Jan 2024 13:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B05C433F1;
	Tue, 23 Jan 2024 13:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706015211;
	bh=K7kvBmJeqF04W+pnqptclIFdMZFoZ8/xaXv5/7yq+fM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZdjJEUcxItY39hyskeZ1+Qqa/LKxZY8GzUZsJxDYd5jhDQOfDo7brPjstF6JgRjJ
	 AGoG3Y+acaaBe72R9CC+4xnSPcl+knTEoqw7a736iAl86UzkqXp8T7N0FO8v4VdA5y
	 aUhr/v7/mBNZfULQb0EWmaFjT6jf3s6CR1lt7MFz6BQFu2H0sA0rl471J336NJgo1B
	 XtATZfktBdJ9uT/tos66H299y/ihBOFJPmlQUMtn1l5P/TZtV5NA3yq2Qyc4jMmkFw
	 +KpOIgFNrZulgANWG4b/Sc980/CwIJ9WTW/2BgZ2HPnUCJH7Tt4kZsxwLFc5cl+P4K
	 ws+8sDuzkfEUg==
Date: Tue, 23 Jan 2024 13:06:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Seven Lee <wtli@nuvoton.com>, lgirdwood@gmail.com,
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh+dt@kernel.org,
	conor+dt@kernel.org, YHCHuang@nuvoton.com, KCHSU0@nuvoton.com,
	CTLIN0@nuvoton.com, SJLIN0@nuvoton.com, scott6986@gmail.com,
	supercraig0719@gmail.com, dardar923@gmail.com
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Added schema for "nuvoton,nau8325"
Message-ID: <185f3912-5a92-4ef2-aac4-0df8363d8727@sirena.org.uk>
References: <20240122095650.60523-1-wtli@nuvoton.com>
 <20240122-daunting-woof-19fac5689bb2@spud>
 <04945799-eded-42f9-b8fa-8907be44c400@sirena.org.uk>
 <20240123-bottle-elevating-9fbba5424014@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o44Jj4pPrxHSXHhI"
Content-Disposition: inline
In-Reply-To: <20240123-bottle-elevating-9fbba5424014@spud>
X-Cookie: Stay together, drag each other down.
Message-ID-Hash: KXFNKL2HMDFSPNCZKKZQ27GPYZ6QLTEK
X-Message-ID-Hash: KXFNKL2HMDFSPNCZKKZQ27GPYZ6QLTEK
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KXFNKL2HMDFSPNCZKKZQ27GPYZ6QLTEK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--o44Jj4pPrxHSXHhI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 23, 2024 at 08:34:03AM +0000, Conor Dooley wrote:
> On Mon, Jan 22, 2024 at 07:40:51PM +0000, Mark Brown wrote:
> > On Mon, Jan 22, 2024 at 06:00:14PM +0000, Conor Dooley wrote:
> > > On Mon, Jan 22, 2024 at 05:56:49PM +0800, Seven Lee wrote:

> > > > +    enum:
> > > > +      - 0 # VDDA
> > > > +      - 1 # VDDA*1.5/1.8V
> > > > +      - 2 # VDDA*1.6/1.8V
> > > > +      - 3 # VDDA*1.7/1.8V

> > > I would also rather than this enum was used to have sensible values for
> > > the enum itself (which I suppose means strings here), rather than the
> > > register values. Seeing "nuvoton,dac-vref = <2>" in a devicetree is not
> > > very meaningful IMO.

> > Do you have a concrete suggestion for how to more clearly write these
> > directly?

> I would use what's been given as the explanation comments for each of
> the current enum values in the patch.

Given that none of *, / nor . are usable in defines that's going to need
a bit of massaging...

--o44Jj4pPrxHSXHhI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWvueQACgkQJNaLcl1U
h9AZZQf/ao209hI/MDFLL8V01uYpIbpZZJHJhmCnoIqQZI9Zf1saVE9CfUT01pBI
HeitK8MA1WM/3YMh0JT57EQ2XMFSYCHmv8clDtVnqqVun+zD5xXS6PFHIzzqlWJZ
uZwcjyxs1vssOWrJUOeHyZHSoV6QIuEY5HfOSFo98n3QG40P88AoCFNafMKgbk3I
8uoAB5TIpDVbLMF+c/ETEi5zxzcYjEQ4B2s7rCxEFPuvQu32ErAsYW3PCpRbzun9
adZUG89VeomjC/gs1Vp+0nqm5jFC3fJfTXrHFrK+ty5HgGUUGPxlUgolFxljV69a
d4bjft12qN7vACIxCZYBBPRYmq1MXA==
=Vsnr
-----END PGP SIGNATURE-----

--o44Jj4pPrxHSXHhI--
