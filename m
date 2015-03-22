From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5 v4] ASoC: soc-core: indicate warning
 for unbind/bind issue
Date: Sun, 22 Mar 2015 18:50:14 +0000
Message-ID: <20150322185014.GG6643@sirena.org.uk>
References: <874mqq5slj.wl%kuninori.morimoto.gx@renesas.com>
 <87wq3m4dyf.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4108697289345725607=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C9449261B23
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 06:03:14 +0100 (CET)
In-Reply-To: <87wq3m4dyf.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4108697289345725607==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yq2ad9TzNXzcxitU"
Content-Disposition: inline


--yq2ad9TzNXzcxitU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 13, 2015 at 04:44:05AM +0000, Kuninori Morimoto wrote:

> Ideally the correct fix would somehow make sure that the card itself is
> unbound and put back onto the probe_defer list in the future.
> We indicate warning to this issue for now.

I don't think we should be trying to do this at the ASoC level at all,
we should do it at the driver core level.  A similar issue applies to
other inter device dependencies - if someone manages to remove a GPIO
controller, a clock or a regulator for example.  The components of a
card are really no different here.  Like I said in my mail just now
let's have a look at how this is supposed to work at the driver core
level and ask Greg if there's nothing clear.

--yq2ad9TzNXzcxitU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDw7lAAoJECTWi3JdVIfQlPQH+wRcw97D6dWtOek/YDJkaqpD
UJ+NocLdMZZNSn6ucSkPzLNaYtRKorQxSj+z0aPfC/1b+vWtJ5cPFTzwdCu+buWh
uEM0tary7XMtD7w7qL/RE3n6oNSHeU5j5oFoOiYkKzt2I2Q6G1d47Bv44wgZOPC4
Oz8VZeA/mbU/rLGjdGizP8qUVL/SJtlPU7BtoJ2H3T0AMrsxenOXtdJ7DH/LDqCb
udMIGAYmAC33IKN8/ao+ZEulMrW8Xx/aZ+Wk4V+9X48DSGqlACpNXGf8Yo5OFdg/
yAtd2z1pJ9N8xyduO8zuuqjmwU5KwYo/Yz9c96mmK/e/SsccuzdCSfJQ6qeu3HU=
=nz4Y
-----END PGP SIGNATURE-----

--yq2ad9TzNXzcxitU--

--===============4108697289345725607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4108697289345725607==--
