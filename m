From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/2] ASoC: wm_adsp: Factor out ADSP2
	boot proceedure
Date: Thu, 19 Dec 2013 20:21:00 +0000
Message-ID: <20131219202100.GK31886@sirena.org.uk>
References: <1387468085-26176-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6478616596764166164=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A65C2654D4
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 21:21:05 +0100 (CET)
In-Reply-To: <1387468085-26176-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6478616596764166164==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8tIZwPmdq+hd82jQ"
Content-Disposition: inline


--8tIZwPmdq+hd82jQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 19, 2013 at 03:48:04PM +0000, Charles Keepax wrote:
> Move the ADSP2 boot proceedure into a work structure in preparation for
> running it asynchronously with the rest of the audio path bring up.

These look good at least for a first pass, though obviously the drivers
need updating and you need to pick times to run the events.  I had been
thinking about trying to do something to encourage things like firmware
download to happen during other delays or trying to arrange to initiate
things from the clock startup (this is one of the possible uses for the
_WILL_PMU event) but both are future work things.

You probably want to explicitly schedule these for WQ_UNBOUND though I
think that's the default.

--8tIZwPmdq+hd82jQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSs1UpAAoJELSic+t+oim918YP/Ay/BlURW16maK8R7DxXXReh
dYeapNTMTXyjKIWLJuKRokykhRZz4mcCsAOzZi+CsVM6K+11wYS4h2pX5YYJK0X4
iTmHcuDu8WuVOPqzJXoNhmV1LXzF4sKgpIwH8U21Cu7ZksRQk+lyKpZ8NCDxJ9+4
5r1EeX9a2XB0TaVAQE6VQyaYz0Ph9y07wl0sOyMRnJF1z9nEqxHt7RE+v6QbUvUK
jIzwBTnoFqJRxWGp0gpLNVdDu/Ecv6PcIZIEvuG5Qx+7tpm2FHWa1krQkkiX5sXJ
kCPHXPHyyGO7ufJey/MhjAd4qicodTQBnuirizJzrO4zrztifG49pwH5eTT2AK/n
ZKwJ2L7K5ZRe8uiCty5gSqSo1dRsyuoYRQxco1D6tyBw+51aT8DuxSpPtH2O2k4M
CL9Jxw/IS143yMUZJrUXw3/Fvzw+gJeMqKfXcCoJ/llePBxtLqW54LcsNu8pgJtz
Ce3wvnLkRAhS4aKWGMBw1w/FlMjRJmXjVWGKCGmEJHtHW3fxwJRRQDDhu6OmPa6s
JfBl9W7oE+mF+fLg69P/p1HKgEQ5ku76f+sxOtuaeKZsyIFoX7imQz7w7VpCS6B1
Y2uYCNiRUKaLF5vX5mKbXPMzkIMMtqIXfQYei0T8eeBvaKe3+PhTSt6QJYzMXmZE
+NTPYsy1XjZrGp9WY2Xl
=3oW4
-----END PGP SIGNATURE-----

--8tIZwPmdq+hd82jQ--

--===============6478616596764166164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6478616596764166164==--
