From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/5] ASoC: amd: Avoid passing NULL to
	memory allocators
Date: Mon, 4 Feb 2019 22:00:17 +0100
Message-ID: <20190204210017.GL23441@sirena.org.uk>
References: <20190204134222.9560-1-tiwai@suse.de>
 <20190204134222.9560-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0535184146857109305=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CD2826746F
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 22:00:18 +0100 (CET)
In-Reply-To: <20190204134222.9560-4-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Christoph Hellwig <hch@lst.de>
List-Id: alsa-devel@alsa-project.org


--===============0535184146857109305==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="umrsQkkrw7viUWFs"
Content-Disposition: inline


--umrsQkkrw7viUWFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 04, 2019 at 02:42:20PM +0100, Takashi Iwai wrote:
> We should pass a proper non-NULL device object to memory allocators
> although it was accepted in the past.  The card->dev points to the
> most appropriate device object in such a case, so let's put it.

Acked-by: Mark Brown <broonie@kernel.org>

--umrsQkkrw7viUWFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxYp+AACgkQJNaLcl1U
h9AcYgf/d0946XhbjpiUUjEf2Hz5K9L5iBaOJORavVtby3reJb3Vor0LYanyPRoX
kPy48mPXZ0bpGOW7qAr0Vaoanvw/V6PRsdyrb692GMjbvi1ccQsjgCVI+ZlbTbo8
8jgGi/XCuQCmiYjqov+o32UQTwkVqPqFLKxd/8AFuK9EUsC5A7W/1B0PXR8rL+MW
5dcHyHCcarlhFQeH+DA5YZVEBg2vg1bt1gWzLG9zDRkkHPNB5JZUNXpwq9Z0hF9l
gwl+XQzJWKOB7FHUlqFbPV6xY0Hjn75uAmJBJJy0r0fvo4c0dkyT44hSDicLGLsz
rGkxMjB7yS/rJBZy0xmHzkjUgcgJdA==
=lmsi
-----END PGP SIGNATURE-----

--umrsQkkrw7viUWFs--

--===============0535184146857109305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0535184146857109305==--
