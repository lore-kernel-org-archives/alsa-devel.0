From: Mark Brown <broonie@kernel.org>
Subject: Re: About ASoC DAIs cleanup
Date: Thu, 21 Dec 2017 11:25:44 +0000
Message-ID: <20171221112544.GE6754@sirena.org.uk>
References: <87o9n6ukyg.wl%kuninori.morimoto.gx@renesas.com>
 <87r2rzqf1q.wl%kuninori.morimoto.gx@renesas.com>
 <20171213155952.GL6416@sirena.org.uk>
 <87wp1qow1q.wl%kuninori.morimoto.gx@renesas.com>
 <20171214050648.GU18649@localhost>
 <20171214113718.GB9788@sirena.org.uk>
 <20171215042053.GA18649@localhost>
 <87mv2grdqm.wl%kuninori.morimoto.gx@renesas.com>
 <20171219112302.GI8563@sirena.org.uk>
 <87o9msc1zk.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5561942885856924549=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CC21A266BBC
 for <alsa-devel@alsa-project.org>; Thu, 21 Dec 2017 12:25:49 +0100 (CET)
In-Reply-To: <87o9msc1zk.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter <lars@metafoo.de>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5561942885856924549==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
Content-Disposition: inline


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 21, 2017 at 01:28:09AM +0000, Kuninori Morimoto wrote:

> If my understanding was correct, we can call all DAIs
> by one for_each loop with controllable order on your idea.
> This is nice.
> But, callback order will be exchanged ?
> For example soc_pcm_trigger() case, .trigger callback order currently is

> 	Codec DAI -> Component(Platform) -> CPU DAI -> RTD

> it will be

> 	all ordered DAIs -> Component(Platform) -> RTD

> Codec / CPU callback order are OK, but DAI / Component order is exchanged.
> If this is not a big problem, we can do it.

Ah, yes - we'd need to mix in the platform :/

> And one issue I noticed.
> If we merged all Codec/CPU DAI into one DAI list, and without
> flags (like .peripheral flag), current DAI master/slave direction will be problem.

Yes, there's other things need to be fixed - I'm not saying it'd be a
simple transition.

> At least snd_soc_runtime_set_dai_fmt() is switching it for Codec <-> Codec case.
> If we can change current SND_SOC_DAIFMT_CBx_CFx style to
> xx_MASTER / xx_SLAVE style on each DAIs, this can be no problem I think.
> I guess Lars is thinking about it ?

It's been talked about for years but it's another of these things that's
a lot of work to transition.

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlo7mjgACgkQJNaLcl1U
h9DFiwf/WQczXO41zuqG5oD0DeAoGmd8MQol05X/CI+2uIMMSxDqrhhUJZs6x7jn
2J+5L7pfsLPfOok3wZ/I2qujECakF4A62UNsUuD2pP8FOM40utlvkWWluiASaImN
vMtZx0rXTVnJuGMVrq0/sr4zoiGh+agyDDyXbjzHj3Ayh4r0ee77UND13WwD1w4c
CrpUwNGwIc3qzFIWELo1si9MMvbv/1YwJKhU+5rZ9LkCbJ3q8E6jCby5BqLRZ/1v
IYw4Y1l/sEcDkze+gUwzYKIVF/nqHhj+IMYzEFHohjwLb+u9DV44vQuSHZNm/QU4
QJIAsPRUd8Qc8F9TGhH+hbbAcqBS7A==
=4EpR
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--

--===============5561942885856924549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5561942885856924549==--
