From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 4/6] drm: bridge/dw_hdmi-i2s-audio: add
	audio driver
Date: Tue, 25 Aug 2015 07:52:22 +0100
Message-ID: <20150825065222.GG27431@sirena.org.uk>
References: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
 <1434731295-11060-1-git-send-email-ykk@rock-chips.com>
 <20150808153540.GL7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4277342809764043343=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C483A26040E
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 08:52:38 +0200 (CEST)
In-Reply-To: <20150808153540.GL7557@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel <alsa-devel@alsa-project.org>, Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, David Airlie <airlied@linux.ie>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, dri-devel <dri-devel@lists.freedesktop.org>, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, Philipp Zabel <p.zabel@pengutronix.de>, Yakir Yang <ykk@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, Paul Bolle <pebolle@tiscali.nl>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============4277342809764043343==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S5HS5MvDw4DmbRmb"
Content-Disposition: inline


--S5HS5MvDw4DmbRmb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 08, 2015 at 04:35:41PM +0100, Russell King - ARM Linux wrote:
> On Sat, Jun 20, 2015 at 12:28:15AM +0800, Yakir Yang wrote:
> > Add ALSA based HDMI I2S audio driver for dw_hdmi. Sound card
> > driver could connect to this codec through the codec dai name
> > "dw-hdmi-i2s-audio".

> I'm applying this patch to my tree with some changes.  I haven't seen
> anyone ack it, nor review it any further.  I'm hoping someone can ack
> this patch with the following changes below - I'll be posting it as
> part of my dw-hdmi devel updates later today.

I'm pretty sure I deleted this patch unread because what shows up in my
inbox is:

->  197   C 08/08 Russell King -  (1.1K) =E2=94=82 =E2=94=94=E2=94=80>Re: [=
PATCH v5 4/6] drm: bridge/dw_

so there's no indication that it's anything to do with audio :(

--S5HS5MvDw4DmbRmb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3BCmAAoJECTWi3JdVIfQ01kH/1joG0/ST3gc1zTn/Tjd/pKb
0dOJ4AjrbVD/f7YAKpB+6umDmXA9jPBl1lbkPQdn1pOucTVEi/3xe+gn3bvUoRje
xLTlwrpS5B37rpnolcz8gQVoVu+JNrgwvvxodmbfmT7G6UG8Q6lm1+ZMERqRRcmD
gCAszOCxtJxrXUpWR08vIOmUoWgW7DmGWHe+SttGZytHDUf+QJNIOUW9cQ9FfJtX
fK0T94/DcR0rvjOl9sEbXEEtcMjgsxxTr2rtxe7HXJzg8vCebxRbXIiKD1V3JZPr
jX0oQ7n1B4qsO9mjQam1Q5DSWOqolERNU1e5KaPujrMxwqmdFEGQhnV0SRcOfw4=
=vliN
-----END PGP SIGNATURE-----

--S5HS5MvDw4DmbRmb--

--===============4277342809764043343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4277342809764043343==--
