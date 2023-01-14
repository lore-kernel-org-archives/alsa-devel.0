Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C70C46467
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Jan 2023 17:26:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F126BA4A4;
	Sat, 14 Jan 2023 18:25:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F126BA4A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673717203;
	bh=51ViAOYwT+L18PsoAipKMhxe8CCSN6yffy7zR6YFLdI=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=nGZdtQQZK+Oyt3uwZdjWTm0djHCGHYPlNUQeESKmEVNd1xKZzXIjd6igBgu+yRUj7
	 ScEj3B+bxOU6Jv6zM/h3lI/YjpqQVD8+R3bC/iZ0ehgBdpE5L0ju5SwhIC374UlKWD
	 CLAUkbJIWU7uPzonUOwsq2nVoDixBmhrSH4vjKq8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ADFE0F804BD;
	Sat, 14 Jan 2023 18:25:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A16C1F804C1; Sat, 14 Jan 2023 18:25:51 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 532A4F8026D
 for <alsa-devel@alsa-project.org>; Sat, 14 Jan 2023 18:25:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 532A4F8026D
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Z94GKYZZ
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0C72A60BE9;
 Sat, 14 Jan 2023 17:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9958C433D2;
 Sat, 14 Jan 2023 17:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673717142;
 bh=51ViAOYwT+L18PsoAipKMhxe8CCSN6yffy7zR6YFLdI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Z94GKYZZWFNbKNROFJv54fKg5nMm4P0X2aQga1SmffqBJEBxJTDrM2s2BlXcuquWh
 N5Zc40MvepK5NQ15bYUb3YIMn+TyjTj2sOg/Tg45+1ZR4NjVsWzRpHNOu27zIg22n7
 8MKhUOjwZMxnru7P8PE3buFtMY2lQVxYx0WI+jslfjxCx342/icq5RqGuvbJw4vhe4
 wVy6hywOAyo8gnIo6YJ61OwId/WWlMPlYCvgeVkiFmMBPZg7fdw9Nq+Dgp8fNeJWef
 p1dKQS1Hz2obK1Alf8POl6dwk6q7N8aBLkY2RI+UWUBWQLuYytVfzN/vUMK+WQbP6s
 ESVfigIGzqAFA==
Date: Sat, 14 Jan 2023 17:25:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Jarrah Gosbell <kernel@undef.tools>
Subject: Re: [PATCH] ASoC: codec: rt5640: Resolve failure to set DMIC clock
 after playback
Message-ID: <Y8LlnIbvnLGERCNo@sirena.org.uk>
References: <20230114003053.401274-1-kernel@undef.tools>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1RYbj7oVxAjXTigi"
Content-Disposition: inline
In-Reply-To: <20230114003053.401274-1-kernel@undef.tools>
X-Cookie: TANSTAAFL
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 phone-devel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Ondrej Jirman <megi@xff.cz>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--1RYbj7oVxAjXTigi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 14, 2023 at 12:30:54AM +0000, Jarrah Gosbell wrote:

> rt5640_set_dai_sysclk is called with freq == 0 when playback stops. This
> causes DMIC setup code to fail. I2S interface doesn't need to be active
> for codec to work, so don't clear rt5640->sysclk after
> rt5640_set_dai_sysclk is called with freq == 0.

The goal with set_sysclk() is to record the current clock
frequency, if the clock is stopped it should be set to zero.  If
a machine driver is setting the input clock to zero when it's
still being provided then it should be fixed.  If the device
doesn't need a clock for DMIC (which seems dubious) then whatever
is checking for a clock should be fixed.

--1RYbj7oVxAjXTigi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPC5ZsACgkQJNaLcl1U
h9AQHgf/XaEEjF+BLM6Pnh3lYFsdSIlU+KtG76/OC9GzqxX1yVhlp5T1weE8tfSM
nyVWqN20RA2TvVL9npXjB7xlRcsCONSUHg4h9SCDk08p5HT1bL9NtdgtqgMxwDPe
3Q70V5aD8vrF7QtdNLQe7wX/ub/yY7E6F3Nu3mlvdyzFjxekCnp5BcdCNMxQYlP2
cJdDWsO2vdc1tZrN4oFHWrtxoGEi5frIJLPkttaflVt4JV7g/07KpAP3qJ5KCQyY
xItHWBAkhrbaLarnjJMfo9oKlu1U69QR3OFClWpmDYhzReAmtqby9phny8VWOpxT
m1YFxkULKef8d8F4IZDrS72uQ57q9g==
=tHmS
-----END PGP SIGNATURE-----

--1RYbj7oVxAjXTigi--
