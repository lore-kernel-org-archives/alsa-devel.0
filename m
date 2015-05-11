From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 12/13] drm: bridge/dw_hdmi-ahb-audio: add
 audio driver
Date: Mon, 11 May 2015 16:58:26 +0100
Message-ID: <20150511155826.GI3458@sirena.org.uk>
References: <20150509102501.GO2067@n2100.arm.linux.org.uk>
 <E1Yr1y8-0006lG-Mw@rmk-PC.arm.linux.org.uk>
 <554E3AA8.8060601@iki.fi>
 <20150509165536.GS2067@n2100.arm.linux.org.uk>
 <554E3EE1.40904@iki.fi>
 <20150509174054.GT2067@n2100.arm.linux.org.uk>
 <554E49FE.8040004@iki.fi>
 <20150509181153.GV2067@n2100.arm.linux.org.uk>
 <554FAA9E.100@iki.fi>
 <20150510193320.GZ2067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5862625495756798473=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EADA264F45
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2015 17:58:49 +0200 (CEST)
In-Reply-To: <20150510193320.GZ2067@n2100.arm.linux.org.uk>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Takashi Iwai <tiwai@suse.de>, Philipp Zabel <p.zabel@pengutronix.de>, Yakir Yang <ykk@rock-chips.com>, Anssi Hannula <anssi.hannula@iki.fi>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5862625495756798473==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HuXIgs6JvY9hJs5C"
Content-Disposition: inline


--HuXIgs6JvY9hJs5C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 10, 2015 at 08:33:20PM +0100, Russell King - ARM Linux wrote:

> My personal view is that where we're dealing with PCM audio, the driver
> needs to set these bits correctly as there is nothing in userspace to
> do this.  This provides an identical interface between each audio device
> which accepts PCM samples - whether it's a SPDIF or non-SPDIF based
> device.

> For non-audio data sent via an audio device, the AES bits need to be
> conveyed from userspace, and we should respect what userspace gives us.
> (If it's wrong, it's a userspace bug, and userspace should be fixed,
> rather than trying to work around the bug by patching the kernel.)

For what it's worth this is exactly what I'd be expecting to happen -
the kernel should do something by default and then let applications
override it if they so desire.

--HuXIgs6JvY9hJs5C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUNGhAAoJECTWi3JdVIfQFmoH/iT3g0Yy0N00nD21THNd/JoU
KSuyJX+65DhuwT4wV/WoqiIykHuyPkXFJ+oVnrGEaTmS0u4tdpRmb3BdT9SWH+Uj
rGzDx6cJtOya+hrZosI08rwyqZtHUeFxuZR/qvnG9Hmcd2Cl6Ihd8HsSRY6wClLc
8ZnXTc+HD19VgTayJT8w52ikBFZJkjLOpWKsCpNzFTiXNeCOJzs0STLdVq71WDQp
pos3IMNwCFrgJ0ne25sjeJU/SgU1z0B8079Sjs9uuO6+MqjLb7lXCjSG7PJPxAT9
lzXWPU1Gn/H7K5IxCxjcVM/fvjCx6p8ncitgIbhFnTY02k8H3Z+blUXeDwe9VLE=
=va+x
-----END PGP SIGNATURE-----

--HuXIgs6JvY9hJs5C--

--===============5862625495756798473==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5862625495756798473==--
