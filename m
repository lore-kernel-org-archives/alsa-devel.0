From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: Add GPIO based jack device
Date: Tue, 26 May 2015 23:10:34 +0100
Message-ID: <20150526221034.GC21577@sirena.org.uk>
References: <1432661622-4901-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6326449463601952795=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C337261ADE
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 00:10:42 +0200 (CEST)
In-Reply-To: <1432661622-4901-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, zhengxing@rock-chips.com
List-Id: alsa-devel@alsa-project.org


--===============6326449463601952795==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eFSocvuHqSR2dX+c"
Content-Disposition: inline


--eFSocvuHqSR2dX+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 26, 2015 at 10:33:42AM -0700, Dylan Reid wrote:

> +Required properties:
> +
> +- compatible				: "linux,gpio-audio-jack"

As mentioned in the discussion of v1 I think we should drop gpio- from
this - Lars is right that we should really be more generic and there's
no reason this can't serve as a non-GPIO jack especially given that...

> +
> +Optional properties:
> +
> +- gpio-audio-jack,jack-name		: Name of the jack. Normally
> +					  'Headphone Jack', 'Mic Jack', or
> +					  'Headset Jack'
> +- gpio-audio-jack,sw-det-gpios		: Reference to GPIOs that signals when
> +					  a jack is plugged.

...GPIOs are optional anyway!  However I think Lars had further concerns
about abstraction which I seem to have missed.

--eFSocvuHqSR2dX+c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZO9aAAoJECTWi3JdVIfQ5yQH/0uzYZXnpZAxyKGB6ybYHOS/
gCQ6/VyDo/ezkz9OMvIfp3D35s2ewSwUQ4HlKOqcdFC+gf6Y0E2YyIOP/Erc4r/Z
04y7lrY35Dn5/p/4wPb+7T/Jskj6DIBsjUj3OC/LzNS6hnynO5COQjfY3Egskrrj
sCYoJJ9n7Z9GMbUKjx2XKQ3ekobvTASLoVFbfYty5KVdTO2Sq9kp0ys+EjMATGnB
Rw377W8E8qm/dpQuUNx5Hujst+oDXQwRYa8VQZJolfGaK7bvr9XBcMZ6ng5uIHdu
7sWMomm856l2ev3o5tclviqtkpNJhFHwqXCHNVq5BNZjshX8pNb+rw1da8N124o=
=7NAm
-----END PGP SIGNATURE-----

--eFSocvuHqSR2dX+c--

--===============6326449463601952795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6326449463601952795==--
