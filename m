From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/19] ASoC: fsi: tidyup: fsi_stream_xx()
 functions were gathered
Date: Fri, 3 Feb 2012 11:42:03 +0000
Message-ID: <20120203114202.GE3151@opensource.wolfsonmicro.com>
References: <871uqcjo9i.wl%kuninori.morimoto.gx@renesas.com>
	<87y5ski9m0.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4253871763636895831=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0977E2435C
	for <alsa-devel@alsa-project.org>; Fri,  3 Feb 2012 12:42:20 +0100 (CET)
In-Reply-To: <87y5ski9m0.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--===============4253871763636895831==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mR8QP4gmHujQHb1c"
Content-Disposition: inline


--mR8QP4gmHujQHb1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 03, 2012 at 12:50:35AM -0800, Kuninori Morimoto wrote:

> +/*
> + *		fsi_stream_xx() function
> + */
> +#define fsi_is_play(substream)	fsi_stream_is_play(substream->stream)
> +static inline int fsi_stream_is_play(int stream)
> +{
> +	return stream == SNDRV_PCM_STREAM_PLAYBACK;
> +}

That #define should be an inline function.  I'll apply this but please
fix this incrementally.

--mR8QP4gmHujQHb1c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPK8f/AAoJEBus8iNuMP3d8D8P/2AbpnkLKtY4MLMHDHmFfdh8
SpAX7N1dcPz8YDnD/cd/2Y/2XG8m5O7AE9Dm2ofXOfg6humtm/WBGGacB/k8f6cs
K1XgiUCEgIUPek2v/gfG4k9AYTKJ0MInpHKMtwHWG3I/2mAAqQ7L/W5Hy0E8u/TE
hfsCpr8pTQPQxzV1YpxsrQH1JeuQpfrefN4dceHGOBJKMZ0ciOp9TaPiR42Q+XDz
QljlFmKTRBYBG426a0gS1eZwkAXKzfFzN4t/mXcHUamg+RXk7JeroR+FF43srYLK
CZtiWiGtCFwMWI4vZDiGNa3P2910O+iTHe7m0Pa7/einWVKbbngIz+LGbbektjED
swBnS08Sb2uAjECTE45/lVdkt208a9betsVhVhsZTMapVWKfvS613KNo7KNhxC57
ILr5RTQET1J+IbnYabN8ApangOTCWmWo2dsTj4r0LkC1D7UbCATOy83B/FPLOehH
rukkutWK0TTVeZeDPbjixD3YkeXWfAQkeM3C7OeAu/pJrxj9Q5KZ2rO8iR2MM2Yz
AyymLUNBjPvlFGYY/QMuMh4o2aOJTQcZhHI3VUHIyS7MPBBQ/oZeLviG+guug8ta
W9jbcxe/aMATDWdWyfSk0MZ6i04AUfj+OngsqGS6RggRh+uWdQ+x9WQDpnovO04a
yqBWWvxgKZ8qFo7TpnNl
=rQWN
-----END PGP SIGNATURE-----

--mR8QP4gmHujQHb1c--

--===============4253871763636895831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4253871763636895831==--
