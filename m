From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5 v4] ASoC: soc-core: deactivate pins in
 snd_soc_instantiate_card()
Date: Sun, 22 Mar 2015 18:31:28 +0000
Message-ID: <20150322183128.GC6643@sirena.org.uk>
References: <874mqq5slj.wl%kuninori.morimoto.gx@renesas.com>
 <871tlu5sjx.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7377425051609246499=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 10EA326044F
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 05:59:07 +0100 (CET)
In-Reply-To: <871tlu5sjx.wl%kuninori.morimoto.gx@renesas.com>
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


--===============7377425051609246499==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mjeOt6n4R71vn6wN"
Content-Disposition: inline


--mjeOt6n4R71vn6wN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 13, 2015 at 04:43:27AM +0000, Kuninori Morimoto wrote:

> snd_soc_instantiate_card() is the final method of snd_soc_register_card().
> Deactivate pins to sleep state is related to snd_soc_instantiate_card(),
> not snd_soc_register_card()

I'm not quite sure I understand why this is being done.  There doesn't
seem to be any reason to defer initialization of resources owned by a
device until the card is finally instantiated, doing this as early as
possible means that we're in the state we want to be even if we're still
waiting for some other component of the card to appear and register
itself (which may never happen of course) so the hardware is in the
state we want for longer.  I may be missing something here though.

--mjeOt6n4R71vn6wN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDwp/AAoJECTWi3JdVIfQWG8H/A/7j1ksBxkIhRpNxSXFXe9E
Lol0ZvClXHBxkR2aQs5hlEAN2kUwzzKQ2m0hw4C0C8VbVjgYunCfVaxp0QFn3JC/
lw0199Gt4OWVdjmXF5CSs+d1TdOGiWp5oPoiMXtjJpXbGUtnR0Kkwg8ksiDihDSG
FSjWFLVQE1/P6LMbW9W8DpKMD8KjNHPx0YnTyd2WKDxtpcDHFy0kM//vzMR+mm2J
/4zgMik+Y/9ds1iVxiG3D3XDJeFDQo91r+8qdCZFwwHn5suuCidT2aBUoD7mRKuV
nov3cDOzmaJTX7D67NUsFIuS7cp+FBrqmdj7NQSZTrlR0Sy7OKXlZV2ZYSi/yY4=
=uC49
-----END PGP SIGNATURE-----

--mjeOt6n4R71vn6wN--

--===============7377425051609246499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7377425051609246499==--
