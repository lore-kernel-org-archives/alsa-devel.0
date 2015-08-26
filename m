From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/10] Add support for img AXD audio
	hardware decoder
Date: Wed, 26 Aug 2015 19:04:36 +0100
Message-ID: <20150826180436.GC28760@sirena.org.uk>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0559820135625718801=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AD6C1260525
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 20:04:50 +0200 (CEST)
In-Reply-To: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Marc Zyngier <marc.zyngier@arm.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: alsa-devel@alsa-project.org


--===============0559820135625718801==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline


--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 24, 2015 at 01:39:09PM +0100, Qais Yousef wrote:

> Qais Yousef (10):
>   irqchip: irq-mips-gic: export gic_send_ipi
>   dt: add img,axd.txt device tree binding document
>   ALSA: add AXD Audio Processing IP alsa driver
>   ALSA: axd: add fw binary header manipulation files
>   ALSA: axd: add buffers manipulation files
>   ALSA: axd: add basic files for sending/receiving axd cmds
>   ALSA: axd: add cmd interface helper functions
>   ALSA: axd: add low level AXD platform setup files
>   ALSA: axd: add alsa compress offload operations
>   ALSA: axd: add Makefile

Please try to use subject lines matching the style for the subsystem, I
very nearly deleted this unread because it looks like an ALSA patch
series, not an ASoC one.

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3f+zAAoJECTWi3JdVIfQDD0H/Rv5PJHlXTHPut//XcmWFdjW
ZEbb8EbNzBiGp9uhsOSs5ERfBEVi1CjDDaizb0rfaOyI/y1X+0alRsl4oaOV/Xi1
aJ50s3o23cUg21eaB6i1tUtX2vm07vEVbwgEAiOa7nXiKL3nhTg0//DgC4//zedE
gB7X1qKLBw7aah0PRMBDkVIQP2hEDwockP5Jp6MS9TTBFWA/EuADWfxtbOmKepbz
vC9LQIksBz3Pdy3PNuQy5aSH9irdGllVP7Fca2aEfk4LJ0a2q/wUoJUTrnsh3MJy
6pvbTMHNf85EqD1guc3CuI/jb1wPfsJwkeFzmujW9iHRxT9Bv7AkaDT7+InBrNc=
=9Ye+
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--

--===============0559820135625718801==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0559820135625718801==--
