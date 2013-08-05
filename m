From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 02/13] ASoC: kirkwood: use
 devm_clk_get() for the external clock
Date: Mon, 5 Aug 2013 17:16:04 +0100
Message-ID: <20130805161604.GP9858@sirena.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V63tP-0004lH-4Q@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0341627998178025200=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F537265020
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 18:16:08 +0200 (CEST)
In-Reply-To: <E1V63tP-0004lH-4Q@rmk-PC.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0341627998178025200==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jr/iWW7oJeDTI5E+"
Content-Disposition: inline


--jr/iWW7oJeDTI5E+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 04, 2013 at 08:23:03PM +0100, Russell King wrote:
> Use devm_clk_get() to simplify the error path for the external clock.

I've applied the diff that remains from the existing upstream code
(which frees extclk if it's just the internal clock) with a reworded
commit message, thanks.

--jr/iWW7oJeDTI5E+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/8/AAAoJELSic+t+oim9T/wP/iV+Js5Y9VQDxAVuXYolBC1S
/O90Ha8fYV1CNrFSQ01USV9BPqT38QvGOnGu9r/OxrYOTv08T4386JND/B7XQwMO
7LyPhLK/dEiMb/D9syHsyOYOs6Yse3WfF/WhiOlBO+2BKn81+64i2bNpK2kQFfyP
toOo8c3nlRgk1o+CFyPyBeJTNhPNrmpqiiHdNEBrv5YvvHREM/FaK1fhe0NwG0iW
oNemtjHCQAYVzq+fffQSAcaGK6ddZAYA9LxO6/NHv4+OVRwVkRwlDwxZwH8NME5O
Icb2Tofz6X0UupnN211R5Z3clKBu2dSIeaQmsiJoGz/T722TYAO4XbHvk0MuOPNQ
xVXKsLwrwkpZQodsd2vXISRwBhZhX5wM3zaa9lCGUrX8+XAhJI0GJGCutHDXdJhP
M8bCJqxrMpLRNYgAizD4aAEVs0FlvXamE9AfJw7ijA0VeElWJpnimuF6pNbvsIuG
o/RTMH0IzNdcbfXU66r8MCTOf+EWsKd0XqncVOrosXGyMtwNr/n/kPmiB2EJGyKD
Lu/o2X+zKGfvtLX5IqjvxtSCvGJOXE5txMzYX4xdDx3rxX1tSnIPGcHmDWxjknbr
DhgrXeFiMwRghwiJtLXcXHmiASn/Yerlj2vPgUM4Dccsr9fa3+g04PGH++GJWDN/
8NXzELwf+44yN+CBAR9z
=P4Bi
-----END PGP SIGNATURE-----

--jr/iWW7oJeDTI5E+--

--===============0341627998178025200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0341627998178025200==--
