From: Mark Brown <broonie@kernel.org>
Subject: Re: HDMI codec, way forward?
Date: Fri, 16 Oct 2015 15:15:25 +0100
Message-ID: <20151016141525.GM14956@sirena.org.uk>
References: <5620E482.6050507@ti.com>
 <562100EC.4030701@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1093111138908474799=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 07D872606A2
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 16:15:31 +0200 (CEST)
In-Reply-To: <562100EC.4030701@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, Russell King - ARM Linux =?utf-8?B?4oCO?= <linux@arm.linux.org.uk>, David Airlie <airlied@linux.ie>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1093111138908474799==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mpBQsTDkJwM+mRv6"
Content-Disposition: inline


--mpBQsTDkJwM+mRv6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 16, 2015 at 03:51:40PM +0200, Arnaud Pouliquen wrote:

> - Does trigger is needed when CPU-DAI is master on bus?
> Otherwise how to inform HDMI that I2S bus is no more clocked? I'm not
> sure that mute is sufficient for all hardwares... For instance for my
> hardware CTS parameter is hardware computed based on I2S L/R clock.

I'd expect us to be always calling trigger - is there some debate on
this?  Obviously since it's called in atomic context it can be difficult
to use but we should be notifying.

--mpBQsTDkJwM+mRv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWIQZ8AAoJECTWi3JdVIfQFy4H/2gn+xU/mFgdfh5uk1bO9oSV
jdtBuvg13UqysPrQ8yZNcohJjMuwK5kq7GdguVfZJYhxKiqe2EAzu1nrbcw1MDOq
oj1yZ1BtUZcT8xPpSgPDuXwwHUzCFBUO579kTroc1l7lMhypqa41g1QUflL76Y9D
lLEeZiiF+jzHGtGKae472MgHodyMADZ5cUehPiP22bp4K1tFmhWR8vnv1KmaUyTi
BUwn3MbBjrW3u4ph8vBa5e2IpMr0tbSlW54/vIPt/+W43N1cSuv8CIfllOqE6FIs
IXyVYQfkBOXLlgNeFjHliXcncmZHFd9dnpgf/9wfMuFt3Vg7vjmWnJqAb7pQ5Ps=
=Lfhu
-----END PGP SIGNATURE-----

--mpBQsTDkJwM+mRv6--

--===============1093111138908474799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1093111138908474799==--
