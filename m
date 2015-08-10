From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/9] drm: bridge/dw_hdmi-ahb-audio: add audio driver
Date: Mon, 10 Aug 2015 19:16:41 +0100
Message-ID: <20150810181641.GD10748@sirena.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hC-0003M5-EU@rmk-PC.arm.linux.org.uk>
 <s5hk2t35ui4.wl-tiwai@suse.de>
 <20150810103921.GR7557@n2100.arm.linux.org.uk>
 <s5hegjb5o44.wl-tiwai@suse.de>
 <20150810164941.GW7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150810164941.GW7557@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>, Andy Yan <andy.yan@rock-chips.com>, Yakir Yang <ykk@rock-chips.com>, Fabio Estevam <fabio.estevam@freescale.com>, Jaroslav Kysela <perex@perex.cz>, Sascha Hauer <s.hauer@pengutronix.de>, Jon Nettleton <jon.nettleton@gmail.com>, David Airlie <airlied@linux.ie>
List-Id: alsa-devel@alsa-project.org


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 10, 2015 at 05:49:41PM +0100, Russell King - ARM Linux wrote:

> I'm not sure what the right solution is here: modifying every audio
> player out there to make HDMI work sanely is crazy.  Having alsalib
> automatically generate the correct AES channel status bytes for
> linear audio formats seems to be sensible, but difficult given its
> present structure with the defaults - the iec958 plugin has no idea
> if the defaults are being used or not.

> The advantage of having the horrid conversion in the kernel is that
> we can choose to generate proper AES channel status data without
> regard to userspace for standard linear PCM, and when the iec958 plugin
> is being used with proper channel status (eg, in compressed audio
> pass-through mode by VLC) then that works too.

The other advantage of doing it in kernel is that it also fixes tinyalsa
applications (which mainly means Android systems) by default for PCM
data.

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyOqIAAoJECTWi3JdVIfQ5xAH/jgHoxctKQ2yixGAjdkXug5s
ShURRpNTK3ikzFITz6wOjB+VP/4CThHJdDEPCnwkQmR/QaCnuz2OpWEqEbfwCDJZ
oTpmhz8kIhW2bFM0HLtVP+I8HOYGUK6D8u5cvb1i6CEqzKSfFYqsR6Mrqf8fYznE
WbPmtnaX1GGgM+MEgzkUCFMpV/Eth/IHyxKddlubXWlGbxZ2djt3eEiwHXs2IUTC
BUNt6dahxPpmWKWeVdWZpcUiX3nPYPGyGGA4F6Uh6BRqTJMSRbxn5hbf9M6x+E+y
7w5+H0zcjJPqF3FTxOIpogWp0asJ5PykNiNqYWH8HZ0vZRqMX8avE20xqbqIpas=
=XP20
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
