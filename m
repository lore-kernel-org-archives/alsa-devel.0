From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 2/6] ASoC: sgtl5000: write all default
	registers
Date: Fri, 6 Mar 2015 20:14:06 +0000
Message-ID: <20150306201406.GY21293@sirena.org.uk>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
 <1424991273-10081-3-git-send-email-eric.nelson@boundarydevices.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4090777942691593253=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B19BD265E20
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 21:14:11 +0100 (CET)
In-Reply-To: <1424991273-10081-3-git-send-email-eric.nelson@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Nelson <eric.nelson@boundarydevices.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, rmk+kernel@arm.linux.org.uk, jean-michel.hautbois@vodalys.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org


--===============4090777942691593253==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rP5UHQfQfoWLGwZo"
Content-Disposition: inline


--rP5UHQfQfoWLGwZo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2015 at 03:54:29PM -0700, Eric Nelson wrote:
> If an error occurs writing defaults, produce an error message but
> continue writing other registers. The failure of a single write should
> not cause catastrophic device failure.
>=20
> In at least one occurrence, I2C writes of CHIP_ANA_POWER was nacked,
> though continuing allowed the device to operate properly.

I'm a bit nervous about this.  Generally problems physically writing to
the device are pretty bad and lead to followon hard to debug problems as
the chip state drifts from the state the software thinks it has.  If
this is a good idea I'd really like to see more analysis as to why this
is expected to happen and why it's OK.

--rP5UHQfQfoWLGwZo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+gqNAAoJECTWi3JdVIfQXToH/0l2SKkR0o3ZIxl9CxfiJ6Oc
rf8daDQOuTKrhKbTyyBnPhtfHl0e/C+3OT2YVjktUtbMkhYGAWjIFWM2UtsK599D
GN9jRug7MAaz3YAKaHesW1ZNGHAHdK+JfA5OkV/jmkwtvz8g7LqKLb1iTZkGIWSr
SuRNynG1y+NoyEB5s+5g7xMz/Qt4DrISIyv8mPXRMWuMQWtWM4BkMJtZkdjmfZc+
XmUGv/WlBSjAj+w4GB598LqxE+eVf2tjnCgdCWn085vEm5mDrTc/fjHHgBT/2hzU
ztXtpb/JhZga1pmUh+8iKsrnR2kP0heqFbvjzzOEej3wafUt7aLTrioBF6QYveI=
=IYwL
-----END PGP SIGNATURE-----

--rP5UHQfQfoWLGwZo--

--===============4090777942691593253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4090777942691593253==--
