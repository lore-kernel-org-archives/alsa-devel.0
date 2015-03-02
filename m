From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sam9g20_wm8731: drop machine_is_xxx
Date: Mon, 2 Mar 2015 14:06:38 +0000
Message-ID: <20150302140638.GW21293@sirena.org.uk>
References: <1420542872-10015-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150106174521.GM2634@sirena.org.uk>
 <20150302134253.GQ4094@piout.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2954591745146591474=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 128112605C0
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2015 15:06:58 +0100 (CET)
In-Reply-To: <20150302134253.GQ4094@piout.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2954591745146591474==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Vsrj9sMnya5stNI0"
Content-Disposition: inline


--Vsrj9sMnya5stNI0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2015 at 02:42:53PM +0100, Alexandre Belloni wrote:
> On 06/01/2015 at 17:45:21 +0000, Mark Brown wrote :
> > On Tue, Jan 06, 2015 at 12:14:32PM +0100, Alexandre Belloni wrote:

> > > Atmel based boards can now only be used with device tree. Drop non DT
> > > initialization.

> > Applied, thanks.

> I don't see that patch in 4.0-rc1. This will lead to a compilation error
> as all the machine_is_at91xxx have been removed.

*sigh*  If something is a bug fix then please flag it as such; nothing
in your message gives any hint that this is a fix rather than just a
random cleanup.

--Vsrj9sMnya5stNI0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU9G5pAAoJECTWi3JdVIfQABoH/A+WlKdiPB/GwLaZ2QNIDsp/
ikRaRoDphY0WVxIbjuQUPJPtz5Qd2NFnnZ8/APg2Ugu1h/alDLzFLcJnmOS6Kp+Q
ewwGUuDnSTAy+yV3s/OoueDLJxeDXMjU0yAYLr7VHuC1LNnzFK65FEE5k2bomeyo
mx1lrJMJPm+Bo2t0edc0wo4sgaG59HwH/si7Vm+lxt8J1+xHct1xzcnhcrZ72yaT
8StRPksw+kj3+W7NTbql5OilzuaRc+eZEP2P4DlBNyrLxK6O4rNnWhbDy0D2iEec
CTregdvy38OTDxAEPMnGWLVevdNgPtmwIukW2qlrCpgWZhOHmY8OYOqSOg0Dxa4=
=5/HB
-----END PGP SIGNATURE-----

--Vsrj9sMnya5stNI0--

--===============2954591745146591474==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2954591745146591474==--
