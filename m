From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: davinci-mcasp: Optimize
 pm_runtime usage and clean up the init code
Date: Tue, 22 Apr 2014 12:47:12 +0100
Message-ID: <20140422114712.GO12304@sirena.org.uk>
References: <1398164594-29169-1-git-send-email-peter.ujfalusi@ti.com>
 <1398164594-29169-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5599399080864606566=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 759F9261A9F
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 13:47:29 +0200 (CEST)
In-Reply-To: <1398164594-29169-4-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: daniel@zonque.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============5599399080864606566==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v8Zo618bouc0601L"
Content-Disposition: inline


--v8Zo618bouc0601L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2014 at 02:03:14PM +0300, Peter Ujfalusi wrote:
> Move the pm_runtime_enable/disable to dai driver probe/remove callbacks from
> module probe/remove callbacks.
> With this change we can remove the platform driver's remove function since
> it became NULL.

This does mean that if the device gets enumerated but isn't used in the
system it won't go to runtime idle since the DAI level probe is only
called when we're building a card.  That doesn't seem like it's a win.
How about creating a devm_pm_runtime_enable() instead?

--v8Zo618bouc0601L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVla9AAoJELSic+t+oim99OUP/1LXysbxKu+JqsfPlnVWmc0y
nQ0zWtbOr1X8hY+7yGzW1hng5k0jOkvdDaO3N+a8TBItc3CFBvhY97Hw4p8E2osn
a8BNnAksCq4ktrWBSvWyPkGC0dRifLOULAflJ5asPi8d9PRXbb0vZhd9MY54POwW
Z/l0jk9hqRT5H4Qvid/S7UM5BG0pzNCmM8cnX2c5v5cLyce7PyDF66I6S44XkwEV
tH5D0xrWMUfCHc183fiFWKjqlw/MmbQHM71cJWzKGr/ggkZAJANvS6qg/5zEyHIL
MnXoAtWFO2IdNs08XX4IWqOiJdXibD03dQbADLfyL4Kn4B6woRUGwgu8hxSKxjWS
D9n9Fm0nzpxQ6E2cHe+El5BDNf0Ut+3vrUfCQyPO+uaBY5LQG0SmmOPpcm+V99xy
moSq29/C2TuDhbbmdi2Spxhj44ET538glbQ4QrmUGDdptoOyJZEj5/yb8tYJZNU+
evxtTg14VVIQ4um0/VZdZ/YhWSqUxvR2/W8GFnHIVNn1pBuOPfGzIBoSsZ0DhLb4
0tontcBLmjU+uHD8g1NaMnPQXT1M0ZunfoFpayAEBuI/VGyzMGvw7DBMhcGtXPXx
Ggx4gPp27meiD0Mam1FMY6RA2PrIUJ0bin2lDELdhvG0TO7Ru9W91TzHlzhUE20c
oNacfIRj6KsfD6+/Ycu9
=Bb8u
-----END PGP SIGNATURE-----

--v8Zo618bouc0601L--

--===============5599399080864606566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5599399080864606566==--
