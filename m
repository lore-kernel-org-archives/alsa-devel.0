Return-Path: <SRS0=z7f8=PA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFFCC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Oct 2021 10:41:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E42E961078
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Oct 2021 10:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E42E961078
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6113D1674;
	Tue, 12 Oct 2021 12:40:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6113D1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634035294;
	bh=8Mo99hNpbVCPntx6qXcJMQQ8Zr6U+b7gnjdoRm7v9wA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HS9VBH7Czt0GaxD6Ueq7j7zAlbqvPis5H4akWm8yHzSYjL1hOF4ILhzNzkQq7SbhQ
	 oS0O3O3JvjcOp7o8K+Xkkd24puZwcn+Vr6fnBX822U11h7Eqdz8KLeCxQ0z2pBio5n
	 sr3Xq6z2UmmMkJqH4Cn+2QldxA+vzfzG7Uy+gVi0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00C87F80088;
	Tue, 12 Oct 2021 12:40:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC418F80212; Tue, 12 Oct 2021 12:40:42 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 437EDF80088
 for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2021 12:40:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 437EDF80088
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="IuY/0Ev7"
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF1A561076;
 Tue, 12 Oct 2021 10:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634035235;
 bh=8Mo99hNpbVCPntx6qXcJMQQ8Zr6U+b7gnjdoRm7v9wA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IuY/0Ev7PWWGp+fKGsfoZGUoYxRammnb3CLy1qKbZ5vWTCmfWRDkQl6yG4b0f6BPc
 M62CbOC8WSvWc2uF+xtTPJ4nyGjziTFUrBHorz+z/exgwe0L0KVM/a4bD/6pe6Mow+
 KzeapNdc4esEnUTr4rb8pe8ybB78ZHGdHTOB2IxETMO9g59Q147K44yyZ2OlE8af+z
 GCOG/C9iMHskpxKn3Wjs3OiCeplGvPfmJMWQL+P5iJFshfPjf1NynFaQwJAHxSzGx1
 vPXNLQN0UQPIS24+9CG6fFz7gQN6nGMtBMi0vnkWgKg/UYFgH/mKnoTYAUAgwcbaxv
 Fxj0/o9aWrzpw==
Date: Tue, 12 Oct 2021 11:40:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v2 6/8] ASoC: cirrus: i2s: Prepare clock before using it
Message-ID: <YWVmIKM99Zp/eVLZ@sirena.org.uk>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-7-nikita.shubin@maquefel.me>
 <20210726165124.GJ4670@sirena.org.uk>
 <e23f7de1dbb02def413d721a3bf5759100380937.camel@gmail.com>
 <7cd9ccc118c1955b5f3b48f6f8a7157a72d5213e.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+Xxb2RUjTwxQcxkX"
Content-Disposition: inline
In-Reply-To: <7cd9ccc118c1955b5f3b48f6f8a7157a72d5213e.camel@gmail.com>
X-Cookie: You buttered your bread, now lie in it.
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, Nikita Shubin <nikita.shubin@maquefel.me>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>
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


--+Xxb2RUjTwxQcxkX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 12, 2021 at 09:25:15AM +0200, Alexander Sverdlin wrote:
> On Mon, 2021-09-13 at 23:43 +0200, Alexander Sverdlin wrote:

> > would you take the patch to a tree of yours, please?

> I still cannot find this patch in any of your trees, but I've found this =
one:

You ignored my question about dependencies:

    https://lore.kernel.org/all/20210914103212.GB4434@sirena.org.uk/

so I've no idea if it's safe to apply or if other people might need this
one patch from the middle of the series.

>       video: ep93xx: Prepare clock before using it
>       dmaengine: ep93xx: Prepare clock before using it
>       ASoC: cirrus: i2s: Prepare clock before using it
>       pwm: ep93xx: Prepare clock before using it
>    =20
>     Nikita Shubin (1):
>       ep93xx: clock: convert in-place to COMMON_CLK
>=20
>=20
> ... which claims to merge both "ASoC: cirrus: i2s: Prepare clock before u=
sing it"
> and "ep93xx: clock: convert in-place to COMMON_CLK", but they are actuall=
y not
> merged.

No, it doesn't - that's the cover letter from your series.

> Could you please consider ASoC patch, while I will resubmit the final clo=
ck conversion?

So please answer my question then: what's the story with dependencies?

--+Xxb2RUjTwxQcxkX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFlZh8ACgkQJNaLcl1U
h9DJkQf/YWStIGUowcgzXW+8LvZgoJQGF/Pz4DneFx9CyXhIuKBospPojXunjUn5
/p7TXRzlC3nr7JKqqu/Yz3uQ0d5JiJ87XsRJe53YUGQbQ5AjnQ2cN6Z3s8MJEhbe
F/cyYUXDCWnt4dTsTDmWEjrO5I37Lu62DWdEtuENbkh9tILWF8nPtBpxcuU7Bois
n5u+A35nICssRSLyI3RYVQJyovkzjHUl06oT8L4wKiAgyJS7VoiJUv1dYP1QbsrG
v1mDYcqerGWuRykGCL6nXzSeso0LFYy5wqEufHzlxP4WwwK0fcq3ISt0mlK7hVCo
Mu7TVhcs9l8yG3imacbH5sL84IDU9Q==
=XWRi
-----END PGP SIGNATURE-----

--+Xxb2RUjTwxQcxkX--
