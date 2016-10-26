From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: rt286: rt286_mic_detect() uses
 component
Date: Wed, 26 Oct 2016 13:12:08 +0100
Message-ID: <20161026121208.GA25322@sirena.org.uk>
References: <87eg3a2v32.wl%kuninori.morimoto.gx@renesas.com>
 <87d1iu2v1j.wl%kuninori.morimoto.gx@renesas.com>
 <s5hshrmnsj2.wl-tiwai@suse.de>
 <e615912f-f6e7-a696-31f2-009c927838ec@metafoo.de>
 <87insi2obs.wl%kuninori.morimoto.gx@renesas.com>
 <5a1187a2-521a-0cd7-856a-ffdc69a045ed@metafoo.de>
 <20161026035045.GB3000@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5223404597008581546=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 045DB2670CF
 for <alsa-devel@alsa-project.org>; Wed, 26 Oct 2016 14:12:27 +0200 (CEST)
In-Reply-To: <20161026035045.GB3000@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, Mengdong Lin <mengdong.lin@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jin Yao <yao.jin@linux.intel.co>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============5223404597008581546==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 26, 2016 at 09:20:45AM +0530, Vinod Koul wrote:

> into rtd internals. So would make sense to combine two suggestion and add an
> API:

> struct snd_soc_codec *snd_soc_get_codec(struct snd_soc_pcm_runtime *rtd)
> {
> 	return rtd->codec;
> }

> then we can use this is drivers.

That interface does bake in the CPU/CODEC distinction which is something
we want to get away from with componentization since it makes things
more complicated with situations like CODEC<->CODEC links.  OTOH we're
looking up a CODEC rather than a component here so it's going to need to
change again anyway so it probably doesn't matter.

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYEJ2WAAoJECTWi3JdVIfQGBIH/17tHavCqG9F/B/CHRxSadhs
+cpnk5GN6nzICO4ATGj2bVBrcZndR2L/gwiyla18km+NmJONTUC2DpMXmfQSR/fQ
/KaaYqArbmJJJtJFsp/clNfUiKhmj5+duhkT4WDvP7JoN9+fGU+saG29+Jy5WrJt
pLLG/+8eiMkPL0KeUjJBMxu6hrzKQZOXRGr5dzQdfrM9Yr97AfIH7aP/da8aRr6A
Ai01e6fiFUVmEqpk+1oAnzVCxC/6spd6CNeHG0UBl4X5fcVAhtdNh6yi2plVQkmM
XJ1KBPoOb60jaKzr6i+XIOsnd6a8x7TTDhrss5WArqMm/RZ7u2JIDjT3hL5N/3s=
=25Qy
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--

--===============5223404597008581546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5223404597008581546==--
