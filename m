From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5 v4] ASoC: soc-core: call
 snd_soc_remove_card() when component del
Date: Sun, 22 Mar 2015 18:43:22 +0000
Message-ID: <20150322184322.GE6643@sirena.org.uk>
References: <874mqq5slj.wl%kuninori.morimoto.gx@renesas.com>
 <87y4o24dyq.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7521146022952622069=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BF58265041
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 06:01:34 +0100 (CET)
In-Reply-To: <87y4o24dyq.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7521146022952622069==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/T5/D81aE6hAEKcd"
Content-Disposition: inline


--/T5/D81aE6hAEKcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 13, 2015 at 04:43:53AM +0000, Kuninori Morimoto wrote:

> +	struct list_head unbinded_list;

This should be "unbound".  However the whole idea of having this list
seems to be a bit problematic - it's moving us back to the old mechanism
we used to have where we open coded deferred probe.  What would be
better would be if we could force the driver to unbind so we go back to
the state we were in prior to the card being instantiated.  I had a
brief look and it looks like device_release_driver() might be what's
needed but it's unclear to me if this will do exactly what we want and
cause the device to try to rebind.  We probably need to ask Greg unless
there's an obvious answer I'm missing right now.

--/T5/D81aE6hAEKcd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDw1JAAoJECTWi3JdVIfQ6O0H/09rsGg8kbvUI/B4+O5Vk5QY
NEBHOBIyHDwYOZ/KBtwSj+7phurHddPiW65H6XDN5H9QBeTGbi1QsSzTL7+J0BzU
0yNbYjycOexlHu8OPhAbbdJWVDm6BspT8TkEskwAkj9UkOgveoTUAZGwVM0LdWbF
ypI5+v7z+qslBg/2FDdFuoBu2CN9NrvvgGW7GrJKs4NdXxpX/DPGbsmBF+yF6bGq
SOnqSgM/TvN+hcrZOpQOW7YUTiOL2wSIXrPI85sDbjH/ttHgC7Jn2PHgg32FoyGY
n8JhtdteVdrvGvD7jsoavb9A3PrPZBO2y6xRCnTQgSs8lCzu2DkeYYMzJhSsGi8=
=Gyhd
-----END PGP SIGNATURE-----

--/T5/D81aE6hAEKcd--

--===============7521146022952622069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7521146022952622069==--
