From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5670: add HS ground control
Date: Wed, 1 Feb 2017 17:43:59 +0000
Message-ID: <20170201174359.buiiybffgk6ya62d@sirena.org.uk>
References: <1482999827-14705-1-git-send-email-bardliao@realtek.com>
 <s5hwpdceuns.wl-tiwai@suse.de>
 <20170201114713.osuuhyomfuswnrgt@sirena.org.uk>
 <s5hy3xqaxa1.wl-tiwai@suse.de>
 <20170201145956.ecoksw7ntapt76n4@sirena.org.uk>
 <s5ha8a6apux.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2513186333865476181=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9501C266E0D
 for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2017 18:44:11 +0100 (CET)
In-Reply-To: <s5ha8a6apux.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, shumingf@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2513186333865476181==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vrl56k4bejzckce2"
Content-Disposition: inline


--vrl56k4bejzckce2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 01, 2017 at 04:32:38PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > Sure, it works on that one machine but if someone else did something
> > similar but using a different GPIO it (from what I remember) might not
> > work.

> For other GPIO pin, you'll need to write another similar codes, sure.
> But why do you need to worry so much about it?  It doesn't work even
> without this patch, and a complete generalization isn't so trivial,
> I'm afraid, as it's anyway pretty device-specific.

I don't know, I need to figure this stuff out which is why the patch is
still in the queue.  If it is just using a regular GPIO then gpiolib is
pretty trivial to use.

--vrl56k4bejzckce2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliSHl8ACgkQJNaLcl1U
h9A0IQf+NpHkBG6AkwSHBoYYPItQlSBZDK/ZtdXGbI05RCitEEeiw3LkOKRzjoin
Yl/nHAGWUPvPg5pflci2/UqkrZ8zZBs/ZYzYc7CVgeRpkEKdR2ckCp3PVKKFrKYC
NahPXKCWgY2eAJmMCKx9kLTrqggTW8Ry7hH60pUa7KJbxaXnBITJI331JGCmUGeB
Jm6fjg4lJqe27a2ZUZ1lBl89dOdAA4j5Gg1s6HdFB3qrZngPCDEdD/TXkjbEistr
iSQUmyw7vBs0TMdfLqT0QW5XYJoJPoZEA25+/tU1YFuDiUg/fLkxXRQAhbPd74D7
3KcY55gBnAqF7zyfXBT/wHLCGZCK1Q==
=+S6M
-----END PGP SIGNATURE-----

--vrl56k4bejzckce2--

--===============2513186333865476181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2513186333865476181==--
