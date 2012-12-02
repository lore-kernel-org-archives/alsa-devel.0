From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ALSA: ASoC: cs4271: add optional soft
 reset workaround
Date: Sun, 2 Dec 2012 13:02:01 +0900
Message-ID: <20121202040200.GI17981@opensource.wolfsonmicro.com>
References: <1354271337-15113-1-git-send-email-zonque@gmail.com>
 <1354271337-15113-3-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9012428865366802366=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 281DC264F06
 for <alsa-devel@alsa-project.org>; Sun,  2 Dec 2012 05:02:06 +0100 (CET)
In-Reply-To: <1354271337-15113-3-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============9012428865366802366==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/zg8ciPNcraoWb6"
Content-Disposition: inline


--J/zg8ciPNcraoWb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 30, 2012 at 11:28:57AM +0100, Daniel Mack wrote:

> +	Note that this is not needed in case the clocks are stable
> +	throughout the entire runtime of the codec.

That's really quite rare for embeded systems, though - normally at least
the LRCLK is going to be enabled only when there's audio. =20

> +static int cs4271_startup(struct snd_pcm_substream *subs,
> +			   struct snd_soc_dai *codec_dai)
> +{
> +	int ret;
> +	struct snd_soc_codec *codec =3D codec_dai->codec;
> +	struct cs4271_private *cs4271 =3D snd_soc_codec_get_drvdata(codec);
> +
> +	if (!cs4271->enable_soft_reset)
> +		return 0;
> +
> +	/*
> +	 * Put the codec in soft reset and back again in case it's not
> +	 * currently streaming data. This way of bringing the codec in
> +	 * sync to the current clocks is not explicitly documented in
> +	 * the data sheet, but it seems to work fine.
> +	 */

Since startup() is called before hw_params() you might well find even an
active LRCLK is going to change underneath the driver here...

--J/zg8ciPNcraoWb6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQutKgAAoJELSic+t+oim9dtEP/1JkbsVB2poVWFoSvqeN+TwI
IOt8MBFE7hOyU9A8QSIKt6Duk+345x8qhIMauHGeBMErcGkt1w/bXo8+reQKlZwO
8jV8eingU59ZbPbC8grHobDQlhTs/1GoZs4c8hAFptmSzBe9twYZzqgzKhfjyR9j
MsLGGPckoR6DA/ihxuNL8QMesN0Kr3Mh9bXZi7T8a74nAXeoBVjZ9nF6CSkwR06A
S4B4bkTLaSo1aFqDTUZJ6IohIU2IairIEU/wyugtVY1KRYKvhVWhh+WOMygO82id
jnDzfeTR01MTN7f1nTWuaRW+m6Uu5uU+xSnLBrpzGhcJQQJ0PFpHawLSIqCT2+y2
O+tIXTYmVk5hkaftoXphtuGedHIADhsm87jYbq5oxO37ofskMF/QlHk0u9yJ7q2d
J0nnzQ+khmjR7ZeCBWqSFVZYUQIhFmHg/qY/g/VrH0lD0bAqkRb4jKl/cwcXChCP
xffp+G7VfngkI8Kr8l9Tjkqc5UwWWtVKTUDK75hoblSaKA31jljtblQ7tjMFNc35
kOEx2l4SnLbVs8DL8eGpsOxcsvXbVqeu+Vm9sT1ciXJXGwhFLwWPiQnP+mjOLSUG
XMbGhnE9MMboABt8BoDuR4TMRIoPSh/mzBHVQJPmUFF6GAYu3zqjbYgEuCAg1GiK
Yzim7Mx8IKbw18/+vRUG
=82ky
-----END PGP SIGNATURE-----

--J/zg8ciPNcraoWb6--

--===============9012428865366802366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9012428865366802366==--
