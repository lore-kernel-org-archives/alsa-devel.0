Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48946C004D4
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Jan 2023 16:57:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 18277AE9;
	Thu, 19 Jan 2023 17:56:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 18277AE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674147441;
	bh=vYB/POmz1JN7+fktKqVImJWhIUL+Tb69KLQ6YaDjnPo=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=SySUo0r8TKHFZotEuVQCnoMft+rw8CBap9HEj5zSaDLxhA7kVxPxoJ4PAoSGoJfM6
	 ruI5rw3ZXuK6ZxQI5ewtOOU8kgtO1X4yPxhVrt0xEOj0KE0he1ZlPJlO66nxPlAlvA
	 4DrzBPq4Dn7INqQiqXV9fZqXs5NYOr4i0W7+6IjI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AE489F8025D;
	Thu, 19 Jan 2023 17:56:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 36F95F8047B; Thu, 19 Jan 2023 17:56:29 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D2D9F8024D
 for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2023 17:56:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D2D9F8024D
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=STm5w/bI
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 43D80B8262C;
 Thu, 19 Jan 2023 16:56:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B59C433F0;
 Thu, 19 Jan 2023 16:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674147386;
 bh=vYB/POmz1JN7+fktKqVImJWhIUL+Tb69KLQ6YaDjnPo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=STm5w/bIDaPOIla+1JbIRkUG01rkOnnQfRQmlDaJN36z9WUskI+SvWwcHGdp8Syhf
 ygfE+HyZ6Ypfyy1R8RQZryRQVh8HpEnEaIeUre7jU4i3WOWJLm65A0m9wIhQAWvsIs
 upAHBSpdIb5dB/Dp3uXiyZ3V42XV/OOAEdl0srjz/CLGxFj76acbl0LagVtXiTFOYM
 fJ3AoRhQychLuW4/OxiPiVd3alks1nJvNWwk5ucGEzPJ8hXSAFqiiS1DFNu2j6OwdQ
 AgdsyYnKacD4gGyGp8LX5XU/I2kzXe4qwfbMnGpTbtEeASnJrKzcKcIAfoUsXLXy6t
 uJqQDgZpsPPGQ==
Date: Thu, 19 Jan 2023 16:56:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH 2/5] ASoC: pxa: remove
 snd_dmaengine_pcm_open_request_chan()
Message-ID: <Y8l2NgLJsXaPn8ma@sirena.org.uk>
References: <20230118161110.521504-1-arnd@kernel.org>
 <20230118161110.521504-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NKZYQGe6T7OEAaOl"
Content-Disposition: inline
In-Reply-To: <20230118161110.521504-2-arnd@kernel.org>
X-Cookie: What is the sound of one hand clapping?
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Andreas Pape <apape@de.adit-jv.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--NKZYQGe6T7OEAaOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2023 at 05:10:46PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The last caller was removed, so there is no longer a need for
> this function.

Please remember to copy me on ASoC patches...

--NKZYQGe6T7OEAaOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPJdjYACgkQJNaLcl1U
h9DHFgf/YGHiNN/UeGdlqcXqDoYWz91UtKDJMrvyRDgoPumSgpyJHjjnYFXpgTOf
N0q1QMlYAJxDhFBvIzYo+QynGZX77mxiowyC/Lv167/QEouS9QAitd5ggGMYBMrI
qIQIqpEBKwF+dMBih4VfLYjQWYGwrIPzf7/HC4UBTjZ2YmvqxBW9AWxOaS9ZSn3T
nPPdPL5qpdjQmrM4CI3XrK+YJgiuSI4rNnVSFGtnXmuHmqMcTWQy31CdTgt81y7F
TAclI4943noOjH41fR1jAUzuuTq0uEI8NFU/xz27IgJRhaxloi8eg5vAyaY/e+ip
fLMoM2q6WGAJEG9WKZptPrLUCmTIrA==
=O4Ci
-----END PGP SIGNATURE-----

--NKZYQGe6T7OEAaOl--
