From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound: Convert timers to use timer_setup()
Date: Thu, 26 Oct 2017 09:09:17 +0200
Message-ID: <20171026070917.4et4xygn66xleteq@sirena.org.uk>
References: <20171025150927.GA12207@beast>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7369175289326173371=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D5409266A0C
 for <alsa-devel@alsa-project.org>; Thu, 26 Oct 2017 09:09:25 +0200 (CEST)
In-Reply-To: <20171025150927.GA12207@beast>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kees Cook <keescook@chromium.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Bard Liao <bardliao@realtek.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============7369175289326173371==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pfp3bxtbdgepfq2y"
Content-Disposition: inline


--pfp3bxtbdgepfq2y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 25, 2017 at 08:09:27AM -0700, Kees Cook wrote:
> In preparation for unconditionally passing the struct timer_list
> pointer to all timer callbacks, switch to using the new timer_setup()
> and from_timer() to pass the timer pointer explicitly. These are all the
> "mechanical" changes remaining in the sound subsystem.

Acked-by: Mark Brown <broonie@kernel.org>

--pfp3bxtbdgepfq2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnxihwACgkQJNaLcl1U
h9AZJwf9EjaNuV3RQlO77RKx4oyVqQsk1Nbn/Te0m9AHi0WY1I36MoFYQT1NOdPV
UIHp1Xg7ir4umKyDD/GUUGL/9FzVJMFd/RhTbPlYZIR72IwwTmC67LCul7hWa7gz
iYmLlR7H8eBaXD/oYBd+wgzNUpqoHReyTX1RhBHdf68NJpsdE10s8Z9/7vRIIqKt
0tXHXSnnT/vCM9U9MFrLqcaVGqabpH7Hfg089FP0oLgBpmE7S3t0zQXVZFJyrONl
FvVWz7CUCShEgy3VgML9DhYPTMRJpL+Gwql9M2ZVYBwh4A06Jj+z0gR+cxdbAo1F
MlL0wB1KteLC9wBxDchnkA4HmkZPTQ==
=AIPw
-----END PGP SIGNATURE-----

--pfp3bxtbdgepfq2y--

--===============7369175289326173371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7369175289326173371==--
