From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] conf/ucm: broadwell-rt286: change to set
 capture volume and capture device
Date: Mon, 11 May 2015 15:22:17 +0100
Message-ID: <20150511142217.GC3458@sirena.org.uk>
References: <1431069527-9336-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8730116063197952771=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 32A02261AE0
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 16:22:25 +0200 (CEST)
In-Reply-To: <1431069527-9336-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8730116063197952771==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Content-Disposition: inline


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2015 at 03:18:47PM +0800, Jie Yang wrote:
> Set 'Mic Capture Volume' in capture device EnableSequence, to fix
> capture no volume by default issue.
>=20
> Also add JackHWMute Value item to mute onboard dmic while headset
> mic is plugged in.

Tested-by: Mark Brown <broonie@kernel.org>

It'd be good to have a release with this in, it's the main missing bit
to getting my current laptop's audio working out of the box.

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVULsYAAoJECTWi3JdVIfQqzUH/jn0bd/v5876kNU0bHjkIuys
tPk/2kKng2lQhwq+H35QEoKXTci9wM6wGEwceuQx/r6jaAdWczNupk5X5yQGVge7
vu0ohmCsUZJMlLNqEaIJxINdwVIjU+NC4Q8EPltxY75fsgk9eeBKXodkgCBe8GaJ
0GI0GvRoS75iEpc7dMKSKq7sBcqWuoUSEw46mGbsLZUBqc9b4yNynE8oePolJczu
YBJ9IqjqQUIySmy97mwlfAq22J6PnK5hzvOd2AZ4JX+woZ3qPmyy7shxQNG3rocC
Hbxt56Ihtd4RO+5nNDXrbapfSBnUs7Hzd9xW2ILgmjZsGzCN7MHeTtBy+eglofk=
=vHzh
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--

--===============8730116063197952771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8730116063197952771==--
