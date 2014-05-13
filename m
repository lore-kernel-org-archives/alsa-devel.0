From: Mark Brown <broonie@kernel.org>
Subject: Re: Broken outmixer_event function in
	wm8400/wm8990/wm8991
Date: Tue, 13 May 2014 17:09:24 +0100
Message-ID: <20140513160924.GJ12304@sirena.org.uk>
References: <5370840E.10009@metafoo.de> <20140512204734.GO12304@sirena.org.uk>
 <20140513135305.GL25203@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3719476778226508548=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DDF626522D
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 18:09:41 +0200 (CEST)
In-Reply-To: <20140513135305.GL25203@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============3719476778226508548==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KCEWjeprju4E2Ay1"
Content-Disposition: inline


--KCEWjeprju4E2Ay1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 13, 2014 at 02:53:05PM +0100, Charles Keepax wrote:

> Yeah I think the intention was to avoid imposing limitations on
> the order you set the controls, as the error checking is only
> done when the power sequence runs so you can move through an
> invalid state as long as when things power up they are valid.

Practically speaking we already have ordering restrictions - in general
you need to do a teardown followed by a setup otherwise there's a good
chance of causing audible noise from the switching during the setup.
Like Lars says we do run the event immediately anyway since the register
update is buried in DAPM processing for exactly this reason, we're
trying to avoid introducing a sudden DC offset by switching to/from an
active output so we see if we can power things down before we touch
anything.

--KCEWjeprju4E2Ay1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTckOxAAoJELSic+t+oim9+R4P/0jttlxzOW03CdozY8YmBC1w
/hVG5zksrNed0Ar998aQnSfUKMzQrLk8pkmFGICOIX/muqzqxHjp/o4QGDchE2v/
2270eh6TNk6vAFks0XrRtJ9C2Gfu6yTAUUfMSv8THaqKypxRoH9S8ALPo/r875Ji
hbS7CNgrlfAq/kyO+iD114QoESBZEDdTaZscB9w8GigzLT0OK+r+QXUdqCltPVkd
+lczQbBI1KPFomQALeFXD5n7cOeTfIK1GbpXsKlBzzHMvdFadbZKxdrA8ov62vlV
UV2G5Nq77xcNJDT2SY3lp2ZNN8RCb29iIsIZfGRika9BcS++BZpB5m4MnE92e1pa
eIjAWGy07O4fHKUHd3SmIUzZtoIVlEeFHBMNl+12e8IxlTnyPDWhsSNcR55eEqyO
htMhnuUdXx6qtb4AQoZzQiu5UWlQVhlNREoW9WbgsNx/BPHw/kVSO5ugJg1O0tXD
9NlGX9RjhuvNNMW0h55skaIsZ6c0ugwUJvvlgaZDZh2z3XbZzJY05Ezv6qhpBMaZ
FWLlejqSa4+Qs+3XZ9+xU/EUxrKaAvNyVuE1Ks5RlsqBIxvp6nFpN/tDFJC0U21W
QzxE0tGCJ3Av2heV9lPlxb0gEJJX/95GledgkzJespLXqs+NxQCIlF4txUwfcAgc
U81kaiYrkxJjlyTAR/GF
=PTnU
-----END PGP SIGNATURE-----

--KCEWjeprju4E2Ay1--

--===============3719476778226508548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3719476778226508548==--
