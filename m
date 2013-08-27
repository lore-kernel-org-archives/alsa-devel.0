From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/8] ASoC: Call snd_soc_dapm_new_widgets()
 only once during card initialization
Date: Tue, 27 Aug 2013 15:38:32 +0100
Message-ID: <20130827143832.GR10783@sirena.org.uk>
References: <1377611461-3638-1-git-send-email-lars@metafoo.de>
 <1377611461-3638-6-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6624601223953201882=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C85B2652D0
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 16:38:47 +0200 (CEST)
In-Reply-To: <1377611461-3638-6-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6624601223953201882==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kAOhhqH5290wydqT"
Content-Disposition: inline


--kAOhhqH5290wydqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2013 at 03:50:59PM +0200, Lars-Peter Clausen wrote:
> Each time snd_soc_dapm_new_widgets() is called it will instantiate all the
> widgets and routes that have been added so far and then power them. Doing this
> multiple times before the card is fully initialized and all widgets have been
> added can cause unnecessary and even invalid power state transitions which can
> result in extra register writes and and also might cause clicks and pops.

Applied, thanks.

--kAOhhqH5290wydqT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSHLnlAAoJELSic+t+oim9X8IP/Rgku+18XzY1vxT3aXYw1da9
hqEff1AUEF2ZjTV5nHCcsX01cuRaDciTMjF9dnDTqTwSMDfswhXyN5aVaKLBOqje
4bsnIdjF+3y0qtwV48R8zthObvb8Lcdq5NIUDvGCoif7AV8t/vYXejOyaPd6SwQ0
rzdXdqcNLAgAWEelup+YGzpdsT0kVDhyxGbFGl28g42IxZ12V9VvtbLRWTUYgmGt
wObOt5TvjchYd2V74NpDgl4FRw5jr8mO8pKsbDKwzyG5XvPHyiC+HYev4UgdpZSs
s/y6b5cpN0xwH5dYwfCDPahLbAGqTvXiG00tZmrBZGBo43oT78sjUxeU4f054wMO
cae0gc+TZhEpwHSOzkxclJRr+aNafr3NRrM6bqfdwUBuwfpBecV8eFepx9Y0kC5J
/L29hodV0xmUb4hg5WKsjzKVFD8DX1ylFhccUiyzIxSqSdYi7wB1RhAShJQt5ILC
ViLhjKjjQXerj6t/UlM8M3vNQVoEzb7WvU6fIRxi4Y6AN7Q1p2YJ/eIHPBrmu7jS
SKKaaXRcDw5zwHRJ7SE/fF6unLhIWo75Ll6esaSK5uaCXRfX4+ZT3gN3HBPYULu3
jmo+1GTn7Z82EyeDayNuk+eyszP83ytz9oz879q9qOOdNxSQc5wajwvqo/P7ozMb
HAJYFjsROhgoWkS3cxiJ
=QSTd
-----END PGP SIGNATURE-----

--kAOhhqH5290wydqT--

--===============6624601223953201882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6624601223953201882==--
