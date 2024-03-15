Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76767C54E58
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Mar 2024 14:10:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89BFF22A5;
	Fri, 15 Mar 2024 15:10:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89BFF22A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710511837;
	bh=txB3VCSUE8GHPntsFBv+qFgsatTpyjpzFZFx1kEapAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=AGuv1Aw6X99oH0OcvF8hvjzgvBkX8T2V3qL5ofgwgVhD8bKpUnN80jbfN1rbzPCew
	 0qA781AKHXkb1y7+aLlbFe2SMaPFUhQZygvbCqD2SR4IyoXnZIDMtEKRdRMC20SisX
	 HT1moHEkr/164MmnoF/dp8MJlUPbtXuhJsi9Ny8U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 98A5DF8025F; Fri, 15 Mar 2024 15:10:06 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C51B6F80563;
	Fri, 15 Mar 2024 15:10:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7C86AF8028D; Fri, 15 Mar 2024 15:10:02 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 83C78F8014B
	for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2024 15:09:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83C78F8014B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rn+/dkIg
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 37631616FF;
	Fri, 15 Mar 2024 14:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A617C43390;
	Fri, 15 Mar 2024 14:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710511795;
	bh=txB3VCSUE8GHPntsFBv+qFgsatTpyjpzFZFx1kEapAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rn+/dkIgs1K6Q0NulNzVY3euoVPQwoIlTLJNZFo7PN0iZR+s5sQWqILQKjSUg9YsV
	 AkKJCEQoldsT0M3kMn5MRKQjPdMGU0pA2DF3eu03GOfZXJfh/rpbZN0JA0YPb+XJJ7
	 GiAFBhPwVYJFsd41zM66DO4mcccVeZsHKAiLCxDe8aVQMpKy6qnnhekGOCrzBkQKOt
	 cCeAcxDEgjc9+zWtM51XftSyrj2CW8txwiF40mfy3IN9fV92oREtdjc12OkquEEATS
	 Qev2aNdhADqylUSdyOLI0LQ9HCQcgA4tTD3xU46tf2rhBdsWDaxUcvheifIh++dk86
	 /GXuKLUdsShTA==
Date: Fri, 15 Mar 2024 14:09:50 +0000
From: Mark Brown <broonie@kernel.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com, christophercordahi@nanometrics.ca
Subject: Re: [PATCH 09/13] ASoC: ti: davinci-i2s: Enable unexpected frame
 pulses detection
Message-ID: <51866f62-460d-4035-bcf1-b9f03cf9be0b@sirena.org.uk>
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-10-bastien.curutchet@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zczSzXQ+ZeeLvl4t"
Content-Disposition: inline
In-Reply-To: <20240315112745.63230-10-bastien.curutchet@bootlin.com>
X-Cookie: A well-known friend is a treasure.
Message-ID-Hash: O7Y3KXNB4BFENGBJUQAB4YA6UPLCFPO7
X-Message-ID-Hash: O7Y3KXNB4BFENGBJUQAB4YA6UPLCFPO7
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O7Y3KXNB4BFENGBJUQAB4YA6UPLCFPO7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--zczSzXQ+ZeeLvl4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 15, 2024 at 12:27:41PM +0100, Bastien Curutchet wrote:

> McBSP can generate an SYNCERR when unexpected frame pulses are
> detected. The driver always disables this feature and ignore the
> unexpected frame pulses.

What does "unexpected" mean?

> Enable the generation of SYNCERR by the McBSP according to the
> 'ti,enable-sync-err' device-tree property.

Why would this be optional, and how is this reported - I'm not seeing
any interrupt handling updates?

--zczSzXQ+ZeeLvl4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX0Vq0ACgkQJNaLcl1U
h9B6ogf9Gt1HwXN03wT222z3x2b/bwF19rqWov52RR4WPVcua6711ND9cDqiIcOW
Oy2GTXmHEQmrDvT+GOcsjbOMpoYBoZi+7MZqRdv9/LYCZbFq/2H4AI2O/qmfF5kO
f68g6bzryQdac8ZmG5edevGy+eDWm/s22EkLSqhBhHDJF+UuEFc+QHgl4UZC1bSG
kxV38qN+cN6V2FzuXSuDdKlFytfkuGNF1ue5g+HADs3yRCjsgNeyJ/wx7MSUKq+s
OW9uP6jkKDP39+SwFYgo8TFQIjZJKw1XteEEZuVQhP5XQNcNtK0Y8kkTsDzIa6Qu
6P+cbhbwS1pcZxG521EwHYdEnIKmnQ==
=Il8y
-----END PGP SIGNATURE-----

--zczSzXQ+ZeeLvl4t--
