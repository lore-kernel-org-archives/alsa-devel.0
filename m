From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: add Renesas R-Car core feature
Date: Wed, 3 Jul 2013 11:56:17 +0100
Message-ID: <20130703105617.GH27646@sirena.org.uk>
References: <87a9m6ixgp.wl%kuninori.morimoto.gx@renesas.com>
 <878v1qixfq.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9190138058131552102=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CD3FE26554A
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2013 12:56:22 +0200 (CEST)
In-Reply-To: <878v1qixfq.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9190138058131552102==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oEZHvVXAe659F+M"
Content-Disposition: inline


--2oEZHvVXAe659F+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 30, 2013 at 11:52:45PM -0700, Kuninori Morimoto wrote:

> + * Gen1
> + *
> + * SRU		: Sound Routing Unit
> + *  - SRC	: Sampling Rate Converter
> + *  - CMD
> + *    - CTU	: Channel Count Conversion Unit
> + *    - MIX	: Mixer
> + *    - DVC	: Digital Volume and Mute Function
> + *  - SSI	: Serial Sound Interface
> + *
> + * Gen2
> + *
> + * SCU		: Sampling Rate Converter Unit
> + *  - SRC	: Sampling Rate Converter
> + *  - CMD
> + *   - CTU	: Channel Count Conversion Unit
> + *   - MIX	: Mixer
> + *   - DVC	: Digital Volume and Mute Function
> + * SSIU		: Serial Sound Interface Unit
> + *  - SSI	: Serial Sound Interface

So, this hardware looks like something that should be using the soc-pcm
framework or representing the SCU as a CODEC device but it seems that
the final result here is going to be something that is open coded inside
the CPU driver.  This stuff doesn't all need to be added in the first
version but it does need to be where we're heading.

I think it'd help review here to strip out a lot of the stubs that are
in place and focus on just getting the basic functionality up and
running then build up the functionality later.  Right now it seems like
there's a lot of internal structure in here that's not connected to the
ASoC frameworks at all.

--2oEZHvVXAe659F+M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1ANOAAoJELSic+t+oim9lU4P/3h9BEpVlsrtzLXrH2jib1BI
5mZCu64bhVp4i61mLTJqM86L4pesh9ayGV4NEm5xZGi+GkkRmfPaKbmsYkwgWrAv
6mj8KyZsB8CorKOFQGHanFyBR3kV66jaaulTePsq0rp3zCRBYnWNa0EvIIp9Z9Lp
E1lXxTrgbfc8uzmEBnhKpLrArcLgPtxExt5or8FgeaRDTOcGG6M+JWCz+7/qZ8oM
mrobCIKB/MM9SoYjJWznbbd5R/+D7XWsXXKq7EHeKk63DyRhJ+4G3Ep+JBCUpN0R
Cka9IuUsRwc6et39I1qnpoW/vZpW33Z5Vcgo7Wt3i1NhAdXBciCgFftdS7vkfywS
KKIyDfX3Yr+9wNtgq7UAyq4ANpHnZFTr3ZHv0Pd50+EmzNgs6L2Pr7LMv2UYraf8
Pp2k+jRO9a+/I1KkcoOMl8WQth+SJZhhUaeZb7vzdDY9V8oIpIWoE888J6tk3E2k
LT4i+4SPs0gknKHu0dI3IeMABXRJeP3MlymRV4gxvyuKk+y7UiPU59Bg0wmDzenF
zby7UFZUinAh+IlXo5ZfWya/3kExqSB8NiBpMCJlq3bQdXhotEs/jBuilQAiO5kj
KpDHLHNkIyvfNvInUQuS04PIeTC30GQUkMCoexaZAVXYTT8fOQh/d+Xf0GcTt4Yr
YE3a5ES0zn3YcqeXLOHi
=U9N4
-----END PGP SIGNATURE-----

--2oEZHvVXAe659F+M--

--===============9190138058131552102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9190138058131552102==--
