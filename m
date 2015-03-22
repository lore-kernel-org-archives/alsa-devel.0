From: Mark Brown <broonie@kernel.org>
Subject: Re: dummy codec and the dummy platform use the same
 name: snd-soc-dummy
Date: Sun, 22 Mar 2015 16:15:24 +0000
Message-ID: <20150322161523.GD6643@sirena.org.uk>
References: <A63A0DC671D719488CD1A6CD8BDC16CF602268B58C@SC-VEXCH4.marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0723764909033009356=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CF39526170F
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 05:59:22 +0100 (CET)
In-Reply-To: <A63A0DC671D719488CD1A6CD8BDC16CF602268B58C@SC-VEXCH4.marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zhao Ye <zhaoy@marvell.com>
Cc: "'tiwai@suse.de'" <tiwai@suse.de>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>, Qiao Zhou <zhouqiao@marvell.com>, 'Liam Girdwood' <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0723764909033009356==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Content-Disposition: inline


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 20, 2015 at 11:27:35PM -0700, Zhao Ye wrote:

> Then in
> static void soc_init_codec_debugfs(struct snd_soc_codec *codec)
> and,
> static void soc_init_platform_debugfs(struct snd_soc_platform *platform)

> this two place will make two debugfs_create_dir() with the " snd-soc-dummy" name twice.

> So I think we should change one of the names.

Well, upstream what I'd expect to be happening here is that we merge
everything into a single dummy component which avoids the problem
another way.

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDuqbAAoJECTWi3JdVIfQn14H/iDQbXV0wxe8cE8Lg1YNFj4s
TVMCwnu7f9o9MSwWfoFs6WZavcIcOOc94TctzVVpJ9KCHRTCmk9zH0wwbvFoNpUQ
12CK0Yh2vu8gz4PKAqRLNOsfCWXJgd4BA9SGikGpaOGOFYvfETo63td0lnkoFNak
rbtEYVuAdeO7yHY9WjEpzArDzolZrIcCdHWpdUddWEKAX8dO6dVOyjFplwzThfTy
NLZPCuLcPOOuVgNuHK50kAsuAe/sUgnRoR1pMM3dx5DWEc5B1vqJg2AYUEaL9/K9
rKCHfMGQ/hi7k84xEA9ZuQGy0ny0tzYpRlWw+LMhNOJJWjHByxrqdBUGAoNS5cs=
=hAib
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--

--===============0723764909033009356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0723764909033009356==--
