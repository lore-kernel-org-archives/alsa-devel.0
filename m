From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 000/127] ASoC: codec cleanup - codec
 probe/remove
Date: Fri, 12 Aug 2016 11:22:12 +0100
Message-ID: <20160812102212.GA9347@sirena.org.uk>
References: <87popieek9.wl%kuninori.morimoto.gx@renesas.com>
 <54ffe6bb-9a97-db02-e96b-588630b08468@metafoo.de>
 <20160809112639.GJ10383@sirena.org.uk>
 <87a8glii9q.wl%kuninori.morimoto.gx@renesas.com>
 <20160810111748.GI9347@sirena.org.uk>
 <871t1wuntb.wl%kuninori.morimoto.gx@renesas.com>
 <5a3d865f-087f-eab2-82d8-0477c2ca1400@metafoo.de>
 <87wpjmrdgw.wl%kuninori.morimoto.gx@renesas.com>
 <c8b124b3-68fa-8dc3-37cb-451897822b66@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0679383049616165834=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 940CF26589D
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 12:22:23 +0200 (CEST)
In-Reply-To: <c8b124b3-68fa-8dc3-37cb-451897822b66@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============0679383049616165834==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p1zSJVlfBL7BTggM"
Content-Disposition: inline


--p1zSJVlfBL7BTggM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 12, 2016 at 11:33:13AM +0200, Lars-Peter Clausen wrote:

> snd_soc_read() and similar are part of a clear hierarchy and are not part of
> the current problem. Removing them is not a priority and changing them to
> snd_soc_component_read() should only be done where it makes sense (driver is
> a component driver and uses snd_soc_register_component()).

There is some argument for renaming them to snd_soc_codec_read() and so
on but it's really not worth the hassle and churn.

--p1zSJVlfBL7BTggM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXraNTAAoJECTWi3JdVIfQvuMH/1yxoRhttOHNYFsPEpsNTGhG
XfMWXWhmbRwEd1MmSP6HvqxP3b5ALe69dYMX1F6Wc30/nbuGPCS7FFhNGgM2R58O
QM8IFsy6klnrlFhT9iK3+SPpeNe/s9ffX5UDsqaT/ztZYmGa4qXNpHbfe9El7BZN
YkibYc9lJp4Qsfhn7cxvZThKkWvGunwByZ4H1D3q5IXoc07BAnRgmL79MO26ETDg
uIarwac5THnJY+Rqr9IXvlurngJAelBhodpI0PA/VF4G3Xi05yxpYA31v3jVtFLg
BksXhV8OgfAg7Jb0ExS7a1MZeL158oUWbxG9CbgUFYyj6lOnYOBFJvdrVBKP0LE=
=2Bin
-----END PGP SIGNATURE-----

--p1zSJVlfBL7BTggM--

--===============0679383049616165834==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0679383049616165834==--
