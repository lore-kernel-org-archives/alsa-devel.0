From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2] ASoC: Intel: sst-acpi: Request firmware
 before SST platform driver probing
Date: Wed, 19 Feb 2014 21:25:06 +0900
Message-ID: <20140219122506.GN2669@sirena.org.uk>
References: <1392798638-20767-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8952434479719832943=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 79742264EF5
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 13:26:45 +0100 (CET)
Received: from e0109-106-188-144-10.uqwimax.jp ([106.188.144.10]
 helo=finisterre)
 by cassiel.sirena.org.uk with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <broonie@sirena.org.uk>)
 id 1WG6Eb-0004km-SB
 for alsa-devel@alsa-project.org; Wed, 19 Feb 2014 12:26:45 +0000
In-Reply-To: <1392798638-20767-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8952434479719832943==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2/mAtxZX6gnegJf6"
Content-Disposition: inline


--2/mAtxZX6gnegJf6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2014 at 10:30:38AM +0200, Jarkko Nikula wrote:
> We originally thought to request SST audio DSP firmware during the SST
> platform driver initialization. However plain request_firmware doesn't
> work in driver probe paths if userspace is not ready to handle it. For
> instance when drivers are built-in.

The more usual thing to do here is to only request the firmware when the
device is actually being used (in this case on open).  This also allows
the firmware to be replaced easily at runtime which is helpful too.  It
seems like this is still an improvement though so I've applied it.

--2/mAtxZX6gnegJf6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBKKfAAoJELSic+t+oim9pMIP/2gfNlQ/d8heLMx6GyZ9q5BV
W2l8WzZLZIYagGH4GXVud+c73Mv9A+/u1eWta9TwatLM/imSGIy1ab76H9aGkmma
+B/caIswfBTVqd6yYpVk5RIHkcltB+j57v38yhL2O0cP220sahsaM47bJjal1LgA
ZfZHmDneqym5A0t9EIntAjJfaDtNCza+Z8k2Bsfh4oytRDkrWwQze4sff8LniXQl
wxtS/TifMGopWlsl1+5qVHij8oCuUFagNrJe9h6/s6AGCXEVxLVm9/ZyatT/bVzQ
cnTjuugk8L1BNx4668cTisYQSHJ5NcmQhbwkJLjmyC0dhDEVUcFIoX+rMOuBImSF
JxWRJc5fDwHcA1shylakdaXQGDKUwG4GzM12+UBg6zDmv3Fks3co1A//JlqJF4R5
e7dYbAD3BusBecMTs19NNPeGWiNnHqDXQG90seKTdK7wnol0ImQxOXEUzTWH73Hh
mkGAjEeLifXV/dllQKSJTTTTWnSIF7reFOBtUnAMB5LCpI/KQb0pkbKJVdP9p515
tj5QQ0H36lWgOLU78DuPhj53b+XDJ+zGGUtrzqWlrESkud4piKDd4swwoZ26dKtE
BHTmBunNHs59qsLkHh4k1jT34hDh2nLUZsvw1KDig05r7B4IdQRXfuBUCineIDKB
MrEtImUCW8FrxPuV7tHY
=NdIv
-----END PGP SIGNATURE-----

--2/mAtxZX6gnegJf6--

--===============8952434479719832943==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8952434479719832943==--
