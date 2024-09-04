Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3D8CD4857
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Sep 2024 17:27:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F1296E0D;
	Wed,  4 Sep 2024 19:27:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F1296E0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1725470876;
	bh=0oB+h2PhvzTSs4fr1OfLknaixVNmBNFPA/pyFAhoqQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pyxnhF04lY6wtRifzDmfvDDMWkYRdwLqF02eY/4IpzqpCn7qUQD2H9zHhMq5uDXJr
	 JxgcUn47O0qesClOTsWdYXTUYJ5c2BDcAwxbn7uqXJOlSYCxnlQEDrEfKB0857vDYg
	 i6ijD7fPx6q1oOVZq+qlBkzqoEGBAShAMceX4HKY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0EC7EF805BF; Wed,  4 Sep 2024 19:27:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9CA5AF805B1;
	Wed,  4 Sep 2024 19:27:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9559AF8016C; Wed,  4 Sep 2024 19:27:20 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 553E6F80027
	for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2024 19:27:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 553E6F80027
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=jn0N2Gr6
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 616155C53AA;
	Wed,  4 Sep 2024 17:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D865C4CEC2;
	Wed,  4 Sep 2024 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725470835;
	bh=0oB+h2PhvzTSs4fr1OfLknaixVNmBNFPA/pyFAhoqQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jn0N2Gr6B2dzGEyrfKLldvYgYNsuotQy90NgjEKdtkadrXqOPntThkDe3kqxdkbwU
	 3pxa43PpV8zmEcJNrb2QB79/QaVQpW9iGQ8dP7QW4aAEr+Bi3HiS1SYpio/A5mFglj
	 D46GKnwSnyyCu9tTJMMqaqxdOA7dPPOy19nDyN8Siit8MKeJ9TOov6qRjKDwS56fw0
	 wgCDNOCGZ1c+8axxdmShT0IGgJbKvr7vXIloqwh+qQs8ZtXwgm5Dhj9KRQ0x6NBj8Q
	 n23dVIQDM5ze8ta7FlhjX+pUNgJ+Pxke5wt7hSxUl27HiCu6aGc2jm96GxxSN4ypPv
	 04Mzx279aVFnA==
Date: Wed, 4 Sep 2024 18:27:10 +0100
From: Mark Brown <broonie@kernel.org>
To: Simon Trimmer <simont@opensource.cirrus.com>
Cc: tiwai@suse.com, linux-sound@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH] ASoC/HDA cs35l56: Remove redundant IRQ handling
Message-ID: <6eb95724-9ba3-410f-a42e-e1013c449458@sirena.org.uk>
References: <20240904120700.188644-1-simont@opensource.cirrus.com>
 <e1aeb66c-ecb3-4778-b306-f3a212caf879@sirena.org.uk>
 <004601dafed0$d8ff8cd0$8afea670$@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yS1URVebDMM4Ze5M"
Content-Disposition: inline
In-Reply-To: <004601dafed0$d8ff8cd0$8afea670$@opensource.cirrus.com>
X-Cookie: Linux is obsolete
Message-ID-Hash: EI6DNWRWBFPXA4W34XAZYE4ZOAIUDEDA
X-Message-ID-Hash: EI6DNWRWBFPXA4W34XAZYE4ZOAIUDEDA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EI6DNWRWBFPXA4W34XAZYE4ZOAIUDEDA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--yS1URVebDMM4Ze5M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 04, 2024 at 02:46:30PM +0100, Simon Trimmer wrote:
> On Wed, Sep 04, 2024 at 12:25:00PM +0000, Mark Brown wrote:
> > On Wed, Sep 04, 2024 at 12:07:00PM +0000, Simon Trimmer wrote:

> > > The IRQ handling in the cs35l56 driver was purely informational. It was
> > > not necessary to support the HDA or ASoC driver functionality and added
> > > unnecessary complexity to the drivers.

> > Given that the code is there now and has been since the driver was
> > introduced about 18 months ago what's the ongoing cost of having it?
> > The information it's providing is notification of hardware faults,
> > reporting those does seem useful.

> Originally we were expecting to use the IRQ mechanism for an event logging
> stream that would function in a similar manner to compressed streams to be
> able to get an information feed for debug and tuning tools, but those were
> never created and the logging infrastructure not implemented.

Right.  Though ideally we might actually do something about some of
the errors that are reported.

> It's quite a spread of code and a lot of complexity in the regular execution
> paths managing them / synchronizing the contexts, there is more going on in
> the SoundWire bus variant compared to the conventional i2c/spi that it is
> hard to justify maintaining it all for a couple of log messages - in the
> event that someone did encounter the two situations being reported the
> regmap dump would point us to the cause pretty quickly.

I'm not sure how many end users are going to get as far as talking to
you in the event that they have issues - people often won't get as far
as trying to contact their distros or upstreams.  Even errors in dmesg
are pretty obscure but they're more discoverable than interpreting the
regmap, people would need to identify that they need to look at the chip
first and actually be experiencing the problem when they figure that
out.  Ideally we'd hae better handling for this (I did note that the
latest Iron Devices driver will back off speaker volume during a thermal
warning which isn't a terrible idea, though there's potential issues).

It sounds like the only real concern is the Soundwire stuff (I2C and SPI
interrupt stuff should generally be trivial?) - if that's the case I'd
be more inclined to only pull out the Soundwire bits and leave the
support there for the simpler buses.

--yS1URVebDMM4Ze5M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbYmG0ACgkQJNaLcl1U
h9CWaAf/SZYintLOxVkSO/wJvznvuXO8nkPUG7BDqNaMyap000lphqeP9Q7omZrg
wsmJm/om/i6qef2DCsrJxNKU0DRTMXx9DH1/rUnfPBn2mAjqWCFYLPXBtoBLVHwU
4YZ1IEDV5wYtrz/MPBz4PPTfjYv33IFlxKEzBaw5N2nTnfewjAk6zBws/x+CSrUG
dIR12Vzo7XrcLufw4uexjqTMsS05FKAQT5roUTpXIWnmjqG6hVToKL6pOSijWMeK
eN2rktIo40P3HzcF9WMCbY4Gnn8WY1RoPHCnNn5CI0WlxF2h/Kj0gYB3tbdx0419
JE8FZCb/CtMhGH1ilPHFRkh29lptwQ==
=Kn4O
-----END PGP SIGNATURE-----

--yS1URVebDMM4Ze5M--
