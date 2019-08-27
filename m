From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/4] wm8904: adapt driver for use with audio-graph-card
Date: Tue, 27 Aug 2019 19:40:39 +0100
Message-ID: <20190827184039.GJ23391@sirena.co.uk>
References: <cover.1566734630.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3453263241014828568=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1566734630.git.mirq-linux@rere.qmqm.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Maxime Jourdan <mjourdan@baylibre.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Paul Cercueil <paul@crapouillou.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, Anders Roxell <anders.roxell@linaro.org>, Takashi Iwai <tiwai@suse.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-arm-kernel@lists.infradead.org, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, Piotr Stankiewicz <piotrs@opensource.cirrus.com>, Annaliese McDermond <nh6z@nh6z.net>, Richard Fitzgerald <rf@opensource.cirrus.com>, Nariman Poushin <npoushin@opensource.cirrus.com>, Thomas Gleixner <tglx@linutronix.d>
List-Id: alsa-devel@alsa-project.org


--===============3453263241014828568==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5PPnVwj6ulmYFu5t"
Content-Disposition: inline


--5PPnVwj6ulmYFu5t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2019 at 02:17:30PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> This series allows to use WM8904 codec as audio-graph-card component.
> It starts with rework of FLL handling in the codec's driver, and as an
> example includes (untested) rework for codec with similar FLL: WM8994.

Please make some effort to focus your CC list on only relevant
people, many upstream developers get a lot of e-mail and cutting
down on that helps everyone stay more productive, too many can
also set off anti-spam software.  You've sent this to a lot of
people and I'm struggling to figure out why most of them are on
the list.

--5PPnVwj6ulmYFu5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1leSYACgkQJNaLcl1U
h9D/qAf/aDKjsXpu3OV9W/YRcVKa/q4lkLirQXvzegtCjjtctGiFmmTa8hRGeaU2
sHHo5pU4H6EDQZubuS3bnNWzE0SRout2VquNd1ddjAQoVCmRv2rfaGFpI2SelVqL
2lAMUx2niskdB2f1YFRIBbuvwfok6C3qew9aM3DZIDhD+foqHLWuwWYNDjjbwopR
rqLgjwGRoCwQQh9/HfhdWB7b94NQ74aPsa0xETo+dsR4z1k1PEjoThjBkckOI/eF
8yFtAR6coVQ2DHbsAKTO7ajC43cumNyh4XhYRAxBVrCJ6wG17AQTT23HTpNaLCGy
tYANpAltXhi4j1vd/QkH9wh3MvDFww==
=GFP7
-----END PGP SIGNATURE-----

--5PPnVwj6ulmYFu5t--


--===============3453263241014828568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3453263241014828568==--
