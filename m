From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/2] add support for SPI control mode to
	tlv320aic23
Date: Fri, 7 Mar 2014 10:55:50 +0800
Message-ID: <20140307025550.GZ13126@sirena.org.uk>
References: <1394100282-27404-1-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6984132306222977117=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C5AE926591C
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 03:56:34 +0100 (CET)
In-Reply-To: <1394100282-27404-1-git-send-email-jcmvbkbc@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============6984132306222977117==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jb0wbLfbWvebn3+7"
Content-Disposition: inline


--jb0wbLfbWvebn3+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2014 at 02:04:40PM +0400, Max Filippov wrote:
> Hi,
>=20
> this series splits I2C-specific part of tlv320aic23 codec driver into a
> separate file and adds SPI control mode support. It also updates Kconfigs
> of existing tlv320aic23 users so that I2C variant is selected.

Applied both, thanks.

--jb0wbLfbWvebn3+7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTGTUzAAoJELSic+t+oim9GoYP/1AWa/s+ZXkj+AiJZMWkIoIe
MC2m7Tfhi3Mofd19xw4CFgW16xx6Yr/3S9BJQNO+5IRMrQPc2vOpsA8U3QzGO+cX
8Y6XLe7HeCU2W5QHYdYodPRxlJUVbqws4M8wOSMcS9Ju8+xPaPACH1aAinHT8z/A
M5T+zM2ZX259+2RRHnkJxBL12X+rLlnN4Kec67t7/NJPaBHY2JjBZMr67TLzscA9
LcQW4wVC2D3pcdrZVxw5jDxfdJRFEi8BiHxw31JO9E27mf8NwWPnxbbObEGysgyr
CUxaftvzDKZ9D4dWYgz5Mf/KK8+UvaBfOS7J0aJkvfHIreGRjC5486ZttRwk0I9S
wIJrLgeJddsUGjnw4n6RFJt+Q+ZyztaHTvsk6tDm/NN4WVh1w2TQ9lu5KvHDUS+T
P8nCmS4mdvk466jeZve6omlFX2SobbhREMr/nDYfViFwtqjZJ0T/flekb3ALKIAg
OPPRj296md9V5KAta7686MNukxLYDRGDESSNSwkfnbe5x0ZTMqjA/cVMxoncsaJY
PsruHpGQNSTurqAgWtxxGDeOwVTQCgYD6Wdjx/AU5XnTyT8y2JEbX6hhaPTjYNXR
XS4yRBh0VmgwDIkNBBR6PoYzPl8PQZAzmJW/q/YOAXK9a+Z6dFyhaF+4kqulvLgc
R12rnYIIu8jXlsot0Tpb
=0QEL
-----END PGP SIGNATURE-----

--jb0wbLfbWvebn3+7--

--===============6984132306222977117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6984132306222977117==--
