From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] ASoC: add RT286 CODEC driver
Date: Thu, 13 Mar 2014 19:29:02 +0000
Message-ID: <20140313192902.GL366@sirena.org.uk>
References: <1394521896-27721-1-git-send-email-bardliao@realtek.com>
 <5320CE8C.8090608@metafoo.de>
 <ABFD875FF5FB574BA706497D987D48D7398652@RTITMBSV03.realtek.com.tw>
 <53216DDC.9090502@metafoo.de> <s5h61nizdj5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2776620615885615258=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D481C26545F
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 20:29:12 +0100 (CET)
In-Reply-To: <s5h61nizdj5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============2776620615885615258==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ISA6zNVXmTIvvkD5"
Content-Disposition: inline


--ISA6zNVXmTIvvkD5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 13, 2014 at 09:52:14AM +0100, Takashi Iwai wrote:

> different values for get and set.  And, yet more tricky part is the
> amplifier verbs.  These aren't suitable with regmap caching,
> unfortunately.

We don't really *need* the cache, it just makes it easier to do resume
and gives a bit of a performance boost.

--ISA6zNVXmTIvvkD5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIgb7AAoJELSic+t+oim9Ma0P/2riFtxva3EpiR4Vr3y+APx3
28WbDRHXqNuvw1/pCfDx1GM3I0W5FEiO7zz4+yr8MqPJmyZD3a2Mheg96V0RPYxb
gmpCgR3urmLgVsTgwN533HjmFHRGI9JDSYyFXg+PVKzFyewrbxqJk7X0IrlK1Eq9
DH9x35t/N85cm1EEGHedNO0/nw4pFMSu0IcWZrGRGVOfdMHACa7Jlup+0NR5P70w
d7z0g1vUtK+37tyMghetOHnxyKYp32dYxvsL4i62SPVrntPlE1RJ6MCOhVELV3c5
S7p+q2jNNYSDOGnnuFoSxzJrJGIMpROHrfOwkbFap/z07xScm6kdkR1yNQliQ8hK
mx9poq34xkrGs9/MZE2loGJpDrt/wk9qBRBzNg7nhviAURfzoYMFvsefnWu6ze92
fvZ0nL8Q+sQ0w+GYFDbOG7cni/KV+WqHWGHp4eOytS8HKA7x+qJ85NLkF+pau5+m
r7KYSLBcptIweZe9tgt++7I468ZagrDaMLKoq7rQ+SkvM1hRoVrI5NisEBGlk9mY
4sYkIlv3/RDWprw0b8d/shraEb6zvxOSAROnm5bgr1ZSaKQ0gQXpPZBMkjKOToio
8YUVMHJ+7hgUpiYg8SPj/ZSLBVfRbEaMQmCPIuXFgGmKKl2hvNycrg3d6wkksrsj
QAWbwkLQp+TgTl/RM3Rl
=xe8H
-----END PGP SIGNATURE-----

--ISA6zNVXmTIvvkD5--

--===============2776620615885615258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2776620615885615258==--
