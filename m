Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25A0C7EE24
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Jun 2023 14:41:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 625AA3E7;
	Tue,  6 Jun 2023 16:40:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 625AA3E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686062499;
	bh=ghbtpfgzEXDZlStE43dHNyo9glR2yfvAKES2S5iqao0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=D0FalArqFX1YTlp/KE1M1w+jdV5lsjqsSE3jGh0uECV5d2dhd9MVZVNicWcDe+g60
	 LuQ8i8w7XZaD5zUBMnt1qr24jCUN+Sm2cuASOsl43/8fYMAPzODQw1mMu0nv6vr6Wq
	 1a2Ju99jZFcDPlfh7L2POwupa0j4C75NlgdoR3bw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7E3ADF80254; Tue,  6 Jun 2023 16:40:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DBC34F80199;
	Tue,  6 Jun 2023 16:40:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E530AF80199; Tue,  6 Jun 2023 16:40:12 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CB22CF800ED
	for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2023 16:40:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB22CF800ED
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=h9bki2II
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 940B162CAC;
	Tue,  6 Jun 2023 14:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749F4C433D2;
	Tue,  6 Jun 2023 14:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686062405;
	bh=ghbtpfgzEXDZlStE43dHNyo9glR2yfvAKES2S5iqao0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h9bki2IIyHiObYwlt0XmTTgUGm8+InDcRMFw+o9s5a89DTT5WIBZFbGXQBjF2yGjr
	 dUfmvE1sb5uGpA9/T+SZji32Q9ia4LFIrIiX1iLyMdVMtLK3tOL/B3DqGzWKI8nEr4
	 ABFEy56A3uRC3y9xb0KUyOBtuxFH+K0ZI+2JL4sptX/J8sqviCqB1xTeR0o/kgDord
	 tA+jZBs1UZgpOjeTEwP44O+9CrEpxUSQ+nVE2bi5+oe9pifrnVJsEeSkAZ5Ef40GJU
	 dB+JysfYjL/5rR+DIUyFi2USlyfiZrvu+i8Ypfk85+3d9EZEWenb2kNvViqPkV5QGB
	 FGuJhiyyW69TQ==
Date: Tue, 6 Jun 2023 15:39:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] ASoC: dt-bindings: document new symmetric-clock-role
 flag
Message-ID: <9ea5a0be-606e-4c65-914f-c249d3f1b513@sirena.org.uk>
References: <20230602090322.1876359-1-alvin@pqrs.dk>
 <20230602090322.1876359-2-alvin@pqrs.dk>
 <3fe93662-82b0-4834-b6c3-473669c66210@sirena.org.uk>
 <7csvw25vhyal2jsznb3jykuijxqpk7bzyguxvl7cyitosgga2w@pxmkce22cm3d>
 <91b6d02a-25d5-4835-942e-3f8072bd8897@sirena.org.uk>
 <aesymtpx5bkfkvlbt2d6o3gn4zjzsbyiwxiuqziohgovy7oaoo@kt2n6v7kmuw7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GvMNWsvRI2cx5zFa"
Content-Disposition: inline
In-Reply-To: <aesymtpx5bkfkvlbt2d6o3gn4zjzsbyiwxiuqziohgovy7oaoo@kt2n6v7kmuw7>
X-Cookie: Keep out of the sunlight.
Message-ID-Hash: UQQZDUMY3FT4EA3S4TRC77BADQF3J2V2
X-Message-ID-Hash: UQQZDUMY3FT4EA3S4TRC77BADQF3J2V2
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UQQZDUMY3FT4EA3S4TRC77BADQF3J2V2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--GvMNWsvRI2cx5zFa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2023 at 12:42:49PM +0000, Alvin =C5=A0ipraga wrote:

> Yes I see what you mean. On my platform the clock source is actually desc=
ribed
> by the common clock framework, so I would want to use that. If it were a
> component driver then it would most likely be a codec that is part of the
> dai-link anyway. So what about having two struct clk pointers in struct
> snd_soc_dai?
>=20
>     struct snd_soc_dai {
>         /* ... */
>         struct clk *bitclock_provider;
>         struct clk *frameclock_provider;
>         /* ... */
>     };

> If non-NULL I could then have the ASoC core enable/disable the clocks on =
demand?
> I would say in hw_params/hw_free, albeit that runs after set_fmt.

hw_params() can be called repeatedly so that's not a good fit but
broadly yes.

> Having said that, I see ASoC doesn't really use the CCF much... am I way =
off?

Ideally we'd be representing more of the clocking via the clock
framework but at present yes.

> I don't think it's feasible to modify every component driver to explicitly
> handle this and then ignore any CBP_CFP bits set in its call to set_fmt -=
 this
> is why I want help from the ASoC core.

Sure, but that's not going to impact the DT bindings.  All these things
are driven from the machine driver.

> > If simple-card can't be made to work that's fine, it's deprecated
> > anyway.

> Ah OK, I didn't know that. Right now I'm using graph-card2, that's not
> deprecated, right?

Yes, audio-graph-card replaces simple-card.

--GvMNWsvRI2cx5zFa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR/RT4ACgkQJNaLcl1U
h9AOGAf9EegtL3c4zrX74J8pQRZd4hNb4Sdz7YOKInPb59JgB7ox9bswVlvLt+d4
BrkL3O10PUppYenoCq91zVnJV7QCXrJNwmt2PxxoAEm2QODPTgDGYF7qqIYVFqqZ
DFeRW8iIXBl5H5pzm3ubN1JnnUBTBoN1HklWggVlPm6QDVMJlPa5DtmGtgXfICin
bF7AZl/jmdRkl419mnCVn8IqnbxtxBkMdOfll8Mhl5m37708v/GBSJuu9NuMucYT
qqPl8DAzGmFux4oQWugYZJo8xsjaHNOLbb+i3Lv1tXeW24BrM/G/o2tzXNs5NGl5
RecfVJxwWf7elqqloUovb6ii2Be/HA==
=EUDa
-----END PGP SIGNATURE-----

--GvMNWsvRI2cx5zFa--
