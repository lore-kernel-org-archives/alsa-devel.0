From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: bf5xx-ac97: Remove unused extern
	declaration
Date: Tue, 30 Jul 2013 12:50:25 +0100
Message-ID: <20130730115025.GR9858@sirena.org.uk>
References: <1375184050-21514-1-git-send-email-lars@metafoo.de>
 <1375184050-21514-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7452666390389861967=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DB308260729
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2013 13:50:28 +0200 (CEST)
In-Reply-To: <1375184050-21514-2-git-send-email-lars@metafoo.de>
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


--===============7452666390389861967==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YHJaAPTstyQT18gF"
Content-Disposition: inline


--YHJaAPTstyQT18gF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2013 at 01:34:10PM +0200, Lars-Peter Clausen wrote:
> The blackfin ac97 driver never defines nor uses a global ac97 struct. So remove
> the extern declaration for it.

This is a duplicate of my patch from yesterday...

--YHJaAPTstyQT18gF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR96h+AAoJELSic+t+oim9GBIP/Azuu+3z72mAIgNS9ocHx0RC
ULXtU9n1WmKEF2WPHAdO55KrQOaleEe68r6tj3YQIguWaYn538nyvQug4dm975u+
U+ynxVpYTIFRsO18KFv9tHenAz7kREKHKcunjmSf+G+rQKsHM5KVuH2kHe6CdEF0
zZFXhQmqua+hTM0SQNsi/sglr56bMui8FJaFJeahpK13SrOXPoAmHRAh80S0HOSS
d8jc2kr7sWEIRQIBQ92WkMzYI3UwbOpaMpISQnVEqN3ityOYOhN9KkSp3VnDAHMA
i5Mp2gv4NrkoQDAU+xnVHoBDrx1jjgaKTIrKbzrmFEElcRHA1NR5RZ/ibgOzwIDe
g5oboYGzSk7uyA9gSgWaYiGPja+gND+vlCYKv4FZM8P4Akb66tO0ijW9wjdSOMZW
Bb5210j9PSYK8VmlO+yE9gm1ft215QXOpwBJNKr0KOwGOoWdc3oop9E1/+wtsNdH
xZ7iV80YcksPIWlINbJ3yRrcX6AzxtkAX1ECvUEoV5kgoyNYh8hISpqTELo0swxc
hjveuSCU7l5p+OqqkZdXAHFY9pcoPkELoWaUTfmYjgW6GvaFYRoQvNhWzQ8P8iFb
TiLrFd/C54lDf/hFZHL7YTUJWrB2ZlvfmJruOxwgtfA0tWwoP4ArcZvIGK5aVeI+
ndICq/fwThUTS2O+VwzB
=7YWJ
-----END PGP SIGNATURE-----

--YHJaAPTstyQT18gF--

--===============7452666390389861967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7452666390389861967==--
