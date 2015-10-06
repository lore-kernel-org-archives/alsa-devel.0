From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC V2 0/5] another generic audio hdmi
 codec proposal
Date: Tue, 6 Oct 2015 17:46:02 +0100
Message-ID: <20151006164602.GV12635@sirena.org.uk>
References: <1443718221-5120-1-git-send-email-arnaud.pouliquen@st.com>
 <56127ADB.6080700@ti.com> <561392F7.90608@st.com>
 <5613EC62.8000007@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6403731322074897753=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 44C49265747
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 18:46:46 +0200 (CEST)
In-Reply-To: <5613EC62.8000007@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: "moinejf@free.fr" <moinejf@free.fr>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, Benjamin Gaignard <benjamin.gaignard@linaro.org>, David Airlie <airlied@linux.ie>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, Takashi Iwai <tiwai@suse.de>, "tony@atomide.com" <tony@atomide.com>, "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============6403731322074897753==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H/fcI7KrSCrurIFl"
Content-Disposition: inline


--H/fcI7KrSCrurIFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 06, 2015 at 06:44:34PM +0300, Jyri Sarha wrote:
> On 10/06/15 12:23, Arnaud Pouliquen wrote:

> >In a first step, before going deep in discussion on the approach, it
> >should be interesting to have maintainers feedback, to be sure that my
> >approach could make sense from DRM and ALSA point of view.

> Absolutely. In the end the maintainers need to make the final decision any
> way.

As I keep saying at least for me a very big part of that is going to be
seeing some degree of consensus among the people working on HDMI.  I
really don't want to get something merged and then having people turn up
shortly afterwards saying that there's some reason to redo everything
and I don't have much familiarity with the video stuff so I'm largely
relying on consensus and review from the DRM side (which seems to have
been absent thus far).

--H/fcI7KrSCrurIFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWE/rJAAoJECTWi3JdVIfQyYsH/0yjcUdzrCvkMRg+9IZd8Cqg
nX6TDT+3Ztnl3kz0l+7/iIuTCa7jQZcieMZ/xRVbwcE9jGaEltUYaCbAyTJyKw9w
ppCsa1O7blJWokCT4LpoC8bXKnM/Os25Ib5ezIqvcCDGJl+s0M9T3gXEKYxq3iDb
UdRMsNp3DMjRcZAEXfxVH9X//gYPaxaJz0IujopBv5mgFVbxpsuPvGNaGiK6Rq3u
5mr/i13uCip9Ni8uhMAK2QsPn51Q5x4Fb9gmBPJa5wUpkHX4rfkKiVyKfHi3IcxK
NMNk4YYkOqGTzGuEl4LIbaay896HcZ20P9HgSAxRnSMt5kN45Jbmah4pUHFFPGM=
=lg1R
-----END PGP SIGNATURE-----

--H/fcI7KrSCrurIFl--

--===============6403731322074897753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6403731322074897753==--
