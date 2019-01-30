From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] ALSA: pcm: implement the anonymous dup
	v3
Date: Wed, 30 Jan 2019 22:32:37 +0000
Message-ID: <20190130223237.GK2804@sirena.org.uk>
References: <20190130124139.10439-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5678681071644026664=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CA0532673DD
 for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2019 23:32:41 +0100 (CET)
In-Reply-To: <20190130124139.10439-1-perex@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Baolin Wang <baolin.wang@linaro.org>, Phil Burk <philburk@google.com>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============5678681071644026664==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IA03tywDYuoVKXrw"
Content-Disposition: inline


--IA03tywDYuoVKXrw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 01:41:37PM +0100, Jaroslav Kysela wrote:
> This patchset contains the anonymous dup implementation with permissions
> checking for the ALSA's PCM interface in kernel to enable the restricted
> DMA sound buffer sharing for the restricted tasks.
>=20
> The code was tested through qemu and it seems to be pretty stable.
>=20
> The initial tinyalsa implementation can be found here:
>=20
>   https://github.com/perexg/tinyalsa/commits/anondup
>=20
> The filtering might be refined. It depends on the real requirements.
> Perhaps, we may create more ioctl groups. Any comments are more than
> welcome.

My understanding based on some off-list discussion is that the Android
security people are going to see anything that involves passing more
than a block of memory (and in particular anything that gives access to
the sound APIs) as a problem.  That's obviously going to be an issue for
anything O_APPEND based.  My understanding is that this is fundamentally
a risk mitigation thing - by not having any of the sound kernel
interfaces available to the applications affected there's no possibility
that any problems in the sound code can cause security issues.

--IA03tywDYuoVKXrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxSJf8ACgkQJNaLcl1U
h9CFvAf+N1vd5sxHUDofLYSh7dXarxYQ5V+TMNhW8delXYfYq5Z48Dp7SfJbSLCA
4luf/Fw2ZZCGSUaXwkepEw2byrLU0sXb5cIf6pgxzNMHTlZErSEpYiosuL41uuay
6IEHeoLmQJCeR6t8PJyikgFmWDt1bq5xRttX2nytOG3QwUY+mAQSlEj7wkaMjgOQ
bVxaBqCbQfzPRWxI/EIUIVod4c9d+PCde4/Z0ojKKi6nhX9b7awCi7HXzML+f6Fh
RDtJCBm9etNBDGJC5bjuGyHU4cbeTxYdpNMZrTLxHQuI5VjVgxcxbRAB3t9WVePk
DrpUuEdANCglCnGkPCMXplwEGBE/aQ==
=Y805
-----END PGP SIGNATURE-----

--IA03tywDYuoVKXrw--

--===============5678681071644026664==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5678681071644026664==--
