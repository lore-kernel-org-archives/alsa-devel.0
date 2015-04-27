From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: Add helper function getting
 CODEC's DAPM context
Date: Mon, 27 Apr 2015 21:34:58 +0100
Message-ID: <20150427203458.GK22845@sirena.org.uk>
References: <1430165606-3072-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1643756318076393865=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B0F972605DC
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2015 22:35:13 +0200 (CEST)
In-Reply-To: <1430165606-3072-1-git-send-email-lars@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Brian Austin <brian.austin@cirrus.com>, Support Opensource <support.opensource@diasemi.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============1643756318076393865==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZjZ6I2acE6nwxqUq"
Content-Disposition: inline


--ZjZ6I2acE6nwxqUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 27, 2015 at 10:13:22PM +0200, Lars-Peter Clausen wrote:
> The DAPM context in the snd_soc_codec struct is redundant and scheduled to
> be replaced by the DAPM context in the snd_soc_component struct. This patch
> introduces a new helper function snd_soc_codec_get_dapm() which should be

Applied all, thanks.

--ZjZ6I2acE6nwxqUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVPp1xAAoJECTWi3JdVIfQdFMH/1uM61PPjoESJGOHQ3MlDU7N
ihksz2YPf2e2DuaJac0B9MhqOa0nMlN3KAff79SO/TstCaitmRHrkOUNIb9n0DnB
KA5uZE9VPU3jlLbpuE+7ky/VsRAM6otqeQ64asHizfGZP0nfy8DV3Zc6i4QF1B+8
+R6DPdPyK4hOdqyEHB0haGaglJ184X1QU+LmP7cUku+WP+YS4+DJwjC1l4wStHTP
BdDWlZHDgTYIIgE9Jhjv0+Zt8hxboC2Rl9JU+nDK7HnQymBFCv2wOedAA0YAt1d0
sVoluJYsuQs7J6yTnDssSJg01/qEDuYdqgMwi4HgbPNsjCR4MvakkLU/6eVLjEM=
=YTTe
-----END PGP SIGNATURE-----

--ZjZ6I2acE6nwxqUq--

--===============1643756318076393865==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1643756318076393865==--
