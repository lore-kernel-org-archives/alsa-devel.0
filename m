From: Mark Brown <broonie@kernel.org>
Subject: Re: Developing a ti-pcm1863 (adc) codec driver
Date: Wed, 23 Aug 2017 17:41:46 +0100
Message-ID: <20170823164146.x53bi4wnzz5funym@sirena.org.uk>
References: <0d6606df-5770-62a0-0187-2abf995b5ff1@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2782024375712265245=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FF30266AF8
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 18:41:47 +0200 (CEST)
In-Reply-To: <0d6606df-5770-62a0-0187-2abf995b5ff1@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oleksandr =?iso-8859-1?Q?M=FCller?= <sanj3k@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2782024375712265245==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yuwuve6nkgwybgmg"
Content-Disposition: inline


--yuwuve6nkgwybgmg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 06:32:03PM +0200, Oleksandr M=FCller wrote:
> Hello Mr. Brown,
>=20
> I have a soundcard which doesnt have a linux driver. Quick information it
> has a pcm1863 adc and a pcm5142 dac on it.

This looks like you've got most of a driver here, probably the easiest
thing to do is submit it using the process outlined in
SubmittingPatches.  The code looks mostly fine so this shouldn't be too
much of an issue.

> 1. Question would be towards the dapm_widgets and dapm_routes definitions.
> When defining the dapm_adc widget do I put there the Capture stream or do=
 I
> seperate it with "NULL" and then adding the dapm_routes definitions? Which
> one is correct since I have seen both possibilities (which ad-/disadventa=
ges
> do  I have?)

Use a route, that's the more modern way.

> 2. Question in my layout plan I need to set the ADC to VIN4 l/r because o=
nly
> this one is connected to the microphone port. I have put it into the sound
> controls but how would I make this switch from the command line (arecord)=
 or
> in the players (like vlc)

I'm not sure I understand the question here.

> Furthermore I would really be interested in gaining more knowledge about =
the
> accesses and routines from e.g. the vlc player using alsa (?) and then the
> accesses to the hardware? Also the whole registering process in which ord=
er
> are which files executed to get into the state where the os knows my
> soundcard. Since in a stracktrace I dont see this high level functions

You can see the card initialization in the code.  There's no defined
ordering for the device model probing, even if things are currently
redicatable on your system you shouldn't rely on anything.

> //Register Addresses

Please follow the kernel coding style.

> static const struct snd_kcontrol_new pcm1863_controls[] =3D {
> 	SOC_SINGLE("ADC MUX VIN4L", PCM1863_ADC1_INPUT_SEL_L, //not possible wit=
h SOC_DOUBLE since
> 			PCM1863_SEL_L_VIN4, 1, 0),	                    //two different registe=
r?

SOC_DOUBLE_R()

> 				"Failed to enable clock divider autoset: %d\n",
> 				ret);
> 				return ret;
> 		}
> 	case SND_SOC_DAIFMT_CBM_CFM:=09

Missing break;

> MODULE_DESCRIPTION("ASoC pcm1863 driver");
> MODULE_AUTHOR("Dummy Name <test@gmail.com>");

Fill it in or omit it.

> static const struct of_device_id pcm1863_of_match[] =3D {
> 	{ .compatible =3D "ti,pcm1863", },
> 	{ }
> };
> MODULE_DEVICE_TABLE(of, pcm1863_of_match);

You need a binding document for this.

--yuwuve6nkgwybgmg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmdsEkACgkQJNaLcl1U
h9Amngf+ILxc4GLCPOhDRCPnfNDYYyHMylREzPgp060gA9zvEeCcQM19hXV3KznI
s0q73ULT6MYz+hiDBEcOtqmcx8maLMq8M6yl8LjeFOxQ8LYyT1BG59+ieig3ZHKO
L+sIkfB+KQvK1W7LCsJ0XwnsVYiSwWn8pX4mdBR5xzRPtyiXJRFogTvgllmAo7kb
Z+B2xLudDMIEe8ZdYmEiomijxZeaI9ZRCXWqZqYB3Anz88RC8ytX6JBSCYBQu9n6
eo7zfrVt6WmQJYGWAXU7grsxH1/WjsKZrIRhFIiWjTRFj7SMa+9pwtFpS0o+nkJl
0PfMdkLWpgXWlO++KgLZTtG0kvKKZQ==
=WVCl
-----END PGP SIGNATURE-----

--yuwuve6nkgwybgmg--

--===============2782024375712265245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2782024375712265245==--
