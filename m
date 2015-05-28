From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm_adsp: Dump DSP_SCRATCH1 on DSP
	shutdown
Date: Thu, 28 May 2015 15:37:24 +0100
Message-ID: <20150528143724.GY21577@sirena.org.uk>
References: <1432820714-31850-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <20150528135751.GV21577@sirena.org.uk>
 <20150528142431.GA19558@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7000898161443182579=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7084D2604AB
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 16:37:31 +0200 (CEST)
In-Reply-To: <20150528142431.GA19558@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============7000898161443182579==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6i9pF6wS+qS3ofr4"
Content-Disposition: inline


--6i9pF6wS+qS3ofr4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2015 at 03:24:39PM +0100, Richard Fitzgerald wrote:
> On Thu, May 28, 2015 at 02:57:51PM +0100, Mark Brown wrote:

> > > -		adsp_dbg(dsp, "Shutdown complete\n");
> > > +		adsp_info(dsp, "Shutdown complete (SCRATCH1:0x%x)\n", scratch1);

> > That seems a bit loud for a diagnostic message, why raise the severity?

> It's a diagnostic of the firmware, not the driver, and we can't assume that
> people trying to use a firmware have the ability to build and flash a kernel
> with a debug version of the driver

The default is that dev_dbg() is available in dmesg but not on the
console which usually seems like a reasonable balance for this sort of
thing - it's there if people want it but not included in the default
logging.

--6i9pF6wS+qS3ofr4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZygjAAoJECTWi3JdVIfQ/SYH/0wlkr2UVYm1AnE2qsEAK7zD
/YEqw+yTjv9g2wB+dvKvqHSngRa+A+s8QvBabjklF/92kxYnNv4BIWpNqh0xigUe
uPJMys+8+9b5yg9Vi4b6ea1eLrBi5IodF+mKO2op3RTKqxyRnOQmaQ4GLemTBBDk
CQYUerMQpeQci2ZykYGrdKLU7+QPVEYB6FozZSrMoe7VPiLsK6KoBcWQ+HWU7MYO
e6+iPAO8o8V3jQGvoOBi6+TUd1FtbC6PgtdQSlXoZ5eGKjcmjPaQPzvz0I8uc39q
z6R2wGjnG/AUP8110s17TrPrA23/Z6BAszhM3mBanoPKnBoIsvydhh0Al2vb/Tc=
=/sSc
-----END PGP SIGNATURE-----

--6i9pF6wS+qS3ofr4--

--===============7000898161443182579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7000898161443182579==--
