From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V0] ASoC: pxa-ssp: add TISSP mode support
Date: Sun, 10 Nov 2013 11:10:21 +0000
Message-ID: <20131110111021.GB878@sirena.org.uk>
References: <1383640208-11919-1-git-send-email-zhouqiao@marvell.com>
 <20131106112421.GI11602@sirena.org.uk>
 <527C43D0.2030301@marvell.com>
 <20131108101948.GD2493@sirena.org.uk>
 <527EE65D.3070804@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5818618337266457891=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 474F0261ACA
 for <alsa-devel@alsa-project.org>; Sun, 10 Nov 2013 12:10:32 +0100 (CET)
In-Reply-To: <527EE65D.3070804@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, "trinity.qiao.zhou@gmail.com" <trinity.qiao.zhou@gmail.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org


--===============5818618337266457891==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 10, 2013 at 09:50:21AM +0800, Qiao Zhou wrote:
> On 11/08/2013 06:19 PM, Mark Brown wrote:

> The SPI/NSM are not used for audio usage, and currently only PSP
> mode is used pxa-ssp driver. We have the requirement now to support
> this SSP mode. The benefit is that we don't need to configure
> detailed timing in transmit/receiving since HW handles it
> automatically.

> The SSP mode is something like the PCM format for mono stream for
> voice related scenario. In current audio format definition and
> pxa-ssp driver implementation, I don't find suitable way to handle
> it. so I add such SSP-format to differentiate it from PSP mode. Do I
> make a confusion of SSP mode and audio frame format? please help
> comment. thanks.

If this is just about programming the hardware better rather than
changing the externally visible symbols then as Daniel says it should be
handled transparently by the driver, replacing the current code for
whatever formats are handled.  Normally the same DAI format should be
configured for both CODEC and CPU so unless a new format should also be
used by CODEC drivers the update ought to be internal to the driver.

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSf2maAAoJELSic+t+oim9Rk8P+QE1n8H6KXfiHpVBFAC83AMg
9esMLPBbayGFkp82325shjDWxd5PEAHx3D57e3CtHTsEjsbUyFleC3e3u2JW2VPC
ySeKHHDWGoKSuhLR6iNVWTO9FRMkDURpTheE5uSdlrBl/tFDG+7H2jkpa1X3WWOf
/imQmTKp646vl0Va1ikAJnBwJ9ckJ/bSJlbF2Y2cm6rjAJiTpPn/c5/rUwZ3YYBL
2+c3WzuX3ebNeS1PjrvK6QnYO9VfkpMjZrqFqbFWMEz/TJpZCapbgeXVi6lSmm1d
g8YqpDsLGA+nSr5v4M/7VfMUo+2Y2H812U5KJeVWZ4DgIQNnOQYGYjgdtk6lBWd1
ceSCq6LHRw4yYBrJWsviwLceu+7aAjkP2AF0gfGtRXs85rFueVA120rGRMxpYOV8
gOknvUhLQ8mD1bjizV26ZETuxTiOQ8m1FhcUAoAFVpBO3TqnjoKSSFbIOLIjj2Oo
/RLGvS19uaJ5gk4vXPcIn9erw1kzfGnE+1xlN7VPCY/Jm19MLydTa+0NsaUaxGDC
nNA9TLi9n0DImZF7ZSzeUoD5yqjFL2RxG/lHahGZKq014Rc1FaFEc6lH6sqrecZj
C35i6Z8u8GGXDgAmq6/iMOKKOL2WoW4jA6LSLc7z/bjKcap8z+Jfrk0AaA4/P02j
l7kOsuTTFR0q04IQQHV1
=oH2i
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--

--===============5818618337266457891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5818618337266457891==--
