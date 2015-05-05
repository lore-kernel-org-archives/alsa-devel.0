From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v11 3/3] ASoC: tda998x: add a codec to the
 HDMI transmitter
Date: Tue, 5 May 2015 23:40:51 +0100
Message-ID: <20150505224051.GN15510@sirena.org.uk>
References: <cover.1430320384.git.moinejf@free.fr>
 <7fcabac9f60497d80a571b1d3108e454084b95cb.1430320384.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6151523594749515327=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 07BEC2604A7
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 00:41:16 +0200 (CEST)
In-Reply-To: <7fcabac9f60497d80a571b1d3108e454084b95cb.1430320384.git.moinejf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Andrew Jackson <Andrew.Jackson@arm.com>, linux-kernel@vger.kernel.org, Jyri Sarha <jsarha@ti.com>, Dave Airlie <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6151523594749515327==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/XHXXBvNKG2ATP64"
Content-Disposition: inline


--/XHXXBvNKG2ATP64
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 29, 2015 at 12:53:53PM +0200, Jean-Francois Moine wrote:

> +/* get the audio capabilities from the EDID */
> +static void tda998x_get_audio_caps(struct tda998x_priv *priv,
> +				struct drm_connector *connector)
> +{

Russell created some generic EDID handling code (sound/core: add DRM ELD
helper), if at all possible I'd really like to get those patches merged
and use them rather than have custom code.  If they're not suitable then
let's understand why.

--/XHXXBvNKG2ATP64
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVSUbvAAoJELSic+t+oim9S5UQAJgJMkiOm2U0scB9CSwMekSF
n9O37aBh165kGSG8hORa265T0jhu0kXyL/380QnlK5FV2R2qJ3QvXQWLLIkqg6Dw
zD2Fq4bgtBW6u9e3mviu3wX7BF4XZ+npvnhdMKx30SGJHQF0dn2tqhDTkSmQuwFx
erDqj7+aqrWJlDA326jot3uuRdXgwwChRJnKAa4pu1sEL4yWLzfRHp+qolkRwLGg
ZiINJUGXqgWtjQLsf1kPUATiJgEMQe4pqE88AaRmyytBxTHBNSsL+N4b4mQ0j6YU
7UOwLQi1VQj6orC2yRRnGLA9YBoGELxX8EI/D48xxOyFmPdeBtWic59zy3kDGUJe
1nJvS3mwqbv9MOOwnIfAd2jXnsP1hISFha3wyrai6AsiRBe8yCIGETOxXZiZ3T+R
66c+2I+nS2E6fp2m8yLmvWF9v3Cqf8IYjJ/YcxgjUORHT8UtwyQOyMB4EAqobf+q
Y7tD7blgd0HgFa1ef+Ujtw9iexn6I2tOZ8JEK5aIC3rfxyHyR0jqEF33Ce5odQ9b
vLH5FCE0iFD2ukd1XPDBQKf9i7NyJo0kQt5PGF7p9gJQyL8+JyUy8aOmJB4zXJlA
vqaXs/6csDkcahRvyiZxp0b7AAVxZke2r+uwN8uWOEGM4a3NqQ2V8DfADkZr7AZd
n35+/MRJQJzgTjz0Xu1f
=6EMF
-----END PGP SIGNATURE-----

--/XHXXBvNKG2ATP64--

--===============6151523594749515327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6151523594749515327==--
