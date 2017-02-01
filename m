From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5670: add HS ground control
Date: Wed, 1 Feb 2017 14:59:56 +0000
Message-ID: <20170201145956.ecoksw7ntapt76n4@sirena.org.uk>
References: <1482999827-14705-1-git-send-email-bardliao@realtek.com>
 <s5hwpdceuns.wl-tiwai@suse.de>
 <20170201114713.osuuhyomfuswnrgt@sirena.org.uk>
 <s5hy3xqaxa1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5038806247017381751=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 578F7267480
 for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2017 16:00:09 +0100 (CET)
In-Reply-To: <s5hy3xqaxa1.wl-tiwai@suse.de>
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


--===============5038806247017381751==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lsdfkfnvve4gdqip"
Content-Disposition: inline


--lsdfkfnvve4gdqip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 01, 2017 at 01:52:22PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > No, it's complicated.  IIRC it's not *actually* doing GPIO management,
> > it's adding an option to wiggle a pin on the one board you've so far
> > that happens to have this issue but if someone finds a GPIO from
> > somewhere else it'll run into trouble.

> How that can happen?  It applies only via DMI matching.

Sure, it works on that one machine but if someone else did something
similar but using a different GPIO it (from what I remember) might not
work.  I think I was going to try to figure out if it was really a GPIO
or if perhaps the changelog is just not clear.

But anyway, content free ping so...

--lsdfkfnvve4gdqip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliR9+wACgkQJNaLcl1U
h9BshQf/RSGuJxi2M41DVSUZKcp6PLePYsbCtI8CvvmpzZxbEP+6BBj/QDvZQXH8
rmWYPgCFGo1nD7JtxMwcT7fSeCLmGTgZip/xUHqLHimr9x0q0bkdRsJIRjAGbmTb
v2cHDWMICRNeHE/bFVnpMF265UB7kRowMUARP08fpAYD9X3bmGX3FK/6cny/HBVy
V9F9nMEpe3YSaRG9ijVajgo/ktTzv6lCAwQKoc9lvvLPCUQmQ/OPA56R6Ws0ofAG
luxMJx5W1Sx14Zdb/BFw7eF8yT9YgCWtYhwmwDNGON1ovEigncN/FlVXqjaCR+96
xLkcUk+tz2AVysNT5uumB6OfV9L9Mw==
=cpGP
-----END PGP SIGNATURE-----

--lsdfkfnvve4gdqip--

--===============5038806247017381751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5038806247017381751==--
