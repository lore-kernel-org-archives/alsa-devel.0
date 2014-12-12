From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: rt5677: add a platform config
 option for DACREF source
Date: Fri, 12 Dec 2014 13:34:57 +0000
Message-ID: <20141212133457.GL11764@sirena.org.uk>
References: <1418271327-14710-1-git-send-email-benzh@chromium.org>
 <1418271327-14710-3-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3425315750219590501=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F0C5A26069C
 for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2014 14:35:04 +0100 (CET)
In-Reply-To: <1418271327-14710-3-git-send-email-benzh@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Zhang <benzh@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Albert Chen <albertchen@realtek.com>, Anatol Pomozov <anatol@google.com>, Bard Liao <bardliao@realtek.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============3425315750219590501==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p0HNO2YbtFeVXwJ3"
Content-Disposition: inline


--p0HNO2YbtFeVXwJ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 10, 2014 at 08:15:27PM -0800, Ben Zhang wrote:
> DACREF power source can come from external 1.8V or codec internal 1.8V.
> This patch adds the option to enable the internal DACREF power source.

> +- realtek,internal-dacref-en
> +  Select codec internal 1.8V as DACREF source optionally.
> +

Why is this not done using the regulator API - don't we need to ensure
that the external DACREF is enabled if it's there?  I don't think we
need to model the internal reference as a regulator (we can just set
the registers up in that case) but if it's off device I'd expect to be
making sure that it's turned on.

--p0HNO2YbtFeVXwJ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUiu8AAAoJECTWi3JdVIfQ9HkH/0qssY6McAPlWY63XTM/VbP4
XzOtQACFpMBzpbH5SP++SIvekcx7QdMU1OBMN+Xw5OjL75nJ1p9glJuI8nD8mNID
BY0YPtqE77U9sj93P3ttrH3dtF+4dgkQTWCkPrWyHkC3NZwCa6ZGJzmBT9IKgd9N
Bpt9AQVef0491eSs5ZK3RWwRtu6rTJenp3H2bMUixrMwR8SB7J4/JL2YMCKfigIy
cMHJPBd2/ZMcoBWdjn0KV+VCB3scr3TIaIp2Y06XAgGFnUQKr1FACUNRsu9cHXJL
1GlZ9vEkgr8VkijbBfOqOiYa5Ztkr2xBoCg8kUoKG0BfcQk1quD+Nex8nns2kx0=
=qYze
-----END PGP SIGNATURE-----

--p0HNO2YbtFeVXwJ3--

--===============3425315750219590501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3425315750219590501==--
