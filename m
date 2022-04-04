Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC90C433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Apr 2022 12:29:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2730C1693;
	Mon,  4 Apr 2022 14:28:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2730C1693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649075374;
	bh=xs4c6MXzpV8ng4CjtZYCgJS2RsuPKpKdPUzYO+hnHgE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bco2xUKqATk1cSh7Cd5kDE65meka7P9AlGsqQ18f02neJyq1ihszvMODsAuYiS9KK
	 rDdgQl4lOp1q2FiUhCBauj/G3rV5s8dCGdOYFfhTYIG5JLEh93Qz3AY8+EnhZen0wZ
	 ZOtFl4wqARKpRvaF5cpKOU9mmZQ0prAC6NNqnedk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B15E0F80100;
	Mon,  4 Apr 2022 14:28:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 178E9F80162; Mon,  4 Apr 2022 14:28:40 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16D39F80100
 for <alsa-devel@alsa-project.org>; Mon,  4 Apr 2022 14:28:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16D39F80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="T7GBgI2G"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8EBA0B8165D;
 Mon,  4 Apr 2022 12:28:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93E8C2BBE4;
 Mon,  4 Apr 2022 12:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649075314;
 bh=xs4c6MXzpV8ng4CjtZYCgJS2RsuPKpKdPUzYO+hnHgE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=T7GBgI2GTxELAK0/ohe2a9WUz5f54xUcos+VlcjM4byBQtlHumr57JKG4pYLFXlFj
 /pmwE/Ln1e5SZNaS75jo3WCh9JJQCxn2TBxUMdzXWZeYvcTaMPyRo/zl7Lz2Lmpuut
 Ibck0ncRDCkwQvi91v8hNZAexCpRD/gu5y4fC8OQR9koOvZTIzK+em0qFgO32tMylI
 JzUuqLZoyO9Oza2r5JQOOvUc2+bB9gZ1ZCgBEc8D7mj7xur9iu0eleS0p5glEEKHO/
 M+kMMzFKaAWePT6DtzsgqM1PC0zE+Af9AEd5/U3OqjWZcNhth1oWC8/h1GFtHcktEH
 ScotCNfry7Xag==
Date: Mon, 4 Apr 2022 13:28:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: Re: [RFC PATCH 3/5] HACK: ASoC: Tolerate N-cpus-to-M-codecs links
Message-ID: <YkrkbBNYULLgeS5w@sirena.org.uk>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-4-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f/2nG60b2Y2bNyVh"
Content-Disposition: inline
In-Reply-To: <20220331000449.41062-4-povik+lin@cutebit.org>
X-Cookie: Did I say I was a sardine?  Or a bus???
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org,
 Hector Martin <marcan@marcan.st>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Kettenis <kettenis@openbsd.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
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


--f/2nG60b2Y2bNyVh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 31, 2022 at 02:04:47AM +0200, Martin Povi=C5=A1er wrote:

> +#if 0
>  				dev_err(rtd->card->dev,
>  					"N cpus to M codecs link is not supported yet\n");
>  				return -EINVAL;
> +#endif
> +				cpu_dai =3D asoc_rtd_to_cpu(rtd, 0);

We need to figure out an interface for describing which CODEC/CPU
combinations are connected to each other.  I'm not seeing a great way to
do that right now, probably some side data table is going to be needed,
or perhaps the CPU DAI drivers can be persuaded to only have one DAI
actually register and claim to support more channels?  I'm not sure how
a configuraiton like this is going to work at userspace level if the
multiple CPU DAIs end up being visible...

--f/2nG60b2Y2bNyVh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJK5GsACgkQJNaLcl1U
h9Dh0gf/Q1fqGCEc/wB1XRysOW+Zr5es3K9uEZqWeoFmgY3PJHzaoQyoY8BDO6Ve
RDsWRNXnUAuatmcX1NOrm141Q5vVthZt2Y3q60kJOAtBjRg1eLsw0uILEy5Q7cb1
lj7GMjVex4PXcDIJHOb52ZeUhEx1HCpwPCW3Gtx7yU2vmpmpM/vPnugND7wgXoL0
nuD3L00ieLVGfeaBi5ZBYBBvMqO6a8Vc8D4q2zgV+1NVnexzLy8nSWqZCmyKa5SF
bf1jHHMuHJUNF6xeTjSLqzeoRH4q0TEzMMJhF4K4ACM693Dy1HBOXRPKNU33u6/8
7REwlCduNI1JEBSwNjzHv4gMWLxfNQ==
=QGn3
-----END PGP SIGNATURE-----

--f/2nG60b2Y2bNyVh--
