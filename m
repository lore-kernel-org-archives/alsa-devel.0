From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: wm8741: Add differential mono
 mode support
Date: Tue, 5 May 2015 12:22:39 +0100
Message-ID: <20150505112239.GD22845@sirena.org.uk>
References: <1430504037-7170-1-git-send-email-ce3a@gmx.de>
 <20150504112537.GA15510@sirena.org.uk> <5547C29C.9020905@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3020992556788272543=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BE262614AC
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2015 13:22:52 +0200 (CEST)
In-Reply-To: <5547C29C.9020905@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>
Cc: ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============3020992556788272543==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EjY/e2DNUptFmPPf"
Content-Disposition: inline


--EjY/e2DNUptFmPPf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 04, 2015 at 09:03:56PM +0200, Sergej Sawazki wrote:
> Am 04.05.2015 um 13:25 schrieb Mark Brown:
> >On Fri, May 01, 2015 at 08:13:57PM +0200, Sergej Sawazki wrote:
> >
> >>+static const struct snd_kcontrol_new wm8741_snd_controls_mono_right[] = {
> >>+	SOC_SINGLE_TLV("Fine Playback Volume Right", WM8741_DACRLSB_ATTENUATION,
> >>+		1, 255, 1, dac_tlv_fine),
> >>+	SOC_SINGLE_TLV("Playback Volume Right", WM8741_DACRMSB_ATTENUATION,
> >>+		0, 511, 1, dac_tlv),
> >>+};

> >Please follow the control naming standard in ControlNames.txt: all
> >volume controls must have Volume as the last word in the name.

> Thanks for this information. I would suggest "Right Fine Playback
> Volume". Where "Right" is the "CHANNEL" from ControlNames.txt.
> However, there is no "Right" in the "CHANNEL" section.
> What do you think?

If the device is in a mono mode it shouldn't have Left or Right in the
control name at all.

> >>  	.playback = {
> >>  		.stream_name = "Playback",
> >>-		.channels_min = 2,  /* Mono modes not yet supported */
> >>+		.channels_min = 1,
> >>  		.channels_max = 2,

> >This should be varying with the platform data: in the mono modes we
> >can't do stereo and I suspect the stereo modes may have issues with
> >mono.

> I think this should be always ".channels_min = 2". In "mono mode"
> the DAC plays either the right or the left channel, however the I2S
> signal is expected to be stereo.

Does the device only do I2S or can it do DSP modes as well (and if it
does are they OK with an actual mono signal)?

--EjY/e2DNUptFmPPf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSKf+AAoJECTWi3JdVIfQmE0H/38Lm48F0zd86XEL2DzGbQHO
olMbmfLZaQR81I2Do56mgMWv6ng5IbHpV0OVL5Mxqv+GbfQRDrxiHYofgC2vYvT5
MKVu6qDcwXyHyQZ+icMyuK4KIhK9T0y/IOF0NH3qbPrFLm4/hcnKRt+tmJ3c30fZ
JTd69Mrhuoyi5Kyuljnsm7POoOAigDBHfz74Gkgzs+eTdYxHBh6kcwXDhlVHgDTa
Aw0KsJDp6cgHcK4Gn86gnRhxj5gQ39W/fkuc+UIWQwYOY2iHewh2FOWOAT80Ku1c
DLFWPpazIQj/56rxYq06tv2doDvvg7rFJTCPHtGbinni/F8BTKYh96jG1IHUNOM=
=U3cH
-----END PGP SIGNATURE-----

--EjY/e2DNUptFmPPf--

--===============3020992556788272543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3020992556788272543==--
