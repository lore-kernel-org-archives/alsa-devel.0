From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Linux Kernel-3.5 crashed as dapm is not supported
	by codec
Date: Tue, 6 Nov 2012 12:43:24 +0100
Message-ID: <20121106114323.GD10080@opensource.wolfsonmicro.com>
References: <505AFB0B.7010306@st.com>
 <20120920114951.GJ17666@opensource.wolfsonmicro.com>
 <505BE5BB.5010008@st.com> <5098E929.7040404@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4745398256631665449=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B438926172E
 for <alsa-devel@alsa-project.org>; Tue,  6 Nov 2012 12:43:25 +0100 (CET)
In-Reply-To: <5098E929.7040404@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============4745398256631665449==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
Content-Disposition: inline


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2012 at 04:10:41PM +0530, Rajeev kumar wrote:

> Once again I am raising this issue. Sorry for that.
> First time I have implemented dapm support for my codec driver
> (sta529), but still crash is there. There is no any asynchronous
> events, so platform/Machine driver does not contains any dapm
> widgets.

This is probably a bug in your system given that nobody else is seeing
it, I'd suggest you follow normal debugging processes to figure out
where the crash is occuring.  Just a backtrace isn't really enough to
provide useful diagnostic information (especially without the
translation to line numbers), you should at least turn on logging and
also translate the backtrace into line numbers.

>=20
> Please find below the implementation for dapm.
>=20
> static const struct snd_soc_dapm_widget sta529_dapm_widgets[] =3D {
>         SND_SOC_DAPM_DAC("DAC", "Play", SND_SOC_NOPM , 0, 0),
>         SND_SOC_DAPM_ADC("ADC", "Capture", SND_SOC_NOPM, 0, 0),
>         SND_SOC_DAPM_OUTPUT("HPL"),
>         SND_SOC_DAPM_OUTPUT("HPR"),
>         SND_SOC_DAPM_OUTPUT("SPKL"),
>         SND_SOC_DAPM_OUTPUT("SPKR"),
>         SND_SOC_DAPM_INPUT("MIC1"),
> };

Does the device really have no power control at all?

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmPfEAAoJELSic+t+oim9suEP/0nSrk6IJ9grIQLDBeOur1Kf
6EpKfp6JhgO5vYgjVL2O+FCduDX4X92PK87MUzauGiXRw1tMBvWUtJ46TQJ+LjDg
jTstWaxCE82HEfxr6PE+MBBwjsldkmzOAMv26hQ8DnauExZItSsiaRE6imanRf8N
gLFltqz6Wuso8+2mSY8LmrkTuV1oCSAmyPII8WG3NV3Ifo/Qyq8ZOcC4HD2LfcbY
yLCfadf2LvJl+w62qHbL4uK8EhTkqL5eyRJBOfCm8UGMmxhDRM78X2gb4WxvdDyo
lnGc789bvLaL5FQOuKEjLD8PuJmHA7Qti1Ki/WbPpQ52s+Zmw8jq7LyTEsILHqLb
Yoq/yFIK91UEN8u/Si7IiYccxvdakIn60kDu+ZrdOSrf+cSY96xvAHwrH+oFqas4
a1OK66VTKj0nIJdOPpaZEwoRx3VvANUpFESqZrCUoNDth89IvcFM4ARCtsZVcswq
MkH1vMwTqTPdrWyryfL+wmrVEfpZn++a4GcX5u/tHHaPFLs6Dg9GFN3r4KGi1Qr+
YA588YkHrorEsrgVz3L9jq0ziWPQf2fwYDWxNYgIHvgAvWWpaOpL7aAqbrFckFrh
ADl1jm8QUspKZJcvh7851PBTS2gqAkAl1lF7rBX3vDSNwmQwGuZ/TGCPfhYGEvfX
lebWbiF15CE2LsirQhAH
=i/Jz
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--

--===============4745398256631665449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4745398256631665449==--
