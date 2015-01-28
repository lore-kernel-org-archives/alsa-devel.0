From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: Intel: remove an unused struct member
Date: Wed, 28 Jan 2015 11:36:48 +0000
Message-ID: <20150128113648.GW21293@sirena.org.uk>
References: <20150128064210.GA30893@mwanda>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1906772027169377205=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B285F2619D7
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 12:37:01 +0100 (CET)
In-Reply-To: <20150128064210.GA30893@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Christian Engelmayer <cengelma@gmx.at>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, =?utf-8?B?UGF3ZcWC?= Piskorski <pawel.piskorski@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1906772027169377205==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YHX+EHVZpmeyURU8"
Content-Disposition: inline


--YHX+EHVZpmeyURU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2015 at 09:42:10AM +0300, Dan Carpenter wrote:
> We never set the ->scratch pointer, so let's delete it.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thanks.

--YHX+EHVZpmeyURU8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyMnQAAoJECTWi3JdVIfQkxoH/iOg3ABNPkiX0llPpsyWK2Gc
1tMTJbMwlg6XIvCMl3F30MYlO3383BCGb1zn7QuY7b0NHN3feKOGjdIWIOd4c+6c
/pCFZJV90XJ+GMnKYanel0bfe7ao0CC97uastQsyUnr7UPRgbuvPdyrUaFBPvPcD
JN5X10Z0X64i3wXlI43Fly0885IBxjxKWZS/o2UDMXtrZrTNnWrVCt0t7tQSW0/n
Oj1AiRr0hE6mF7UE1zEmCdlPag6LNEuhZe8jd+wIxYRJ5H/X4uO34ZEndoXbeYzA
1lXIDbv+zGtbOyOxmcybT7SENbZRxB0kkdRBrHAyOnVTOwQvRixOh26IMftBzcw=
=57S1
-----END PGP SIGNATURE-----

--YHX+EHVZpmeyURU8--

--===============1906772027169377205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1906772027169377205==--
