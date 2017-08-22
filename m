From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/9] ASoC: cygnus: Update bindings for
	audio clock changes
Date: Tue, 22 Aug 2017 17:07:03 +0100
Message-ID: <20170822160703.nusf7sv6k4gj3pti@sirena.org.uk>
References: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
 <1502748417-26417-3-git-send-email-lori.hikichi@broadcom.com>
 <20170815171424.whcy4mftex6sgzgj@sirena.org.uk>
 <d7e7144b-26c7-b96a-663d-03744bb60c36@broadcom.com>
 <20170816105954.ve434zeeqinweo5a@sirena.org.uk>
 <8c2fc92d-5ea8-8163-a588-0a4cba55e0f8@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3852886840588034674=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A703266F0E
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 18:07:13 +0200 (CEST)
In-Reply-To: <8c2fc92d-5ea8-8163-a588-0a4cba55e0f8@broadcom.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lori Hikichi <lori.hikichi@broadcom.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3852886840588034674==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hevtcrkb534i7il6"
Content-Disposition: inline


--hevtcrkb534i7il6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 16, 2017 at 12:39:42PM -0700, Lori Hikichi wrote:

> By far the most common usage case for Cygnus is a configuration which
> uses only the three i2s/tdm ports. In this case each port is assigned
> a clock.  Each clock has the same capabilities so there would never be
> a reason change the static mapping.

The usual reason would be to bring things into sync.

> Now for the case when the "non-audio block" uses one of these clocks.
> In this situation we will only need one i2s port because this
> configuration of the chip is not audio intensive.  When the system
> is designed we know if this non-audio block will be in use, it is not
> a runtime configurable thing. Again, a static mapping is fine.

Is this limitation when the other block is in use a physical limitation
or is it just a case of not seeing the use case.

> At the time it did not seem necessary to make addition driver changes to
> support a use case that will very likely never arise. As it turns out,
> we are working on a new version of this audio block.  The clocking
> configuration for this new version is more complex and I am already in
> the process of creating clock bindings for all this this. I am hopeful
> that the driver for this new version will be applicable to Cygnus.

If the clocking is more complex that seems like even more reason to not
fix this in the binding, and possibly to do as I think I suggested
earlier and use the common clock bindings to manage this rather than
doing something custom and driver specific.

--hevtcrkb534i7il6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmcVqYACgkQJNaLcl1U
h9C07Af/biWixLamc+SRgzNKdbhAkvZYpPHMqaJazZcY6ld35k7fSdRzZXZBePyC
XKI36qdYqJymPBjYVzkt8ASqLHCfbFFMxnZOO5Fzhc/maTPfCHQcyzDd2f1pgOS+
qZ43QsbIBVMGqxgQ9UMMarF7qB6IVBTp1JFck/vSTkE1NraWqxgq5rOH+Oed83nd
lVMlSWKEEYoAV7nyekdxFwCKjZRXWWjhXoJPehfs3yhDvBWhVqvGhGQHQl+4+wvj
8BAk2+z88Mm73AvycpzH6aGe4ZvmaNYUtShp6vgPkLRbpAvCXysM8X2Kh4SZDiMW
LteDB8vVBfDfEwlD8q+qWH5okTkRtg==
=u4Fr
-----END PGP SIGNATURE-----

--hevtcrkb534i7il6--

--===============3852886840588034674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3852886840588034674==--
