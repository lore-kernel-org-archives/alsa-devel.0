From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mediatek: Use current HW pointer for
 pointer callback
Date: Thu, 3 Dec 2015 14:56:12 +0000
Message-ID: <20151203145612.GF5727@sirena.org.uk>
References: <1449129208-63615-1-git-send-email-koro.chen@mediatek.com>
 <s5h8u5b98dp.wl-tiwai@suse.de>
 <20151203110158.GD5727@sirena.org.uk>
 <s5hfuzjn635.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3984711528835985444=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6779B260429
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 15:56:29 +0100 (CET)
In-Reply-To: <s5hfuzjn635.wl-tiwai@suse.de>
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
Cc: Koro Chen <koro.chen@mediatek.com>, srv_heupstream@mediatek.com, s.hauer@pengutronix.de, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3984711528835985444==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gneEPciiIl/aKvOT"
Content-Disposition: inline


--gneEPciiIl/aKvOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 03, 2015 at 12:07:26PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Thu, Dec 03, 2015 at 10:41:38AM +0100, Takashi Iwai wrote:

> > > While reading this patch, I wondered how regmap can be used safely in
> > > an irq-disabled context.  Mark, do we have any API for that?

> > We can use user supplied locks or spin_lock_irqsave().

> I meant how to guarantee to make regmap_read() working in an already
> spin-locked context, typically in an irq handler?  regmap_read()
> involves with the regcache and it may invoke kmalloc().

I know that's what you meant - that should be done by preallocating the
cache (which can be done with defaults) and providing your own lock
if there's a spinlock already held (since we use _irqsave() which IIRC
isn't nestable).  We can also use GFP_ATOMIC for some of the allocations
in reasonable use cases but it's not in general supported.

--gneEPciiIl/aKvOT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWYFgLAAoJECTWi3JdVIfQshMH/1f+2R0EI/UaBMiaMm4uXBCo
+NvM9ef0R8WKSz6VJPlovVywMxEucpPJW/rmv1eXajVlwv12XaswNLTs+Ys6Wxf6
FGzyzwM2ltkFR3Ks9sHXSdRB0MhjQuQIf7a+6DYHUiVUq2vwjq/VrDxplAYGSk/2
7JmAQIpVmZHZ9jj9nDiAoxa6vLKESm8aMwOy+gxI/60b/2bCcisjqrBwxJin7Uie
qzgiGr7qhFBRFowBAEvoxi8zTLW/OvQdO8ZTrTAWBOJkN+bi8lxXjnY5F8woW6de
3n0PWhHknatINmpyUuM4KDdr+F8lH5tYAjFMCsQnMA5B293Y5wnj8ZZVAS+G3E8=
=ML7L
-----END PGP SIGNATURE-----

--gneEPciiIl/aKvOT--

--===============3984711528835985444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3984711528835985444==--
