From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: AMD: Configure master codec on all
 playback/capture cases
Date: Mon, 18 Feb 2019 18:18:07 +0000
Message-ID: <20190218181807.GF10794@sirena.org.uk>
References: <20190215070539.22150-1-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0924895843208103488=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 921B626552B
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 19:18:14 +0100 (CET)
In-Reply-To: <20190215070539.22150-1-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Adam.Thomson.Opensource@diasemi.com" <Adam.Thomson.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============0924895843208103488==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kR3zbvD4cgoYnS/6"
Content-Disposition: inline


--kR3zbvD4cgoYnS/6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 15, 2019 at 07:06:15AM +0000, Agrawal, Akshu wrote:

> +static static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
> +				    struct snd_pcm_hw_params *params)
> +{
> +	/* da7219 Codec is clock master so setup as per the needs */
> +	if (codec_dai->driver->ops->hw_params)
> +		return codec_dai->driver->ops->hw_params(substream, params,
> +							 codec_dai);
> +	return 0;
> +}

No, this is a bad idea - you shouldn't be callings ops in drivers
outside of the framework, something is going to break on you there.
Either the drivers or the frameworks are going to get surprised by
things getting called out of sequence, for example I'd not rely on the
fact that the CODEC would be outputing a clock without active audio.
This probably means that you're going to have to extend the framework in
some way, or refactor things so that the BCLK is exported as a clock by
the CODEC and reflect the relationships via the clock API.  I need to
think a bit more but I think the clock API is going to be the the best
solution.

I also suspect that some work is needed to propagate constraints between
the various DAIs in the system.

--kR3zbvD4cgoYnS/6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxq9t4ACgkQJNaLcl1U
h9BFpgf/d/DJQCKtnkQnbzLnFB65/rVz3sTtB69+bGTGwzdpqr9iZuEr/gtbYrlW
qf/h52giMIYtcplragEM1s2N8Ap/t5sfQyPcJKBAQvYTJGcXUVKR5nGYtwkOPK5N
/eKAHfL5Ix0aBdjgR59M0quTBCDENSrAEewlJeSKuXgfuH6JRYUj3BqEr3fVvhWT
2uoimEod8420/rwtZQCHE5TnhrLBFJ+vc58Zr80tQZ0JyGcT4CkhJU7T6YR8S27R
dMQmfV6/Up0XrbmQeTGfm1LAMuzAlY1cyYYSwvZv5Qt9UhYMWFLa7KgQwqCbnd0q
hlNU57dMwHC9rn3KAziHEhZgTpnLCQ==
=LO88
-----END PGP SIGNATURE-----

--kR3zbvD4cgoYnS/6--

--===============0924895843208103488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0924895843208103488==--
