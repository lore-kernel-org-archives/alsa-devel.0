From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4] ASoC: tas2552: Support TI TAS2552
	Amplifier
Date: Thu, 3 Jul 2014 10:19:44 -0500
Message-ID: <20140703151944.GS5814@saruman.home>
References: <1404398393-21497-1-git-send-email-dmurphy@ti.com>
 <20140703145250.GO5814@saruman.home> <53B56F63.8000400@ti.com>
 <20140703150621.GQ5814@saruman.home> <53B57302.8030100@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7744631260047914652=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 23D1D2654C6
 for <alsa-devel@alsa-project.org>; Thu,  3 Jul 2014 17:19:49 +0200 (CEST)
In-Reply-To: <53B57302.8030100@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Murphy <dmurphy@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, broonie@kernel.org, balbi@ti.com
List-Id: alsa-devel@alsa-project.org

--===============7744631260047914652==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CC5qiHV/f0UkyWC4"
Content-Disposition: inline

--CC5qiHV/f0UkyWC4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2014 at 10:13:06AM -0500, Dan Murphy wrote:
> Hi
>=20
> On 07/03/2014 10:06 AM, Felipe Balbi wrote:
> > Hi,
> >
> > On Thu, Jul 03, 2014 at 09:57:39AM -0500, Dan Murphy wrote:
> >> On 07/03/2014 09:52 AM, Felipe Balbi wrote:
> >>> Hi,
> >>>
> >>> On Thu, Jul 03, 2014 at 09:39:53AM -0500, Dan Murphy wrote:
> >>>> +static int tas2552_set_dai_fmt(struct snd_soc_dai *dai, unsigned in=
t fmt)
> >>>> +{
> >>>> +	u8 serial_format;
> >>>> +	struct snd_soc_codec *codec =3D dai->codec;
> >>>> +
> >>>> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> >>>> +	case SND_SOC_DAIFMT_CBS_CFS:
> >>>> +		serial_format =3D 0x00;
> >>>> +		break;
> >>>> +	case SND_SOC_DAIFMT_CBS_CFM:
> >>>> +		serial_format =3D TAS2552_WORD_CLK_MASK;
> >>>> +		break;
> >>>> +	case SND_SOC_DAIFMT_CBM_CFS:
> >>>> +		serial_format =3D TAS2552_BIT_CLK_MASK;
> >>>> +		break;
> >>>> +	case SND_SOC_DAIFMT_CBM_CFM:
> >>>> +		serial_format =3D (TAS2552_BIT_CLK_MASK | TAS2552_WORD_CLK_MASK);
> >>>> +		break;
> >>>> +	default:
> >>>> +		return -EINVAL;
> >>>> +	}
> >>>> +
> >>>> +	pm_runtime_get_sync(codec->dev);
> >>>> +
> >>>> +	snd_soc_update_bits(codec, TAS2552_SER_CTRL_1,
> >>>> +			    (TAS2552_BIT_CLK_MASK | TAS2552_WORD_CLK_MASK),
> >>>> +			    serial_format);
> >>>> +
> >>>> +	pm_runtime_put(codec->dev);
> >>> I have a feeling it's better to just put at the end of the function.
> >>> Remember your pm_runtime_put() will issue i2c transfers which can tak=
e a
> >>> looooooong time ;-)
> >> I thought about that but the next switch case could return if the form=
at
> >> mask is invalid which means the runtime calls would not be balanced.
> >>
> >> So I decided to wrap the snd_soc calls with the pm_runtime calls to ke=
ep it
> >> balanced.
> > it looks like you can do both switch statements outside of the
> > pm_runtime region and cache results on serial_format and do a single
> > write to CTRL_1 register (?). If not, then just use two local variables.
> >
>=20
> Yeah I could probably consolidate these into a single call.  And throw
> a debug statement in the default case to why the format was not set.

that'd be cool.

--=20
balbi

--CC5qiHV/f0UkyWC4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTtXSQAAoJEIaOsuA1yqRE/g4P/0eagtzicEo1kesEhcsm47bZ
cG3f2uZyPaQXJlGNiMOBQe7afZv0lFQNmdGrV9WRWRh5AWePTvnvDQoCFzDdkypH
o5X6qs3l9K01FVlDUq03wCwdiDTSYT0PtATd1BVgDIgvwUgBoPaT/F5IGlOc5kS8
Mommdr/7HFyjX44Ao2EM0OPT6kb1U+vTQhmHintMv0/D3hNn2TpeHzPlzfwy3jay
QtPFyUx6pCPV73uPTCfcm0ARNz+Hg6ewtar6mD/vm6YZYCSS3/3bAHmiduuEcABL
yXrRsK2k43gPYTncTRE6+o/M7I+nNUDVorcU5/h3ORT3qrtok6AgmdexvDwvkrpa
sZ6ayzE7Xd8gO7EK/ZjO6ypJgoX4HRtnhefF8YPMJExCZzQJTx1yQu+KLSOJjE9p
Qo31zT2eKvRXdTQ6OpT6v66OqfaifvG2YCoIMGeKimOn9yCwXez5soBK660AZED3
t7Q42FpwlulSOzOv7mFBznvgO8p3i4GYbLlo3m7PjB4zYyWG0x70dfrWiIbKdio6
z8j2rPHZFWmWeqkW9cxxc2ceqq+Ao8qcY8BkshRlKTvAT1wJQjmpRoKqDLVd9AjC
+IVK9FSEg2K2/e+yWH7h+j4yIyi2e0Cn6Ho4PgmCMlCrAAk0YkQzeaLOM8KzvP9S
BWskmmrNiCABvntdqhsI
=5Pyl
-----END PGP SIGNATURE-----

--CC5qiHV/f0UkyWC4--

--===============7744631260047914652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7744631260047914652==--
