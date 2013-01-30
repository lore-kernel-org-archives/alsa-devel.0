From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: tlv320aic3x: Remove mono support
Date: Wed, 30 Jan 2013 10:15:47 +0800
Message-ID: <20130130021545.GE4945@opensource.wolfsonmicro.com>
References: <1359134360-25482-1-git-send-email-benoit.thebaudeau@advansee.com>
 <1359491508-22518-1-git-send-email-benoit.thebaudeau@advansee.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8900106734756458886=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8B4A32615D2
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2013 03:15:53 +0100 (CET)
In-Reply-To: <1359491508-22518-1-git-send-email-benoit.thebaudeau@advansee.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau@advansee.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8900106734756458886==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AsxXAMtlQ5JHofzM"
Content-Disposition: inline


--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2013 at 09:31:48PM +0100, Beno=EEt Th=E9baudeau wrote:
> Playing a mono stream on the TLV320AIC3x results in too fast playback rat=
e.
>=20
> Remove mono support so that mono streams can be played correctly on this =
codec.

Applied, thanks.

--AsxXAMtlQ5JHofzM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRCIJDAAoJELSic+t+oim9CmIP/i3/wWIDLAEcIf+GiIWq7LuB
ttuJ99YbOb9E7VeBPtDnhvD4bC6E/rfIgN8ceatcaaV3cak3BEsZbzRLGUyAdp8P
1rTblEjQdmnmivIQfnpbN0KaQFKoI/Y5giVU1rxZwbbp63/+u8BjzFgsOmH753Rp
xjryEkR29JYHv7MV6PV30Owbnk0qJ8flwPqsTjYyJisXG1lAu63WPN0EbkymgJY4
EhLqzC4hcdh8jnYuVaVLsAfwpVuucLfPj0Fs0Ai9ff6xILSBUF+oC25BbBL0KSlJ
TpDYBwHZ5Lr7Ij1GPkqftx4J2Z6QIe/jPX/qjWQF/qNWEKUxrKEC3aljsl0k8Y3f
PjO2nS8shQqFphJFWR2K1lPFBf2TuHiETdThfGoMGf2Ev0fVzg63+Enh7LsqPZv5
EwXzvbCrPRy0PAhq6bgmxg2g1wwqmvYKjr6TwM3oie39K8oESDKI6X7fFP+dOpQ8
wvVohTIBm0UNSMzK/ILwAcg7XiG2TPcUc9x99OqGtDA7n3ovuBqSKKvfR3LpYEKK
QolyAASDl0R/9goKFBJUDur8umgkB0xeDxWHNvlJOHCMg9yrGBxmAnE62Crv6HtG
R3vJwVMUi15kNSV8ZnTBzE20e6xSTFz9io4eGLm1dUWDsdGGaZgc3pzqgu31SZfi
uTwUTJBQm9fijwz/pNUX
=xiZP
-----END PGP SIGNATURE-----

--AsxXAMtlQ5JHofzM--

--===============8900106734756458886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8900106734756458886==--
