From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: add headset detection
	function
Date: Tue, 23 Jul 2013 14:00:16 +0100
Message-ID: <20130723130016.GA9858@sirena.org.uk>
References: <1374562469-5190-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1674459070736564055=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E6FED265041
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 15:00:19 +0200 (CEST)
In-Reply-To: <1374562469-5190-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1674459070736564055==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SwLo357mIESq0V3a"
Content-Disposition: inline


--SwLo357mIESq0V3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2013 at 02:54:29PM +0800, bardliao@realtek.com wrote:

> + * @codec: SoC audio codec device.
> + * @jack_insert: Jack insert or not.
> + *
> + * Detect whether is headset or not when jack inserted.
> + *
> + * Returns detect status.
> + */
> +int rt5640_headset_detect(struct snd_soc_codec *codec,
> +				struct snd_soc_jack *jack, int jack_insert)

This doesn't look like it implements jack detection, it looks like it's
some sort of callback.  I'd expect to see some sort of interrupt for
example...

What's going on here?

--SwLo357mIESq0V3a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7n5dAAoJELSic+t+oim9TUoP/1KeHa9QLrVSgqnna2YLPMaM
UJ2m7F75zlpToW51D9gB5sVlKoarfe1VeHF4xvNoe6yGIQBry+cmpIhWAYX+GZBr
lACleaabHwXFA0qxmXAA5nR73TuTWGORFIjRdXecufkMVWMpqJc86H+ffgvfN1Zc
oYx5+BnmUup6HbYPGilkzAElgdrwXJ86s68IzYxtjcy2iydaQrL9LAr/EDYC8xky
5NceEW++HUTy4ko8dAuyzhDWx5AwSx8vtyqtM2INvYQoX0xofWe/xAylc9uyfOa4
IIe+QCR3haq4zwdSIeREIt9P/8o4OsbtYrYZavdeevMqN7U1fLMnxYPkrTHF74wK
qM6LUmb4vjlnaNa7X8O8DM1an529MWtVPUipQUJBxbdVc25ynlkDtBIyCuZK8fyR
vTUSLhKv7WksyJFWAizDHH7uOjTPwJ+cLIMDQXMDuU3CFgOFvNfcE+3/gTPLklOc
TOb8FySV5Ajp971Ld2OD7NhStoY0lR4srleH+1kYOly48eF33k/YNg909V/WvFq9
nn4fUnrSkJsV6MtYVLKUwaN1QXCuiznuADihx+4UdvSpPjrHQALhWd8DTtexh3rI
HTIz4KtiscS4+1xZESYUbbYoJQGKX9BANJjOPUVzvywz8HzylqiIC8xKvfcMaLYY
vRiHOe+OvBvQ9zJKdAAe
=OCV1
-----END PGP SIGNATURE-----

--SwLo357mIESq0V3a--

--===============1674459070736564055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1674459070736564055==--
