From: Mark Brown <broonie@kernel.org>
Subject: Re: SGTL500 and its external MCLK
Date: Wed, 13 Aug 2014 21:39:07 +0100
Message-ID: <20140813203907.GV17528@sirena.org.uk>
References: <CAKON4OxRr-igCSZ2HwXcKGFT7O6sQjJUMP_aF19kSRP59ZxFew@mail.gmail.com>
 <20140808052901.GA6028@MrMyself>
 <CAKON4OwgT8=moQUPugpR8CfPNkJomDGpHob0CRnzRSd4eC7kQg@mail.gmail.com>
 <CAKON4OzHeB-bJKj_hB=L84jMROz-7vRgp7uqb45KLg4VHva2Zw@mail.gmail.com>
 <20140811055015.GA12969@MrMyself>
 <CAKON4OwMSTGv4W-7Z5pQcZcPyE6mV1NbeUcXw7qbt2UCQLdz=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7585099680681555694=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C49132655BA
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 22:39:14 +0200 (CEST)
In-Reply-To: <CAKON4OwMSTGv4W-7Z5pQcZcPyE6mV1NbeUcXw7qbt2UCQLdz=w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, zengzm.kernel@gmail.com, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============7585099680681555694==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w/ZA3lwB+t9Y4OJB"
Content-Disposition: inline


--w/ZA3lwB+t9Y4OJB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 11, 2014 at 08:29:01AM -0400, jonsmirl@gmail.com wrote:

> Mark - how is clock accuracy supposed to be handled in ALSA? Should my
> clocks tell their true rate 22.571428Mhz or lie and say they are
> 22.5792Mhz?

> Are there problems with division truncation from the slightly low
> clock rate lurking in the ALSA code that I need to avoid?

I don't think ALSA should be having to deal with tiny inaccuracies;
ideally the clock API would have some sort of accuracy management in it
(in much the same way that the regulator API does) but otherwise just
impedence match at the edge of the code.

--w/ZA3lwB+t9Y4OJB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT68znAAoJELSic+t+oim9a3EP/iTjlIjSYp3fbdSnFxG/Rug/
9mmRkHbuRcarUKcmIrGIJUFjUGF+CCWLxy91iIifyl/G8LySB8zbFXTd7Cqd9afP
Paxpvb5s1oFsYKgmPfRkJsc1OHKH2mAdUSEp7sNSwf3ajJ//YMd1YCF1+L2D0SsV
47IBN73OYcRDoI3gYrX9s182szwC2wJo2b8CBJK9R/Wg3OVmfZ/lHW7DFXiVNKjL
FELmSKnWO+czIt9lUMWJXDl6shtEnaRuX9xzRgz4K/q3ncIYFuiJd1YCvG4pkPUd
Yvc6nZrt7yBAg4mmgVVVzRrLLWeQI5zEnUxvzyDcwqofalNnQJ2oF8C5JKJklJ70
6Ru2mCcoLGPzs+LRguCNrQrB9L4umnBIOiFEE2LqorKv2IlGelhWa4DjQd1ffyBj
vgs1iEWCSUnqmKU2a5NXLMRqgVnSRbOIwbcn4t9STxNaJZY/2Kv7CErTpIdRqSL1
Hpl9dfbV3cr2Guex8hLE5MVK21oCWCJCUOMfFfj5y8JC7wxVw96h74pFJsjpFDkX
JviDhRuqpxfXBOCkw9S5uXdwAhrMZJaZ2l1WKHwlyxlavKpNcAOfE8PK0IKc6vg8
0igGlhbHmAf+9LClNLQJQA0wCs5qYp6EIgkBOv8doxYoKIc/9Cpk161wr2TTRaFs
kix3oejy5abNgVTu5IBH
=y1mm
-----END PGP SIGNATURE-----

--w/ZA3lwB+t9Y4OJB--

--===============7585099680681555694==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7585099680681555694==--
