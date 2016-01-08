From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: Modify power management and
 add interrupt wakeup
Date: Fri, 8 Jan 2016 13:13:58 +0000
Message-ID: <20160108131358.GO6588@sirena.org.uk>
References: <1452237082-12767-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3632394404913570483=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F340926040E
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 14:14:06 +0100 (CET)
In-Reply-To: <1452237082-12767-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3632394404913570483==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2wyf/X6i9kneRjiV"
Content-Disposition: inline


--2wyf/X6i9kneRjiV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 08, 2016 at 03:11:22PM +0800, John Hsu wrote:
> 1. Enhance codec suspend and resume sequence
> 2. Add interrupt wakeup function

If this is two or more separate changes you should be sending two or
more separate patches.  You also need a better changelog which describes
what the patch is supposed to do, in what way is suspend and resume
enhanced for example?

> +/**
> + * nau8825_init_wakeup - set wakeup capability for codec
> + *
> + * @codec:  codec device component
> + *
> + * After this function done, codec can support system wakeup by button.
> + */
> +int nau8825_init_wakeup(struct snd_soc_codec *codec)
> +{
> +	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);
> +
> +	device_init_wakeup(nau8825->dev, true);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nau8825_init_wakeup);

You need a bit more explanation as to what's going on here.  Why is this
not something the driver just does or if this should be done elsewhere
why do we need the wrapper function?

> +int nau8825_irq_wakeup(struct snd_soc_codec *codec, int on)
> +{
> +	struct nau8825 *nau8825 = snd_soc_codec_get_drvdata(codec);

Same thing here, this looks like an unclear interface.

--2wyf/X6i9kneRjiV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWj7YWAAoJECTWi3JdVIfQD+QH/RiRU1bx7d1zIiBFFnGPb7Zw
qgXNoLcm8ayLNU6v7HO00M7ZeZqI1Qzl4Qy11cByqet6ea5mJZf4LCDhCiV8NvbR
0W78/+POLwMj/PcqtXSWh6gJioaKG3P8QbgkJK+Snnhtvh7bPafn4CvHReuslv0D
hAuhXq7HBBnhylONKwb1Kj/AKzXMXYGHvJ+HjpJwQx6kk9iIeb+YhV/I6LjzScAb
vbVBIsEL2rHG01ZZMjIoXPQIcjaNYrzctVNbcHL04nFD2uE3M4DEZEkWPjswTSKT
3vBj97KWgYDl1KpIYobdBc40Z/qHLuVyDJ6rbONATt3qRCX5nu6QF3aBRAQyEEA=
=ipjV
-----END PGP SIGNATURE-----

--2wyf/X6i9kneRjiV--

--===============3632394404913570483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3632394404913570483==--
