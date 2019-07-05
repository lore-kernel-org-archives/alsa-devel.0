From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 2/4] drm: bridge: dw-hdmi: Report connector
 status using callback
Date: Fri, 5 Jul 2019 18:16:18 +0100
Message-ID: <20190705171618.GA35842@sirena.org.uk>
References: <20190705042623.129541-1-cychiang@chromium.org>
 <20190705042623.129541-3-cychiang@chromium.org>
 <VI1PR06MB41425D1F24AC653F08AFA463ACF50@VI1PR06MB4142.eurprd06.prod.outlook.com>
 <CAFv8NwJXbJo=z_NDj+JQHD9LOmnbfM8v_N1uHn4sdBzF-FZQfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1723428820=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CAFv8NwJXbJo=z_NDj+JQHD9LOmnbfM8v_N1uHn4sdBzF-FZQfA@mail.gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Cheng-yi Chiang <cychiang@chromium.org>
Cc: "dianders@chromium.org" <dianders@chromium.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tzungbi@chromium.org" <tzungbi@chromium.org>, Jonas Karlman <jonas@kwiboo.se>, David Airlie <airlied@linux.ie>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Takashi Iwai <tiwai@suse.com>, Hans Verkuil <hverkuil@xs4all.nl>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, Russell King <rmk+kernel@armlinux.org.uk>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "dgreid@chromium.org" <dgreid@chromium.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============1723428820==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 05, 2019 at 03:31:24PM +0800, Cheng-yi Chiang wrote:

> It was a long discussion.
> I think the conclusion was that if we are only talking about
> hdmi-codec, then we just need to extend the ops exposed in hdmi-codec
> and don't need to use
> hdmi-notifier or drm_audio_component.

What I'd picked up from the bits of that discussion that I
followed was that there was some desire to come up with a unified
approach to ELD notification rather than having to go through
this discussion repeatedly?  That would certianly seem more
sensible.  Admittedly it was a long thread with lots of enormous
mails so I didn't follow the whole thing.

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0fheEACgkQJNaLcl1U
h9BXfgf8Djh9t+tRCpOZtbD0eqLrC0mbgK6xvHKXz2Asdi73S29NTI0EsIjf8oZ3
Pz6/6L7lp75cOGU0EoQEzBtCuMIBCEXPI0gewu+FMjVlL3vhvV8svBfRuUZztzn9
12ImYdI/oGK5DDKw7UkhuSxjjoEdnStnEA7qmB/XjH5eH05C2P4xQBYLATEo52oh
jGMW1fSAh+dnQ8A3N9kAJLl9AF+f/eXzWfw3jfoelzQJPikX16xa5UE/U+ukQZ7F
B79Nr4Lp2n9ORhA+GXIk6HVSsoBDqUTOpjH4+zjgDXe9nYK+BBSJ5AX8aZlxBY7C
AP6VWjYU5x92p6hdgtNtqK0pmZ2SZA==
=5Rc/
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

--===============1723428820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============1723428820==--
