From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: Intel: byt-max98090: Move
 MICBIAS widget to supply of Headset Mic
Date: Tue, 24 Jun 2014 16:21:53 +0100
Message-ID: <20140624152153.GO23300@sirena.org.uk>
References: <1403530182-5400-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6180632977018768501=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C03892652D1
 for <alsa-devel@alsa-project.org>; Tue, 24 Jun 2014 17:21:59 +0200 (CEST)
In-Reply-To: <1403530182-5400-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Kevin Strasser <kevin.strasser@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6180632977018768501==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E187YRO8KGM40JwS"
Content-Disposition: inline


--E187YRO8KGM40JwS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 23, 2014 at 04:29:37PM +0300, Jarkko Nikula wrote:
> Move "MICBIAS" as a supply widget to "Headset Mic" instead of keeping it
> between input pin "IN34" and "Headset Mic".

Applied all, thanks.

--E187YRO8KGM40JwS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTqZeNAAoJELSic+t+oim9PqcP/31QuiW5VSXHEG0PkuI+AflN
+7cuhjGMYTZAWe9Em5/9LIHzFRI8TwUnBE6XXAmQactgj+1swudH8bCav0IxsaHf
D4cwymHX40MA/bYtQGGulQC5MiYY3atBrhymRXcHyPODBXY31nL6YNLrHR2HXuOb
f26zrbswLpGL6icC8d2srcGJqRo54QOjINo+ASNT8vW+pv5dhIG2BBENp8AyuWrK
o3om20CBgJ3lqbEkqi7rjc5KydzRNEMEEupUO74UZdNdRrHblTFFrrdmvyDubC1b
4sKULKyQeCtUTgqOp/8SFpfBhWscQseZFVOX3ikryX8CGeIUAPaRWf0oS8XswJ1Y
kHdBxpaSF0oh/UyW7jR027ueBCJC2QX9I6GPIgQVmrDgRlYfEzRTHoYFOkx7TM/I
W9+CxtRIOHswEHTun9g71QRBLTGzhICTBdN7Imfc+2hoTtXv3kGDq2VchJLnu+1e
P/o6hi6ZOZhqpHrJB1BXVOnQges5VYk4aeF3CqKyw7YG7fIcIxG/aAVyknppHQbt
wcLLRFSNpg8rp20KXsVRBTf9m82oRADpsgAkcv85VwZGLD5zaSl8O/0jLZTwefp+
jSCAt+ue7CAe3fuxRO7X5GA6Zvp1QaNViKOQYc5zYmpz3cFFP/jGWViDiGwDfBKg
KBWPaRfxXTSN1UgDqQPh
=Vc3m
-----END PGP SIGNATURE-----

--E187YRO8KGM40JwS--

--===============6180632977018768501==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6180632977018768501==--
