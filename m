Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5384BC433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Apr 2022 12:23:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CAABF1E2;
	Fri, 22 Apr 2022 14:22:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CAABF1E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650630222;
	bh=iCGB4TF5qBLZDg/1yVeV2QNlYwKFEsbtcYSzZa2hO3E=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WuX/nT8RsQnne7/aV8JCDdntu7WKIYiFqSAeDeFD4YhPPH1qoYePfrEJR9f/fD7n/
	 Q2G2FFZdLXGGHeuBtx44MLuHUgzHwwfCX/Rs5LPyORAspH2rf9TVz3qLpJFDi5cnTx
	 bhUgMSn9BGA8+QHeOJkGsEjgUjRr3+RYq0+FBJgA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4CA8AF80154;
	Fri, 22 Apr 2022 14:22:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 00423F80245; Fri, 22 Apr 2022 14:22:50 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B9B4F80134
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2022 14:22:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B9B4F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Ok+krcNU"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3543BB82BB6;
 Fri, 22 Apr 2022 12:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AB0C385A0;
 Fri, 22 Apr 2022 12:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650630166;
 bh=iCGB4TF5qBLZDg/1yVeV2QNlYwKFEsbtcYSzZa2hO3E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ok+krcNUAAxIjJsBFpLfy4IXMdkanB+c8oHqQ5WTmn4wD01hVAbib0mJM3lpAImFr
 Dmcm0f54ODUCWaO06evAVQ0qyntH8QiZi18I+D7t74277t6ydRMZsLDwL/u1AuXe15
 PO1xu4f5+khZoq4n0rIKe5Rdk17FzM7YWeIdf7NTYsNadYHHsJPrHVlJGy/EYIKVx/
 wGv1Glq4N6AQz+HljAtETxyNir+SCAdaywelSlFMojCEDyohfwTpA0ZoWWLtllejCy
 Jm2agrPXEm8tft7w/y4hHtyXSZzK/95sRu42/+mmD2bsVvPKL0Zr7gfCzizVG213P6
 QcWvxydQB54BA==
Date: Fri, 22 Apr 2022 13:22:40 +0100
From: Mark Brown <broonie@kernel.org>
To: Martin =?utf-8?Q?Povi=C5=A1er?= <povik@cutebit.org>
Subject: Re: [RFC PATCH 0/5] Apple Macs machine-level ASoC driver
Message-ID: <YmKeEKa0w2xLM9cL@sirena.org.uk>
References: <YkWfziQzprEsWL72@sirena.org.uk>
 <CCE4A06E-6D6F-457D-B3C5-C36209BF38D3@cutebit.org>
 <YkW4MPh8VWc8eSGg@sirena.org.uk>
 <6D199EAB-FE14-4030-96A7-2E0E89D25FAB@cutebit.org>
 <YkXKmxJ0R3qpUoH4@sirena.org.uk>
 <DB0255C3-C9EC-4EFA-A377-C4BB1073D9B3@cutebit.org>
 <YmKPQ6kLCPz+2XTJ@sirena.org.uk>
 <B68302F2-3D77-4065-8A16-A9CC690AE10B@cutebit.org>
 <YmKSgHrbb/7koM36@sirena.org.uk>
 <A1574F30-62D2-467D-A40B-8FD7C6B8BCFA@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KPJ5+qW8JIi0iDUi"
Content-Disposition: inline
In-Reply-To: <A1574F30-62D2-467D-A40B-8FD7C6B8BCFA@cutebit.org>
X-Cookie: Whoever dies with the most toys wins.
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org,
 Hector Martin <marcan@marcan.st>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
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


--KPJ5+qW8JIi0iDUi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2022 at 01:44:06PM +0200, Martin Povi=C5=A1er wrote:

> > So previously each speaker would get two slots but now it just gets one?

> No the other way around. Previously (with the driver as it is RFCed),
> each speaker gets a single slot, and 'Left', 'Right' and =E2=80=98LeftRig=
ht'
> values of the routing control don't do anything different from each
> other (well except maybe 'LeftRight' lessens the volume due to how
> the chip handles the edge case of mixing down two channels from the
> same slot).

> With the new arrangement I am proposing, the two speakers in a left-right
> pair get both the same two slots, meaning they get to choose one of the
> two slots based on the 'Left' 'Right' value of their routing control.

Ah, I think the confusion here is that I'm using slot and channel
interchangably whereas you're saying that previously the driver would
allocate two channels to each speaker with duplicate data?

--KPJ5+qW8JIi0iDUi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJing8ACgkQJNaLcl1U
h9C1pQf+K5jkDiccmgDspVoLOWNStF3GXYYVGVeGCeNBLrBlVHruIotK+Oes//0M
d3xPOdmw2MlkOFWqxkxCtXP/vdtNGN0KRW7S/wi5eiXi+nu9RPAs9JuwchD/kFtT
WA82ks3wiTyh84U6jSBtYeZL0z9sSJQtQBzP3GDH+Sr83wkmVPOdosQlcGsVHLIs
XeZc1fxDkfJI5xfDdO4r+8aX/CzRx0/om2kUOzqmHFascH3EPBrNXklZSu3GVINB
l9K41beGVew4X1hujYBp+ibm3Y8Cn9KGT5ftwtJQYlgfIf0YzKyQ57leN//faEmq
PdLUKYKMpYE6QynL5hi4tG0Fg/9cGg==
=EDd9
-----END PGP SIGNATURE-----

--KPJ5+qW8JIi0iDUi--
