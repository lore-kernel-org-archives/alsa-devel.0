Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784A6C05027
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Feb 2023 14:04:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 83D38828;
	Wed,  1 Feb 2023 15:03:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 83D38828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675260266;
	bh=2DbOtTQRhr8tnJUsWJlJ8/mz0ACGWFvVrr7Khf67Jw4=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=DXVXccddbDW08hs2IvXPmhIgT/E7DyAVV6WAmtEKAwI+4TSYc6hrjCLt8NjT4TguS
	 drN6rQYrOEMhYuTJS0g0/hfBgZNg2TGG0qFVkxRtSyqqWHEkJjBXlBxXYdcwz7K8EM
	 fMSO/vmme9faDWTiGhBbOd4QJyEzESfBHes27CU4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D58AF8032B;
	Wed,  1 Feb 2023 15:03:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0892AF80423; Wed,  1 Feb 2023 15:03:32 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4066CF80246
 for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2023 15:03:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4066CF80246
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=CFlfGnI1
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 91B01B82189;
 Wed,  1 Feb 2023 14:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D926C433D2;
 Wed,  1 Feb 2023 14:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675260192;
 bh=2DbOtTQRhr8tnJUsWJlJ8/mz0ACGWFvVrr7Khf67Jw4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CFlfGnI1en/ZcXxspRRKujokG0KfusW/3vbZN6nQ1sBWV9M3AJirnOhHNOCa6d1rp
 +Xo7tdZGOphyvxQmtXrdpPoUbYi84vdrNBD2JBXBOCDGEPhGQ0vcO4RCkXlFX4XuAt
 73UZ0jmt88xKYYOPv2DmpcTWsun1xr0mhRMrWoGSYeOvpJtFdRc9deY5bI0GPnzW/M
 3VxHq8piROjRVbKlbqSkMzyYOdE/5mw5BxPoVehnA6IFlCgUVTxjPgSXbVghdeBg/1
 zejP3mtJa6CLBc1EMd7XvQI3tm+2C+GK8kX27LrTj+jl9NhoHwHz+IE3Y6Jpz+q8fP
 vw6GWaKQm24Nw==
Date: Wed, 1 Feb 2023 14:03:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Drop broken irondevice, sma1303 binding
Message-ID: <Y9pxGUMWyMeXQpZM@sirena.org.uk>
References: <20230201131059.65527-1-krzysztof.kozlowski@linaro.org>
 <1bcd61d6-810f-1239-1b6e-367e0fe87370@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XMD2Qw0vG4t+o25k"
Content-Disposition: inline
In-Reply-To: <1bcd61d6-810f-1239-1b6e-367e0fe87370@linaro.org>
X-Cookie: Oh no, not again.
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kiseok Jo <kiseok.jo@irondevice.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--XMD2Qw0vG4t+o25k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 01, 2023 at 02:13:46PM +0100, Krzysztof Kozlowski wrote:
> On 01/02/2023 14:10, Krzysztof Kozlowski wrote:

> > Because the binding:
> > 1. Was never tested,
> > 2. Was never sent to Devicetree maintainers,
> > 3. Is entirely broken and wrong, so it would have to be almost rewritten
> >    from scratch,
> > 4. It does not match the driver, IOW, the binding is fake.

> I understand that in general we tend to fix, not just to revert. But the
> poor quality of this binding and the next patch, which was suppose to
> fix it, plus complete lack of testing, means I do not believe the author
> will send correct binding.

> More over, fixing binding might require dropping incorrect properties,
> thus changing the driver. I am not willing to do that, I doubt that
> anyone has the time for it.

It is an absolutely trivial binding as is, it is utterly
disproportionate to delete both the binding and the driver to fix
whatever it is that the issues you're seeing are (I can't really tell
TBH).  Undocumented properties are a separate thing but again a revert
is obviously disproportionate here, glancing at the driver the code is
all well enough separated and can have default values.  Looking again I
did miss the sysclk selection which should be dropped, clocks should use
the clock bindings.

> It's the job of submitter to work on it.

It's also not the end of the world if we have a driver that isn't
perfect.

Please, try to keep things constructive.

--XMD2Qw0vG4t+o25k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPacRgACgkQJNaLcl1U
h9Clqgf/fBAlVIkG5zw/SgqTKfN1Yg8nM89WTIvkRkH9P4VzP5/4AcY1JGgQ88LS
wLn12hGKAm9M96JTB3HMPfBuTbF/sn2oduUU1GUx7T0sM13LVwPCM59/Kv0EZO1r
60yUzotgLtAMP+bp6qxi5FXG+K9npW+hk7zhtZOu9ia48m3R2k1T2LfO5Ai0Mp4Q
wJrN5nbyHtXf0MzUcVc+do/mf/1p76HP/NvvyteAoLJVg3l7gEECdws7G+/b1VZf
xS+tjYlH9R0a1XJsJm+7rAcjlovdpMLZESIb6vHYxDJ18rdBlTsfDtSfIiWDrwof
4cTRjKLygsYMBrleaja1+7DlW8Satg==
=nfWJ
-----END PGP SIGNATURE-----

--XMD2Qw0vG4t+o25k--
