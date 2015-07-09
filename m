From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/2] ASoC: Intel: skylake - match braces
	for if-else
Date: Thu, 9 Jul 2015 09:43:22 +0530
Message-ID: <20150709041322.GC836@localhost>
References: <1435079413-28094-1-git-send-email-vinod.koul@intel.com>
 <20150708182723.GX11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1355516015410402229=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F46A265CA8
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 06:11:38 +0200 (CEST)
In-Reply-To: <20150708182723.GX11162@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1355516015410402229==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2015 at 07:27:23PM +0100, Mark Brown wrote:
> On Tue, Jun 23, 2015 at 10:40:11PM +0530, Vinod Koul wrote:
> > Coding style mandates that if-else should match braces even if one of t=
hem
> > is a single line statement. Fix it in two places missed earlier
> >=20
> > Mark, you can also fold these two patches with SKL driver series (1st a=
nd
> > 2nd patch can fold in 1st and 2nd patch respectively) or apply independ=
etly,
> > either way okay
>=20
> I really don't know what that series is any more, sorry.  I've got two
> pending serieses both identified as Sky Lake and sent after this one.
Hi Mark,

For the last series you said you were okay but had noticed some style
inconsistencies, so I fixed those with this. The updated patchset (rebased)
has these folded in, so this can be ignored.

--=20
~Vinod

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnfTiAAoJEHwUBw8lI4NHGGoP/Aumh8+xAGfP5ZauixW9rUZh
J1Y2A3ReoenRv9nKP0OpHzhce71pT6XRRHQnXyRmBqauCbUnXFRJs7uNkowKYJ5t
1TfhR2hh3e18OWOSUWu4yLdrzo47jhRQQccj9IYBrJmoUdaZdQkng0Ma2fg0my+x
3GmVJ2xsNwRDNpVcXt1zEJaTvOcbUdU3YXtTSF+za02uZ7PbBOZ+biX6vFeWUct7
oH1DVVDW2WLxpm8EbGhXgMwATacvPy0RcdxmYq2E5H1OnPQBrAQxrLzH/c8XtUDU
ZqIcpbDgBXJ8ws3McZxaK6wc1RlzpvELTSats9h44CFmDrwp/id1GMr7yMquQUq3
+D2dO/PDH4ZjtzBpmWo6z7z5LFir7S0rO8zPUjTJaGmCd/0Di2wN3Z5s+2H2NlxS
md28kh/V3NxGBZawE7gkSqufG51IVcxGkQfyOQu7aq5h0D/jBeoxAr/3ID9ZJzoF
QtLzv69exIatsot/slqz9PF4/r6yljn+jXjk63K5Kd+xsToPukKucisjls10xz4I
dygfJ85aoQA3ZErnsDHtWH0pFl/cs4jbtieaE11YGO+EmueqWVzphoZAxfix2AOR
vn1vhIj1qMof85VGYsTTDzKt3GPeg4BGm24sKx9p29XbKDNcKMhAhVcypQhSlzLG
lRIiInNlwR4bZM8Uz8TK
=zg4+
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--

--===============1355516015410402229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1355516015410402229==--
