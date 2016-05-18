From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/1] ASoC: core: Do not print an actual
 error when deferring probe
Date: Wed, 18 May 2016 16:20:28 +0100
Message-ID: <20160518152028.GM8104@sirena.org.uk>
References: <1463584020-6085-1-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6324847755602396137=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 830E826052B
 for <alsa-devel@alsa-project.org>; Wed, 18 May 2016 17:20:39 +0200 (CEST)
In-Reply-To: <1463584020-6085-1-git-send-email-alexander.stein@systec-electronic.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Ricard Wanderlof <ricard.wanderlof@axis.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6324847755602396137==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9Jdw4pA1x1k2W7MG"
Content-Disposition: inline


--9Jdw4pA1x1k2W7MG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 18, 2016 at 05:07:00PM +0200, Alexander Stein wrote:
> In case there is no DAI (yet), do not print an error, this might happen
> a lot of times. Print a notice instead.

Oh, and the other thing about this which I should have mentioned is that
it applies to every single resource acquisition in the kernel - this
needs addressing at a global error rather than piecemeal.  Raphael was
intending to work on avoiding probe deferral in the first place by
sorting probe and there were also some proposals to have a helper for
printing error messages which would suppress the display of probe
deferral errors before the final run at late initcall.  Obviously the
second mechanism is substantially simpler to implement.

--9Jdw4pA1x1k2W7MG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXPIg7AAoJECTWi3JdVIfQSCUH+wbLiCj3YA4igx/4H9L9vfiP
uwGFg9ARUv6OqQLJSL13XX+U9mPeOpgbSXwipXSO0CyrsgoRRj7zbW2e/1RiV9O6
JfFi5bBL7nRRGtRuP5QOzn7hufbXJUGQGuyTPXyvOwTvgyorVjmHK2Icu6zdE4Ky
MSZqGNwVOiMqyQBRZm4NVDbdFFmV4+u66nclElZYE5CBSFrI71LFqOfWw1Dyl36S
EUJVimsjb0yQZL78Akgpx9HBFH9CzGrEyN+laNSVG/bKMKln2xZcUpoNuIQagzVH
4XnbKsFbwE53lFvXnn5O2WWZcK6MFGGTQeiN7+oZYxRkQBBK2TYSLLF+nopicNk=
=n6Ln
-----END PGP SIGNATURE-----

--9Jdw4pA1x1k2W7MG--

--===============6324847755602396137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6324847755602396137==--
