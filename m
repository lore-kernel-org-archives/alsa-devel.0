From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASOC: spear: spdif_out: Fix mute control
Date: Mon, 10 Mar 2014 17:43:30 +0000
Message-ID: <20140310174330.GX28112@sirena.org.uk>
References: <1393833469-20838-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5398123437149633840=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A3042651B4
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 18:43:37 +0100 (CET)
In-Reply-To: <1393833469-20838-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5398123437149633840==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Btsl8NZ320Cv5vrx"
Content-Disposition: inline


--Btsl8NZ320Cv5vrx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 03, 2014 at 08:57:49AM +0100, Lars-Peter Clausen wrote:
> For controls registers with snd_soc_add_dai_controls snd_kcontrol_chip() returns
> a pointer to the DAI, not to the CODEC.

Applied, thanks.

--Btsl8NZ320Cv5vrx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHfm+AAoJELSic+t+oim9yXIP/3Pyv5qwgQfJbRBuKYn/PRvz
gq68dbWmTJtIl/Kaa6loYNPXVT7RTc3j4KLxsIdClMX/+y2SuNBXp05YOq1GSYac
8gE+OtHJE3FjLC1pGZxe5cn6jxeyVfKp7Nn9SXaFK8CgeVAscMEStKAJgdOF1220
zJsk7bRGwdOXpUJslJe7Y9uTrdjKOYXWuEtArYTxAWXbeEgdzhg0e6wcy9huHWRz
XeC/lBLwjhAuQ5k4g2C7yVq0AmWhsHsWrgd17YJIUySF2FPkaN2XX8Q6s0jp+my9
YMO0CnZ6Y0s2OxnrBFU9ENmdDMTx8KvLvcG59Zjb4oNn1rBefanJQwnEZP0NZjSE
8q9X3lX1BLEHoVE6I9e6D6zl+vIk2y44z9sowAkQkZPJUWb3XZOQdgwTdgWbuU9T
s4I5uSZTYcMOGw2yOg3uTlWht8lYyEQ/nimyFcnRRSRoAdiD3LvOHDbsSiEcc6SD
Ad0xCm9SXrXcD2HnX1C/kBTgPHD/gg6ubHJJge9j1l63TtoykQVHyD7TRgVjAUkB
YPhxr6ExXlfGRrsLt6lElTEuH+IUCXRGIzN1tdwzvuDfJLqBvq1hNyaaJWOAPRsH
EnaBjPkA/cLDXiax7A9B07rTMv79ZGVx0HeHhlcfl2Vk5wOLsI4ci/LOmeGnUefy
GnyKCi4ayAP7W+cYK2uM
=suH8
-----END PGP SIGNATURE-----

--Btsl8NZ320Cv5vrx--

--===============5398123437149633840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5398123437149633840==--
