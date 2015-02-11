From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Clean data after SST fw fetch
Date: Wed, 11 Feb 2015 10:13:26 +0800
Message-ID: <20150211021326.GM2593@finisterre.sirena.org.uk>
References: <1423533767-52698-1-git-send-email-libin.yang@intel.com>
 <96A12704CE18D347B625EE2D4A099D195F3B47@SHSMSX103.ccr.corp.intel.com>
 <s5h61b9rgzf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7035809821014783674=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 041FF26057C
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 03:14:24 +0100 (CET)
In-Reply-To: <s5h61b9rgzf.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Yang, Libin" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7035809821014783674==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1hVIwB4NpNcOOTEe"
Content-Disposition: inline


--1hVIwB4NpNcOOTEe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 10, 2015 at 03:14:28PM +0100, Takashi Iwai wrote:
> At Tue, 10 Feb 2015 14:07:23 +0000,
> Yang, Libin wrote:

> > The patch is aimed to be merged into Takashi's tree because Mark's tree
> > lacks of another patch, which will cause compiling fail.

> I can merge this directly to my tree, or Mark can merge at first my
> for-next branch then merge this one.  I don't mind either way.

> Mark, let me know your preference.

At this point given that I've sent everything for -next already it's
probably easier if you apply it then I'll pick it up when I merge -rc1.

--1hVIwB4NpNcOOTEe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU2rrGAAoJECTWi3JdVIfQzl0H/0i+by7nsQSwUMPJRG7vbYsU
mTOPmOjMaOeyKo7IusDe3L62U1qqwnma8skqYi2jSZfBzHeTs+EglwfEgdZO5Nmx
MgXx3L07PWl08SeueiCavPCXojjv7i810YNpsuMhfyLCA/tNMs7tpHtTYRhaWrZ/
0xhgwuTeBOXguY8yOWN6f8kHPnZ04dDxpxgnOfpREYjOOBXXxAYeKhZjYthe7+In
wUlUb+OcDBnWykB/SlxY0zAH9Vo5bDWhFwVzuq/K3YVN0duGACCskWsi946Ww6Lp
ahmeCu1TYzBKXokyYHvhAzL+W8Nn3ffdeWIsa9ZWKBpImLY2oLlEeZBks/rdtCQ=
=Um+a
-----END PGP SIGNATURE-----

--1hVIwB4NpNcOOTEe--

--===============7035809821014783674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7035809821014783674==--
