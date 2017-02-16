From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 15/16] ASoC: Intel: bxt: Add jack port
 initialize in bxt_rt298 machine
Date: Thu, 16 Feb 2017 18:56:58 +0000
Message-ID: <20170216185658.relwcxkr357dqjhs@sirena.org.uk>
References: <1486474800-11426-1-git-send-email-jeeja.kp@intel.com>
 <1486474800-11426-16-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6965721431815467421=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F7CD266A02
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 19:57:08 +0100 (CET)
In-Reply-To: <1486474800-11426-16-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jeeja.kp@intel.com
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6965721431815467421==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vf75ouljmsja5zde"
Content-Disposition: inline


--vf75ouljmsja5zde
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 07:09:59PM +0530, jeeja.kp@intel.com wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
>=20
> After the pcm jack is created, create and initialize the pin switch
> widget for each port. Pin switch is to enable/disable the pin when
> monitor is connected/disconnected.
> ---

This has no signoffs at all, I can't do anything with it.  Vinod, you
acked this?

--vf75ouljmsja5zde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlil9fkACgkQJNaLcl1U
h9B0bwf/SKOUV0v+RRRVf1dY2yJXhhx8GvpILP+5boxlPKmwM91Kr5cAEY9DpVKm
bDmt17Bo9OGK2L3FI62OvhKiVUEafTlOL5Q6bijtntqQb81y03ag2ZlFzbS5YvS+
mkbVWe3NGCMy/2x6USz1uCRwq7rq8gjcjCuxgStArRkHX2fGvTmyCsQjq3ZdlpNj
9/vr34Jwxkb3xACjiOgdwNiGi3Yds7bqZhU8w+Gx1oO9HiCBldg71lnAVDU7eTZZ
57uobLxAIkiiOh7woOSVXSs3jc0oF3PTs/JcxDG6fo46hbsjdAkqzCDTg530fBkt
imNIBkt6/XFysUnXjGqN9A3J/uZHnw==
=htcd
-----END PGP SIGNATURE-----

--vf75ouljmsja5zde--

--===============6965721431815467421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6965721431815467421==--
