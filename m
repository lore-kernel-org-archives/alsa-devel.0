From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 4/8] ASoC: sun8i-codec-analog: Add
 amplifier event to fix first delay
Date: Fri, 10 Feb 2017 12:01:32 +0000
Message-ID: <20170210120132.4w6rv6fagnebfben@sirena.org.uk>
References: <20170202092422.5588-1-mylene.josserand@free-electrons.com>
 <20170202092422.5588-5-mylene.josserand@free-electrons.com>
 <CAGb2v66NXJ5RG8VUbvtZcqXzzOvhRc8A_M1R=2rRpfnHNbZDpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0373087654864803740=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1097C266B81
 for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2017 13:01:54 +0100 (CET)
In-Reply-To: <CAGb2v66NXJ5RG8VUbvtZcqXzzOvhRc8A_M1R=2rRpfnHNbZDpw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============0373087654864803740==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mlu34dj3afso4l2i"
Content-Disposition: inline


--mlu34dj3afso4l2i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 10, 2017 at 02:08:54PM +0800, Chen-Yu Tsai wrote:

> One solution that might work is to mute the headphone output
> while the amp is being charged, by setting SUN8I_ADDA_HP_VOLC_HP_VOL
> to 0, and then restoring the value once it is charged. In other
> words, overriding the value for the duration of sun8i_headphone_amp_event.

This sounds like you want to make it an _AUTODISABLE control.

--mlu34dj3afso4l2i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlidq5sACgkQJNaLcl1U
h9AuTgf/RaIzwJT3vVTeItcdPHqZ9v63JSsnD3/EpUZObZEbndvpyddPq0XJ3gbC
/UTnaZjT06JwJLQqAnDUA3cKYjwJ2wW6RlAttE1nTRo6NxPK9Y+MBaMsv51w61zY
Fb47QvoyUlDZVT1xP7ia7M2VDZFAiz5zK4kqXxvK/Y8kig2OGk/K/HwHqzR8Ic+X
FZi2bIc+fCG3HAtCY7RBt7gAxYiPgM2/2/Wm7CimiD5dqdZOMPVALKN6OT0hbblo
h2t69+FDMp1NTBtf834Kbt2nfoiqSwyVcNJGyM8hNaiiO+0NGQhmkfvqdi9+H4dF
hUT9UNSm2XpscvKATeOjSX4ABCgVag==
=LMB2
-----END PGP SIGNATURE-----

--mlu34dj3afso4l2i--

--===============0373087654864803740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0373087654864803740==--
