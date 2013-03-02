From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-core: use
	snd_soc_register_dais() on codec
Date: Sat, 2 Mar 2013 11:51:36 +0800
Message-ID: <20130302035134.GF6610@opensource.wolfsonmicro.com>
References: <87bob8g517.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0303347406702092323=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9EBC3260799
 for <alsa-devel@alsa-project.org>; Sat,  2 Mar 2013 04:52:03 +0100 (CET)
In-Reply-To: <87bob8g517.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0303347406702092323==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H4SyuGOnfnj3aJqJ"
Content-Disposition: inline


--H4SyuGOnfnj3aJqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 25, 2013 at 12:40:40AM -0800, Kuninori Morimoto wrote:
> snd_soc_register_dais() considers dai counts inside.
> snd_soc_register_codec() does not need to care for it.

Applied, thanks.

--H4SyuGOnfnj3aJqJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRMXc+AAoJELSic+t+oim9iBgP/AwShsuqtq5NlayH0+XaFGVP
r+AkAmAfowWc1yVFqG6enWnlb35V3osVila6srrqJO/6r31FlwKuOo/yeYmZAhoz
GRQ4oDaw/eCSSdCD4/0zAG5f0idlmqefpx3RTUGpLBFJU9vVKfIZLhbz2rx0aPOB
UvQMwJJlYmLW+A+HvZ0w613yRR1UnJVl0VridEsbowwAMrbrmDJ5CRMlAGyPotoi
51Vsiv5QuYa0YK7X/9qqn5LNpiABFUaN2re/yF+gcuHFqt6KGodvh5R4/nusn2I7
7RtCseqRPTU2fCcf61SHmz9JFmIlv4qtxiLSHZumMq/i8BLAZVDezWc8NaS1H5rp
u0c8GReMWGvx+948BccZvZgNH1E/DxJzZWpvAKuf/EZxktYIv7OEnX+P9mAtDeoD
9PF39v2toQV7IQU2w3WfmW0t/E/51smHVLXU/HjPYLN1fcrVokHeRSZNjScpv95o
NwmeYurybSMZzngP4gtZHZ50nlNZC+Zu0A3TC4Ot3vN0mZJbS8x5bgebFFfOcA1b
pBkbDwD9JkjnaS1mIT9p4GL7zHh/oxpJFSMBalswwVwGfmeGGN9ly5LeSR1C120/
1qW3lyWeSzr6jZanFcCKdqMnEGPY/dLdfHHvCfJ2Xd/vgcDtaCSzCGw0D4hhFvOs
oFcTerb061aSrl3+nx+S
=2aux
-----END PGP SIGNATURE-----

--H4SyuGOnfnj3aJqJ--

--===============0303347406702092323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0303347406702092323==--
