From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: hdmi-codec: Add an op to set
 callback function for plug event
Date: Fri, 5 Jul 2019 13:12:40 +0100
Message-ID: <20190705121240.GA20625@sirena.org.uk>
References: <20190705042623.129541-1-cychiang@chromium.org>
 <20190705042623.129541-2-cychiang@chromium.org>
 <CA+Px+wXtmf9dQQP7ywPLp7Qbbvqau=WnO3qhZ8+qmbJD1gjx+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2377205734756942628=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1603CF800E1
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2019 14:12:49 +0200 (CEST)
In-Reply-To: <CA+Px+wXtmf9dQQP7ywPLp7Qbbvqau=WnO3qhZ8+qmbJD1gjx+A@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Tzung-Bi Shih <tzungbi@google.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, dianders@chromium.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil@xs4all.nl>, Andrzej Hajda <a.hajda@samsung.com>, Russell King <rmk+kernel@armlinux.org.uk>, tzungbi@chromium.org, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel@ffwll.ch>, dgreid@chromium.org, linux-arm-kernel@lists.infradead.org, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org


--===============2377205734756942628==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 05, 2019 at 03:08:37PM +0800, Tzung-Bi Shih wrote:
> On Fri, Jul 5, 2019 at 12:26 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:

> > +typedef void (*hdmi_codec_plugged_cb)(struct platform_device *dev,
> > +                                     bool plugged);
> > +

> The callback prototype is "weird" by struct platform_device.  Is it
> possible to having snd_soc_component instead of platform_device?

Or if it's got to be a device why not just a generic device so
we're not tied to a particular bus here?

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0fPrcACgkQJNaLcl1U
h9CqOgf+J1iCd1w3ReqbJfzVnRPz1davoLs8e6k9u638UeMZX3sVMS9fyeTcQtrX
XpRecrQsk7CUGoFb2ji0GxnHSXWnEwnIPCRmBzoDwSmsX+33TYQI1aH+m2ZeAgjv
QqHqk0vNtFAlsttbNMTvbkkkSYAAbOPW8K8AEL54U1X8EJBpqV8ljUj85yDazCou
SCsQUj0LlLqN6+Gm1LmXH81KdHY06t8i7yxPATgspDLgEJYi4WwdrIyqKAtl+k92
iAuK8BXYQJO14ZrV/8f0TJbHnrszfO3RJw0UqXdZ4YMvsw0KmrNj9jYv/cL7yD8F
AUeTwhBtKU+Jd353cqjNMhjYBXwEUg==
=+Q0m
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--

--===============2377205734756942628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2377205734756942628==--
