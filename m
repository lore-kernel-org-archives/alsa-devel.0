From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: add
	snd_soc_card_disconnect_sync()
Date: Wed, 11 Oct 2017 09:42:52 +0100
Message-ID: <20171011084252.awkhvhpuubj4gdvy@sirena.co.uk>
References: <87fuaqp5e7.wl%kuninori.morimoto.gx@renesas.com>
 <87bmlep58s.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7787546576549587446=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AB23A26735C
 for <alsa-devel@alsa-project.org>; Wed, 11 Oct 2017 10:42:57 +0200 (CEST)
In-Reply-To: <87bmlep58s.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--===============7787546576549587446==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nd3o53hwelc53emf"
Content-Disposition: inline


--nd3o53hwelc53emf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 11, 2017 at 06:37:06AM +0000, Kuninori Morimoto wrote:

> +void snd_soc_card_disconnect_sync(struct device *dev)
> +{
> +	struct snd_soc_component *component = snd_soc_lookup_component(dev, NULL);
> +
> +	if (!component || !component->card)
> +		return;
> +
> +	snd_card_disconnect_sync(component->card->snd_card);

Is this the right name for ASoC or should it just be
snd_soc_disconnect_sync()?  It'll work for any device that's in a card.

--nd3o53hwelc53emf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnd2YwACgkQJNaLcl1U
h9AYwgf+Je5PxnG8qvEs0gUW2HgjOyvj29Am638vrfgtECkuNQJv/anXgqI4WBWx
5LVVEciCIlfAy/C67OfWlK2NPpEH11Kq9x62fMe93m8L0bXwtl75sWqSZZE8Xk01
1tOTd4iI9qLe0r5wuNqIctoC6ADz584DlnCtiympx5mGoSS6d7kBlOMcru9cuP2P
43+wgenKrYmylKJ7J/Ek/E4OD81yH9toGJIqk6Wlr2lXeZFJuRXDvBm1Ub2YYXpD
+103QXCs8bYqn7qvkHsk9WVPLrJz4Af/CQAhdBBUgnek21EcmkR3/esgbeSpZC2+
4gPb23jQhF5PMIHH4iqEqg0isB/bww==
=+k6x
-----END PGP SIGNATURE-----

--nd3o53hwelc53emf--

--===============7787546576549587446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7787546576549587446==--
