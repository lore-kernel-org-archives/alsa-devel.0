From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: ics43432: Add codec driver for
 InvenSense ICS-43432 (fwd)
Date: Tue, 25 Aug 2015 18:49:33 +0100
Message-ID: <20150825174933.GI12878@sirena.org.uk>
References: <alpine.DEB.2.02.1508241357410.16666@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0233051859856002678=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 02404265152
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 19:49:39 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1508241357410.16666@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0233051859856002678==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tSiBuZsJmMXpnp7T"
Content-Disposition: inline


--tSiBuZsJmMXpnp7T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 24, 2015 at 02:03:14PM +0200, Ricard Wanderlof wrote:

> +static int ics43432_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_NB_NF:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

I've asked you several times to implement format checking in the core if
you think it's useful to add :(

--tSiBuZsJmMXpnp7T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3KqsAAoJECTWi3JdVIfQ/XIH+QG3MHu+qh8chqKQSQba7LKk
ubZXATz+UG4jvF79v+pKKwq8txd/cNAsK3GbnGdkNmdDwbHShySxV+uKM1Xu9LJX
59VNUutcIV5NmbJ28X5Z6RJXOfI+n+W1tmPQQ5FXi4X1qOXlbo/J79NTWMxSjKFu
XlB1Q76F22Uwfl8oQaRIOQyzcWuA5wTfFd3P2hyePk0sFGyLfrOnSn/2sBUOb4Ki
RPYnQxHoyPpCx8WxP9wL0Pz/rDqpvq75VrL8w0kfjR7nWP82DJhTna/H7YTj2dCm
c2EbdqYoU4soqeKYamKs1BytuinZshBgrev8R30NXIpKb08OJ7XsZPtNhl1x8GY=
=yBbV
-----END PGP SIGNATURE-----

--tSiBuZsJmMXpnp7T--

--===============0233051859856002678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0233051859856002678==--
