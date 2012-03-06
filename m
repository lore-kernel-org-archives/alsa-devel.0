From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
Date: Tue, 6 Mar 2012 12:06:47 +0000
Message-ID: <20120306120646.GH19635@opensource.wolfsonmicro.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
	<4F53F704.8080703@freescale.com>
	<20120304232817.GA13516@n2100.arm.linux.org.uk>
	<4F53FBA1.8090200@freescale.com>
	<20120305000411.GL7363@n2100.arm.linux.org.uk>
	<4F54053F.9070502@freescale.com>
	<20120305002635.GA23798@opensource.wolfsonmicro.com>
	<20120306104015.GF17370@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3704170393803609582=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AF51D24361
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 13:06:48 +0100 (CET)
In-Reply-To: <20120306104015.GF17370@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Tabi Timur-B04825 <B04825@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============3704170393803609582==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oyqLL/JqMvClXZi1"
Content-Disposition: inline


--oyqLL/JqMvClXZi1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2012 at 10:40:15AM +0000, Russell King - ARM Linux wrote:
> On Mon, Mar 05, 2012 at 12:26:36AM +0000, Mark Brown wrote:
> > On Mon, Mar 05, 2012 at 12:13:52AM +0000, Tabi Timur-B04825 wrote:

> > > To answer your question: I was lead to believe that the individual AL=
SA=20
> > > callback functions are atomic.  So one thread should not be trying to=
=20
> > > start playback while another thread is simultaneously trying to stop =
it.

> > That's correct, there's ALSA level locking.

> Please explain which lock prevents the capture substream trigger callback
> occuring simultaneously with a playback substream trigger callback on a
> SMP system.

Oh, bother - that one is per substream not per stream.  Which isn't
terribly helpful.

--oyqLL/JqMvClXZi1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVf3PAAoJEBus8iNuMP3dFbUP/RJ6+5oGjmNYiAfxQx0qC1qC
jpdxp2YaHvnmt6JCJT+24Z3b11bPC8dKzQ1UI9c5QZbT9VyWHifYeYs+WPobpoAq
fT9jLht+cbnswsvCD0lSSmCltBcTrC2HKDxuw3ibStTcHbpjZC7n7Lehdo4qQMAr
T6QIIxVHMsmYePGWDqgW2U4LEN8Sh0Y60XKzHmsDIlo0z9x/7XDYcm+U/DN5EfPU
3+bUfNKk1GjKjS0SgfLqwbbGuTTvBEH41sc1yAcc8QuoJKzPvqDnDNNpvdyj81xX
5n+v+kimMoxozBoHhtqvd5JzlKDohQP4qE3wwp5EzVbORNM4g7cELmb0jkVMtkVP
4zPz8SGRT7nW87Ohx+UejwdOYlqbGLLI6hdxzINcb7ewMl0Q8GkXROiFmVtle1rR
UVr+kJsKrAwbIgT5LraZoUtEZSd6ZxQr/GhEx8HSlsSgnajpV9+5EMl9YX3lEnbl
nHpc8L8mndzaP60/8zUxqid6NySV9LaY5oeVSiZQ0Vp22/xxPw3t4sgyqeocyPbv
gc8ZSZ0LqEfLluVTFotwQkGE/LZmqaH7JyuUjyJoh8PW27uHcrFFYIPmsOorW1xv
s00kK9Cs+V0f6V9wkunOGGNoq2FPbHTECfwESWOlptzFAdPpxtuUeLJRXNfgxtx8
7M/emtoepDXGXKZzilV9
=aZQU
-----END PGP SIGNATURE-----

--oyqLL/JqMvClXZi1--

--===============3704170393803609582==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3704170393803609582==--
