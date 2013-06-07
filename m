From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: WM8962: Set CLKREG_OVD if GP5_FN is
 not its reset value
Date: Fri, 7 Jun 2013 17:48:45 +0100
Message-ID: <20130607164845.GX31367@sirena.org.uk>
References: <1370607258-4750-1-git-send-email-b42378@freescale.com>
 <20130607143905.GT31367@sirena.org.uk>
 <E31481825E4C03459FC878EE97CB2EFD02FDA184@039-SN2MPN1-023.039d.mgd.msft.net>
 <20130607154620.GV31367@sirena.org.uk>
 <E31481825E4C03459FC878EE97CB2EFD02FDA1FB@039-SN2MPN1-023.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6897770083840173961=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 97616265772
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 18:48:51 +0200 (CEST)
In-Reply-To: <E31481825E4C03459FC878EE97CB2EFD02FDA1FB@039-SN2MPN1-023.039d.mgd.msft.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen Guangyu-B42378 <B42378@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


--===============6897770083840173961==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kmmpJMbv/pvGcJCj"
Content-Disposition: inline


--kmmpJMbv/pvGcJCj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 07, 2013 at 04:29:49PM +0000, Chen Guangyu-B42378 wrote:
> On Fri, Jun 07, 2013, Mark Brown wrote:

> > The point is that there's more work needed to recover the device state
> > here, you're only doing one of the several things that need to be done
> > after the device has been restored.

> That's because I'm too scared to put too many code into my single patch :(

Ah, OK.  In this case you're being too conservative - there's a whole
batch of initialistion which is missing, the simplest thing is to pull
the lot over since if one bit is missing the others almost certainly are
too.

> Sir, I'm so glad you can fix this issue with such a quick response.
> I'll test that patch tomorrow moring (midnight here) and give you a feedback.

Note that I haven't tested that patch at all (well, I compiled it but
who knows if it runs or not).

--kmmpJMbv/pvGcJCj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRsg7qAAoJELSic+t+oim9knUP/jEa/14fjalxV0dP4aBfY7Lx
RlavH1jEghodNkhoUXQ7mXN/sqhtemlmHKcNK/ljzJLVsp9fYM6chtIflmkrNhLu
mjHSF0RXtf4McfNl90+ow7jnve2O+T3J0yE97NKoFBevvs6J7KRpDQE8oactPWxr
IhNq2o7VWQy3gjPHS4b17GTaZydWcs3ZW3VXvxgm+aa1OiuVEZulogXmWRhdFOtM
hUfTNl6Ya9X3T2GUob9H3V6umi0lVj1AiXRLelrRi20bZA8mhiBbzOtlsdZX/KA6
TgV3U0MxgkO2nCWYmsLcvCGtcmStTGPeme106XH03HCuuT9J9hkfyv9DYaVyoSYA
ppKF/BvfRJatAD58TlCYdBpJz4NI6gFqLsQgk83R0Qcvi1Kg00Vxx9qdNQ427BTG
us/R8aB2rhaClRL7hE8fnXP0qJejG+n0f3Nt1DDdc5oWbKiXQr7UO/ir5moGvffG
Jw68UsDBge4yIKl7IdLmDkskbLFZJ0Zl8CtSpLhSe+pkZJYL7yKyG38rkE3M7Snf
U5cH4UzmPTENlGFIhg2m50V1Inibi45li5JPDAUr2gzYXIrsd1ce8Id7rOOioQkN
HEYW3trm6Es9Oj2ibYXOwNb2hDUIZHvwB3VvxZyc6Wr22ieES4YWRD+1ml1B9i7o
AMkILpnzG7+EVs1DHHXn
=XS/M
-----END PGP SIGNATURE-----

--kmmpJMbv/pvGcJCj--

--===============6897770083840173961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6897770083840173961==--
