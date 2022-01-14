Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB54C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Jan 2022 12:12:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 653041B5D;
	Fri, 14 Jan 2022 13:11:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 653041B5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642162366;
	bh=xWVNg8jYF+xmMkDX8x7QzixVZI1jpIDE8FBOyg3doJk=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kmER5Fvuz+V24T/NjlpksmnkpXKYWG/mnLhJXKdOTeZiMzMBTJwLYI9e/ITYUcOXZ
	 fV6QHHEZv2kWZzaENb8lyEp1zwj36Y9v2ZqxvX8bN7mldzI+8bp1dxLEXTtitlhfmx
	 7wzZcLm5FYCUZg6vNIvxljfwVu22bO77gZ2foa4Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED85AF8027C;
	Fri, 14 Jan 2022 13:11:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03379F8030F; Fri, 14 Jan 2022 13:11:54 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD22AF80141
 for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2022 13:11:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD22AF80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="sUR+ztBT"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6ED4261F3C;
 Fri, 14 Jan 2022 12:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C46C36AEA;
 Fri, 14 Jan 2022 12:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642162307;
 bh=xWVNg8jYF+xmMkDX8x7QzixVZI1jpIDE8FBOyg3doJk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sUR+ztBTAE69/p/bB2/5zzJr8kmdF93CJ+S0fKeuD8rRyGONFmGjN/5CeMYevXhc9
 XR0LIXw3vb0G+2HLyk2j6+nxs+NOx75Oq/XrUn9U/3WryYJja6wrefOE/6em+5V/HU
 r1SICpAwxWdmVwXcOOAkZ/GcGncS4QaGjXtmDTzHSAEp7Yckxn/tdvHtMFNyx21NU7
 Vyoc9rnzBQSVxmC9oLvjdy3qjPybah3ZWQD9TwQ08qchzP9GT7Gxjd7vmkLIM29+oK
 UyfS0i1iZLY6D9FsM6pSjoz2sKiPuASdLJXf1j4qMZqG02ZhODpOKbc5kjpJaKQG0t
 CJCuuDvyrIALw==
Date: Fri, 14 Jan 2022 12:11:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Daniel Beer <daniel.beer@igorinstitute.com>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: add bindings for TI TAS5805M.
Message-ID: <YeFoftcUwRvyShvB@sirena.org.uk>
References: <61dccc5c.1c69fb81.9af91.0df6@mx.google.com>
 <Yd29tk6ZJgDFDvVI@sirena.org.uk>
 <20220111184700.GA10070@nyquist.nev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hIzfZ7Gg0S+Hgd8w"
Content-Disposition: inline
In-Reply-To: <20220111184700.GA10070@nyquist.nev>
X-Cookie: Two percent of zero is almost nothing.
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Andy Liu <andy-liu@ti.com>, Rob Herring <robh+dt@kernel.org>,
 Derek Simkowiak <derek.simkowiak@igorinstitute.com>
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


--hIzfZ7Gg0S+Hgd8w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 12, 2022 at 07:47:00AM +1300, Daniel Beer wrote:

> If you think it's still inappropriate to supply the configuration in the
> device-tree, do you have any suggestions?

As I said load it like other coefficient data - the simplest thing
initially would be loading it as firmware.

--hIzfZ7Gg0S+Hgd8w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHhaH0ACgkQJNaLcl1U
h9Aczwf/VbbhZslWnff3lIqK3COnyjw9mmcFxD7wuNGaKP3GiLu3ziqqAjwiyn9U
hWSbhglTJul037W/Fg+irWXaMNAUPsv2lcMecyAbfuphY2M2IUIy6nDmkmio+Rm6
qp4sUe2MhwJiHh2xEI2VMFTxWJHBKi4y1Xhh+S06GXdmrGnE7mCjFMO9kRUOQSwm
sHY8n5RHhr/1ZW/j07BwsHcLMWwBqMCMUsMyRGE7WVGmrIIJ6MT05eV24hTvtOLR
K4g6i+RfMKp6DWG9c/yhEWmt3wILRR7DWkhnVW75bn9IZ7NragWBVLyRQdg+gr8e
CJNwhRSrUrQrm8+EUrYpeVSxjY8SxQ==
=Zh1A
-----END PGP SIGNATURE-----

--hIzfZ7Gg0S+Hgd8w--
