From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Fix pcm stream context
	restore crash
Date: Mon, 19 May 2014 17:30:47 +0100
Message-ID: <20140519163047.GF12304@sirena.org.uk>
References: <1400487263-3951-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7691449064180070093=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B45F6260851
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 18:30:59 +0200 (CEST)
In-Reply-To: <1400487263-3951-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Kevin Strasser <kevin.strasser@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7691449064180070093==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wKRKuOrQv91LW7qn"
Content-Disposition: inline


--wKRKuOrQv91LW7qn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2014 at 11:14:23AM +0300, Jarkko Nikula wrote:
> From: Kevin Strasser <kevin.strasser@intel.com>
>=20
> In some cases the pcm stream is closed while context has been
> scheduled to be restored, causing a null pointer deref panic.
> Cancel work to ensure stream does not get freed while work is
> still active/pending.

Applied, thanks.

--wKRKuOrQv91LW7qn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTejG0AAoJELSic+t+oim9yvUP/jpZ8lgOMTnxSRnXHLiyx+rd
ISrIStTjDhheZWDaUG2hHo2kONeE8SEdS0DoXJTQ+5Ko2o4Yu7a8SshS9pjAG7Yj
gvu+rm/JzD5xYOad5fLIr4QjS3oy50kX07mL9rr6IQwVJOMcTQcaf45+QauSLsO/
GhcnZcn5YEX1o4YWo0oFdtmph3f+0oW9upr3liXrjWIfeUvobO7VsvljDRf2qbn/
rY09djdbRlDhsIb+VzXrBZjhY4lzaFp2dOFMh8jFSp82a+6WxaeY6RMgmie+xYQ9
5tIgyIb1OG1l3MtHTnFJAiYpYYjaOjaRF6MOUfvVBuMEKN4KEzK0MUgTDdzWNnj0
HZ4YiuMg0MtX2DCMKskiFQQg6OI2+35aBeEWrTq9bcQNx2vWVQss/LoTq9BJl79G
KjUQ2f/+I3KjUfHrZ6ZbddcSiE7MCLm+5qo0SDJ42r+cewVdN8zMTemKH3xKB83L
pdbs3u5ZgyOeSeWj3w9lIjBdN90DqcYeARs6U9tC7NBo689sW9UE76k08d27t6nU
xcGPIqDio4uFIeVJf7IdIvymr7Wq8Lv8GfmNstvarqsgzZr1bpb8qjlhQCVcWZj/
4Vcp17KRoMG48IO7sPWKfzBEjMrf3nRoHOpw4+SArsp7dHk+mKZnH273uBV9zuu2
GPN3IqWx56SfEHQ3D18u
=9pPV
-----END PGP SIGNATURE-----

--wKRKuOrQv91LW7qn--

--===============7691449064180070093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7691449064180070093==--
