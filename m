From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/6] ASoC: sgtl5000: fix regulator
	support
Date: Sat, 7 Mar 2015 09:59:38 +0000
Message-ID: <20150307095938.GM21293@sirena.org.uk>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
 <1424991273-10081-2-git-send-email-eric.nelson@boundarydevices.com>
 <20150306200415.GW21293@sirena.org.uk>
 <54FA1780.4060906@boundarydevices.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3161481135447268356=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BC8B2605B7
 for <alsa-devel@alsa-project.org>; Sat,  7 Mar 2015 10:59:52 +0100 (CET)
In-Reply-To: <54FA1780.4060906@boundarydevices.com>
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


--===============3161481135447268356==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kYoXnT0tqrMo5Wdj"
Content-Disposition: inline


--kYoXnT0tqrMo5Wdj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2015 at 02:09:20PM -0700, Eric Nelson wrote:
> On 03/06/2015 01:04 PM, Mark Brown wrote:

> >> case SND_SOC_BIAS_STANDBY: if (codec->dapm.bias_level =3D=3D
> >> SND_SOC_BIAS_OFF) { ret =3D regulator_bulk_enable( -
> >> ARRAY_SIZE(sgtl5000->supplies), +						sgtl5000->num_supplies,=20
> >> sgtl5000->supplies);

> > so we avoid stuff like this.

> I understand the intent, but that doesn't work. If the internal LDO
> is wrapped in a regulator and placed here, the sequence needs to be:
> 	enable VDDIO and VDDA regulators
> 	re-enable the clock
> 	wait 8 cycles
> 	enable the LDO for VDDD

So make the changelog actually say that - I'm commenting on the fact
that your changelog appears to misunderstand the current code.

> >> -	/* External VDDD only works before revision 0x11 */ -	if
> >> (sgtl5000->revision < 0x11) { -		vddd =3D
> >> regulator_get_optional(codec->dev, "VDDD");

> > It'd be good to keep at least a warning about this (not that
> > there's one now but it's a good idea).

> I haven't been able to find the origin of this test, but it's in
> conflict with ER1.

My reading of the situation is that early silicon had one set of bugs,
current silicon fixed those but introduced a different set.

--kYoXnT0tqrMo5Wdj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+swKAAoJECTWi3JdVIfQVqwH/0eof0KIY0Ts87CU6C1MlQE+
1SfhgY7wG1PW1MSn3wyS92M/xXLTSdrI+W5WE2Iw3qqvlOsHX1bTqGyed73qxlPz
V+2PsVdHEqQkYq2KdvMi1xfuV6r1c2xBR6+K2C2EsZB4QHCkO8m8fXBG+Gq2Up5M
rhCNeCJdc2Gy/SUZLJTFG9RXMy5308lLRfp631mWhtCPUKSMEUi+9ez8JNUrDQOk
GoBuxgFgq1lkNMIlNSszgxcZV1B5mFPxAqsAnFeOVHbJmmrSTlpx9mmbeq78stRS
2AFm3mITZe1N2ydpuFYLeRTPYhoXhlQI/MWEd5anQVM0ihnnuqHRnFCr3k0wndo=
=kWtJ
-----END PGP SIGNATURE-----

--kYoXnT0tqrMo5Wdj--

--===============3161481135447268356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3161481135447268356==--
