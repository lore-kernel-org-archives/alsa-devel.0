From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Add period size
	protection mode
Date: Wed, 21 Mar 2012 08:40:52 +0000
Message-ID: <20120321084051.GA9342@opensource.wolfsonmicro.com>
References: <1332242021-7494-1-git-send-email-peter.ujfalusi@ti.com>
	<1332242021-7494-4-git-send-email-peter.ujfalusi@ti.com>
	<4F68AE51.808@bitmer.com> <4F698B56.6030502@ti.com>
	<4F69920B.4010701@bitmer.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5261606022164990611=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B4D5F104411
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 09:40:55 +0100 (CET)
In-Reply-To: <4F69920B.4010701@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5261606022164990611==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 21, 2012 at 10:32:11AM +0200, Jarkko Nikula wrote:
> On 03/21/2012 10:03 AM, Peter Ujfalusi wrote:

> > Well, for system integration's point of view I would prefer the sysfs
> > file. If this is needed by the distribution/use case it can be enabled,
> > disabled in runtime. In my view it poses less hassle for distributions.

> Problem with custom sysfs is that no generic distribution is going to
> use it but problem can be triggered there. IMHO for tailored
> distribution point of view custom sysfs setting is no better than custom
> asound.conf.

I have to say that I agree wholeheartedly with this - the sysfs rule has
all the problems that a custom asound.conf does.

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaZPuAAoJEBus8iNuMP3dPW8P/RAV/t710JhaEoxq/e/r4vqh
ys0JCwf/4Q4KNrUkqy6VoZn48tulWGg+yOwRe4nriTqZoxwqN9YK+SN3+Jxe4EC4
VZ/8g9v+NSQWOtAFsyZ1V4cJdU6lGnRi6ObaLSXd3SMXw4bXLY84Thk48fh8x0/U
resdZjwzF1JtTYCkAuej0rhg8vmuml2y++xRR/Q2OgrS07vQ/8Ef3YqTAL0tLfNO
nh1F6ZDWxSLg7vAR5GSezDNsEqjhKe8tGSFLS/IUaFaMvt30ab16v4FrYL+p4Nty
JGMhLKvI/x4+VAOO6yXxOSNJXkvFOB1c+xcrzgL7jbvu60LG0h/+2icvVGy5r4tR
A0Caf1WjEWoUYnL9aNxtMPXWdse963Nxpbz+O0N94J9FO28lNAhka2xEbWS23PUK
qehZkPDKx2sutA5PkvB2ZRAASAo9Ms61v+crsh6kwgkJxdU3H7Tu8ykchneatVmo
kWeYpQitmYnY/EDEJMHcQjQzn/994KL5UdK8nB401rPGCzKw/astuWkjCic1cBIF
o1meDMs3e2TNIwIDETjmC8QxAf1ZjvrbtXreY2aMkkoOgVFMSbhMLxabG/if6hnw
EmLcptlVaVye8yIt9TwrupIpmPmen9gJEuhtdH+SSUp4IRfIqiv3MXSHhaF1rPBd
nxh1QxiOHxsesOW1WBDf
=BqOO
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

--===============5261606022164990611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5261606022164990611==--
