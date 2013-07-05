From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: add Renesas R-Car Generation
 feature
Date: Fri, 5 Jul 2013 10:34:04 +0100
Message-ID: <20130705093404.GO27646@sirena.org.uk>
References: <87a9m6ixgp.wl%kuninori.morimoto.gx@renesas.com>
 <8761wuixf1.wl%kuninori.morimoto.gx@renesas.com>
 <20130703111034.GI27646@sirena.org.uk>
 <87bo6j1706.wl%kuninori.morimoto.gx@renesas.com>
 <20130704092636.GM27646@sirena.org.uk>
 <87y59lx1ci.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2472912983760750310=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CA3E92659EE
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2013 11:34:07 +0200 (CEST)
In-Reply-To: <87y59lx1ci.wl%kuninori.morimoto.gx@renesas.com>
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


--===============2472912983760750310==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="77Z/nGD8eQOLVPGo"
Content-Disposition: inline


--77Z/nGD8eQOLVPGo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 04, 2013 at 06:06:06PM -0700, Kuninori Morimoto wrote:

> > Yes, what I was asking was if that code is reimplementing things that
> > are already provided in generic code.

> Thank you.
> But, is regmap (or already provided code) possible to use for this purpose ?
> I can learn more about it.
> Could you please teach me sample code ?

Look at the st pinctrl driver - it's the only user of the field API at
the minute.

--77Z/nGD8eQOLVPGo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1pMJAAoJELSic+t+oim9xE0P/R18uY3n3A2Dj/avJd5O84bj
DvyJQESdAoDDRNxS2ZMjTrBCpC0bAPOU/CCdp2n4yxCfrFTf7MNvcbXgOZgvM0Rl
3lhc3o8wKSINU3AvZElAjSPh1ZkmLWMD/2lEAYp8Qc7lxOM0tskmMKolflNOXweK
GqwLRtBapJyES5iGzu1tmJIjdNUzO+hEfGJGBUI3Y/XEdvTLwLEWI9EJJXQG/rvx
Nl8sjEAmJ128krv1zltWXtlg5Pi3fKmOy8HqaVtcPKIS4Fb4ikvGZnMDj5OSxT16
c5Hfr+iHj50NKIQPyTrQIkA+wXrB9vxrRiCeb4Y1uoijU4cdRqW4A13SsJoEWurZ
KoQovvh1nIbAayFAU68XZ57yVn6Xir4YvF6sh4jYTxGifBmIQzJD5iRODBRRTS7V
cyTBeAvqRrQy7TCVD44sVPFifNdY/oSn8MpltQZp3dYbq3uuPz8JiH8uitiGq1Fo
YyEDnm+Wb+rUcG1JMMdXLCPQwO7LFZqyL0Th2bbwH9t308fFbg57ybEuiaVRrXnz
lDaP7Ka0we4PErWjOE+GLWjN1POSlUJ/08wvQitbb0WYmFzEFiBGUerLK4qJ1K1h
nR7v4CYVWVrS8lHsldMqwa4VAry+gQuPszS1vpz+phUcSvAnAc7fqEgYoGeXug2y
tSjEQBjN5ckR5FRvHer6
=utD0
-----END PGP SIGNATURE-----

--77Z/nGD8eQOLVPGo--

--===============2472912983760750310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2472912983760750310==--
