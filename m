From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 000/127] ASoC: codec cleanup - codec
 probe/remove
Date: Thu, 11 Aug 2016 18:07:05 +0100
Message-ID: <20160811170705.GX9347@sirena.org.uk>
References: <87popieek9.wl%kuninori.morimoto.gx@renesas.com>
 <54ffe6bb-9a97-db02-e96b-588630b08468@metafoo.de>
 <20160809112639.GJ10383@sirena.org.uk>
 <87a8glii9q.wl%kuninori.morimoto.gx@renesas.com>
 <20160810111748.GI9347@sirena.org.uk>
 <871t1wuntb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1965716865118536759=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A30B266E98
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 19:07:17 +0200 (CEST)
In-Reply-To: <871t1wuntb.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============1965716865118536759==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B8YbZbqleQryf2nq"
Content-Disposition: inline


--B8YbZbqleQryf2nq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 11, 2016 at 01:03:05AM +0000, Kuninori Morimoto wrote:

> Hmm... If my understand was correct, my concern is this.
> If we merged all (CPU/Codec/Platform/etc...) features into component,
> it will be big size, and almost all feature are not needed for almost all devices.

If there are concrete issues we can look at them but let's do that when
they arise rather than early on.  We do currently have devices that span
all classes (CODECs that take audio streams in through their register
maps, SoCs with built in CODECS...) so there definitely are devices that
need the overlap.

> According to your (and Lars ?) idea, if component includes all features,
> then, current "codec" will be "component", and "platform" will be "component" too (?).
> If so, I think necessary patch in final stage is like this ?

> 	- static struct snd_soc_codec_driver xxxx = {
> 	+ static struct snd_soc_component_driver xxxx = {

That's the goal.

> If so my previous patch is doing pointless effort, and will be trouble ?

I'd more say it's premature at this point, it's something that should be
done for each driver once it is converted to not need anything that's
CODEC specific rather than something that should be done early on.

--B8YbZbqleQryf2nq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXrLC3AAoJECTWi3JdVIfQktoH/03xlLChjP2e2ukMF+0vIGbs
5hVwOy7ik+uRTR/CIhob5Pxq+Yx/2pHfG7YRhvagJtNS8uQYfcpu4U9+q0J6qLxe
iytDOYf5tbDVq66n/npa4DA9vEeaBTZapLNwnq5NtNjprjZQ09BhmpD6QMlcFiDr
hmpukicKV0/t8NsYcVC6Euu6nnzucXc1cJZfMS9DYPWWATeZvPQcLqdfzYwUPSm/
630ewUupJlJaEX+vfUA/vMfDXYPPhgRIYC1HERkE2hsTwTJWi3Pfh2Vu3Y9xzTB6
cuNxZY9ZfPL0XMWQOBcDEnYtlsA0Vf0JJB1xBo0Qrg5zTTbUcoeU7ujCHH4htQU=
=6uof
-----END PGP SIGNATURE-----

--B8YbZbqleQryf2nq--

--===============1965716865118536759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1965716865118536759==--
