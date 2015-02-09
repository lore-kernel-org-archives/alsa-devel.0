From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/6] ASoC: rsnd: tidyup .remove method
Date: Mon, 9 Feb 2015 16:11:50 +0800
Message-ID: <20150209081150.GC2593@finisterre.sirena.org.uk>
References: <87h9v4gbhg.wl%kuninori.morimoto.gx@renesas.com>
 <87iofj7qhc.wl%kuninori.morimoto.gx@renesas.com>
 <20150204205503.GM21293@sirena.org.uk>
 <87a90nwlur.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8142326060218441535=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D808A2606D6
 for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2015 09:12:21 +0100 (CET)
In-Reply-To: <87a90nwlur.wl%kuninori.morimoto.gx@renesas.com>
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


--===============8142326060218441535==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
Content-Disposition: inline


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 09, 2015 at 08:04:42AM +0000, Kuninori Morimoto wrote:

> These are v2 of unbind/bind issue fixup for ASoC.
> It adds new snd_soc_remove_card() and temporally remove card from system.
> and rebind it again if next component was binded.

As I've said on a number of occasions before please do *not* send new
patch serieses in followup to old ones.

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU2GvFAAoJECTWi3JdVIfQ/TEH/iFn0n/4XyACWQnr9/Rqh7aI
nWJr5jNJL2We2y1Bo/edhacMWlVAofxtOd4Iyc2RNu5sK1XGPcGsVQAX1mY6AL3q
65WMNKCiUHGMbds6QNsgSrZ7DWnzOSK3OMflp6QZ4CRi5SdAWdynAE0PxGkbyZ87
UFanb8MZJfoJXmF6CsdWg+PMPMN45RuZxQXPx0TR+9EBGoK6tmrklgQXiWRd1+HS
cMNDji7nWox3upeh3TibLXeKYbpD0qteGluaUZKIjncoioCEfGmXJS8SzJQac4TI
p/1+rpe0ZtuY8kOl6VkzG+w94hYYFAH5FJEa7308ySFIeWEw+xTwdbnJzQWCXnk=
=CsHb
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--

--===============8142326060218441535==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8142326060218441535==--
