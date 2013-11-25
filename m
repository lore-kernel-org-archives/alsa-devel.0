From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] ASoC: clk: probe defer when clock
	not yet ready
Date: Mon, 25 Nov 2013 17:11:06 +0000
Message-ID: <20131125171106.GJ14725@sirena.org.uk>
References: <20131125093849.5fadc450@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6717480875084952509=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D8BF261AB7
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 18:11:12 +0100 (CET)
In-Reply-To: <20131125093849.5fadc450@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Mike Turquette <mturquette@linaro.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6717480875084952509==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gVeFDRGtAQ0W7qcm"
Content-Disposition: inline


--gVeFDRGtAQ0W7qcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2013 at 09:38:49AM +0100, Jean-Francois Moine wrote:
> At probe time, a clock device may not be ready when some other device
> wants to use it.=20

The patch subject starts of "ASoC:" but this is a patch for the clock
API only (it does then say clk:) - you probably want to fix that, it's
not going to help get it noticed.

--gVeFDRGtAQ0W7qcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSk4SnAAoJELSic+t+oim90loP/iM0gN4L0B0pe/2wTKw6Xl5g
RHuP07yc34pGhkTbmwoRV91wtUvebxDmVvQVezplUpafLKvg5x5D2iPX24HjJCc/
XvRCKXVFXO0nCwGOhXMY0GScjNE4wDT7qihgPbsQ5XyFEZKJFhTsn9AhQlSdHPZA
YaYBHB/nC67Z++0zbZnbgcqbDzU81/TfffftLgoA6gQ2ypgGsYk2YbYVa/YY+RQf
nT6QiWb6reJ58oVmZlP9FsO1BofqhVNkYhgkJI/tnViaRqCyDFJIHPzna/ZrF6GY
kqKmA7gL8c4Kxhw4FMGLX6IEk1QnbBzUmLgweYMTE4Yl0/beaSprUknrRhgjLlTe
y6e708CoK6dibuQe6V0yrcgZnZv9QQQrVNNoFGJFxXsVLb1rYtsqxOnlw6WX2vs1
P8zs0QtOUTeaQdtl+WH3siAOyEHBmNyw+4Xxa8WOOGvMOxzpnK3P67R7hOuQOykf
t0U5fa0EEUGl/AZ1DuO0+dliIShG08egk4hgFYs78PnXqGKwBTjDQoY875Hw8/TQ
e6bhFcjVxuZ5XFDewFYiJp7MlyGL7sgs20vOcZ8YFxfSFgIZWfHNFrs9E3pww8Gn
on9BhQMWE7LAy00NdpU+A+xjx38hbFBgyuhT4e1UrtYX+4hPsTD0+4W8LQXjNZ7B
Tmo3dnDyfIPKJ8v5mf47
=2sED
-----END PGP SIGNATURE-----

--gVeFDRGtAQ0W7qcm--

--===============6717480875084952509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6717480875084952509==--
