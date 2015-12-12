From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/4] ASoC: sun4i-codec: Add support for
	PA gpio pin
Date: Sat, 12 Dec 2015 23:01:50 +0000
Message-ID: <20151212230150.GH579@sirena.org.uk>
References: <1449859439-30875-1-git-send-email-hdegoede@redhat.com>
 <1449859439-30875-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6996200127805654556=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CB66C2606E5
 for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2015 00:02:06 +0100 (CET)
In-Reply-To: <1449859439-30875-2-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: devicetree <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6996200127805654556==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qM81t570OJUP5TU/"
Content-Disposition: inline


--qM81t570OJUP5TU/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 11, 2015 at 07:43:57PM +0100, Hans de Goede wrote:

> +		gpiod_set_value_cansleep(scodec->gpio_pa,
> +					 !!SND_SOC_DAPM_EVENT_ON(event));

Why the double negation here?  The macro is already supposed to give you
a boolean and gpiod_set_value_cansleep() ought to cope with a C logic
value.

--qM81t570OJUP5TU/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWbKddAAoJECTWi3JdVIfQjqcIAIEpNgkoC+YiGY9YxLZumdeK
A01wD1Ey4NxEVt/05ObIO/1R6qx+csBQ97l3yYfzisgBe0x7ta5sumnw8b1yYens
mRoUzz5V87TZZmHq+3E7/FKIC+lZL2u24HhsXcAHJfQYpWK3pS9i8Re5hOo+XRB/
6qTTTUZBcnQzqzO+PCuuoOxyiU/jhyO2BOVA4G4YYjb/z1rLPVaFSr9YimsfDAND
5VkJsIvH7y4ME0r0p97dC47nEL9bFdFHNkQQJU0gGAnuj0el1aMjfB4VNYUGzDZK
v9tzTbt/jaGoeXQVDr1O3yXXsh+VypgDoy/oqNF6mqqejPUc1dGR3VJvU35A2WM=
=3JU5
-----END PGP SIGNATURE-----

--qM81t570OJUP5TU/--

--===============6996200127805654556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6996200127805654556==--
