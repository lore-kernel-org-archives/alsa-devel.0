From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Correct S24_3LE support
Date: Mon, 23 Jun 2014 16:18:22 +0100
Message-ID: <20140623151822.GA23300@sirena.org.uk>
References: <1402059931-10731-1-git-send-email-peter.ujfalusi@ti.com>
 <20140609202403.GX5099@sirena.org.uk> <53A82519.6050506@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7680079093618791502=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E5F952657A4
 for <alsa-devel@alsa-project.org>; Mon, 23 Jun 2014 17:18:41 +0200 (CEST)
In-Reply-To: <53A82519.6050506@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7680079093618791502==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 23, 2014 at 04:01:13PM +0300, Peter Ujfalusi wrote:

> AIC3X_FORMATS is correct:
> #define AIC3X_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
> 			SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)

> While in hw_params the switch was not handling the S24_3LE but it was defined
> as S24_LE. So the code was not correct: It advertised that it supportsd
> S24_3LE and was not handling it, but it was handling S24_LE which would not
> happen with this codec driver since the format is not supported - as it was
> defined by the AIC3X_FORMATS.

> This is a fix for the current driver.

Yes, but the fix should be to support both.

> > I really need to get round to doing
> > the rest of the conversions to use params_width() which should ensure
> > this.

> Not sure how this would work at the end to be honest for all platforms and codecs.
> How should the bitclock need to be configured for S24_3LE, S24_LE and S32_LE
> msbits=24? They are at the end have 24bits audio data but in memory they are
> stored in different ways.

The number of bits on the wire should be the number specified in the
format.

> Aic3x for example need to be configured to 24bit mode (24 clocks/channel if it
> is master) so it is going to 'pull' that amount from the CPU side. This can
> not be used with OMAP's sDMA/McBSP but davinci's eDMA/McASP can support it. I
> can even get daVinci to 'extract' the valid 24 bits from the 32bit sample
> coming via eDMA (mask/rotate/reverse operation).

Sure, so it only supports exactly 24 bit sample formats in master mode.
That's what's expected by default.

> So I still think that this is a bit more complicated than it looks

I'm not seeing anything particularly hard here.  The main thing is that
we ought to do something for dealing with extra BCLKs (eg, a device that
can tolerate extra BCLKs can have the other end generating more data
quite happily).

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTqEU6AAoJELSic+t+oim9+ccQAJriCUZ0pz7YOs0NIe/gKvMN
nR3T1EhDAKgXwjdjplFRg2aETUzGkqsA0nG6KyigYwUxpyv2UjE72wYeXWE5vJkV
rkV9BL0aJ84xJUdTUyPFGCDqyJ9/2u9uI8kvwUbZ3p6SeZCwIrC40m3QUp+l0f5j
3068BsHRcykIijbBlLj3xe/CUVVJwBt0FbA/Xf4CojrjzUvqRyFIhFE1I+0fY7oD
tpXzgx7JwVLqXEBtEB/TprnhvtcS9z0ps2xxK5zJbMTjn27IPEuJlOM4Cb8Nlpn7
Xxjq52uuZIG6LXPEDga9Vi9Ri7x933rYcvxn1pDYJVvudxDg5DDIyRIea0Ml57td
DHLiRQWig1enGOywAjgl9RN37AWeLDr8Lu6Gg8t0i3VYffgnAmR7DnOVnJmC+V7L
GjytmfrNJ0UtMMnJ4P8UcIaJDWZ6u18L3aW0WHGPpnQv7g3U424albKLtoT+xtQN
cf38vjrWei/L7JkYiEAErPAT9Yz+Zv5/LjJ0E9RjKMT7Wu8UUsIXeKQvVfBi41zm
HgWINrJhDsVJ6q7+d7D3t7rTJpLeXiVlB3s4WBTLb3d0mkPTa+mcH9921KR4cDSV
gw5EivMWHOgcpSe+b6+PKpcP4Ed+hdwr9rmy/dbRG2VfwwMxT9fCkHTNWtPyo9Fm
goPv0GD6hOvkJpFYrF6r
=mvAm
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

--===============7680079093618791502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7680079093618791502==--
