From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] ALSA: pcm: implement the anonymous dup
Date: Tue, 29 Jan 2019 19:48:48 +0000
Message-ID: <20190129194848.GM10524@sirena.org.uk>
References: <20190129175909.17423-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3939650061063961291=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 50EB82674B9
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 20:48:51 +0100 (CET)
In-Reply-To: <20190129175909.17423-1-perex@perex.cz>
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


--===============3939650061063961291==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CgTrtGVSVGoxAIFj"
Content-Disposition: inline


--CgTrtGVSVGoxAIFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 29, 2019 at 06:59:06PM +0100, Jaroslav Kysela wrote:
> This patchset contains the anonymous dup implementation with permissions
> checking for the ALSA's PCM interface in kernel to enable the restricted
> DMA sound buffer sharing for the restricted tasks.

> The code was tested through qemu and it seems to be pretty stable.

> The initial tinyalsa implementation can be found here:

>   https://github.com/perexg/tinyalsa/commits/anondup

> The filtering might be refined. It depends on the real requirements.
> Perhaps, we may create more ioctl groups. Any comments are more than
> welcome.

Thanks for looking at this!  Copying in Phil who is probably best placed
to review these from an Android perspective.

> Cc: Mark Brown <broonie@kernel.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Baolin Wang <baolin.wang@linaro.org>
>=20
> Jaroslav Kysela (3):
>   ALSA: pcm: implement the anonymous dup (inode file descriptor)
>   ALSA: pcm: remove the file member from struct pcm
>   ALSA: pcm: implement the ioctl/mmap filter for the anonymous dup
>=20
>  include/sound/pcm.h         |  10 +--
>  include/uapi/sound/asound.h |  12 +++-
>  sound/core/oss/pcm_oss.c    |   3 +-
>  sound/core/pcm.c            |  48 +++++++++-----
>  sound/core/pcm_compat.c     |   1 +
>  sound/core/pcm_native.c     | 154 ++++++++++++++++++++++++++++++++++++++=
+++---
>  6 files changed, 195 insertions(+), 33 deletions(-)
>=20
> --=20
> 2.13.6

--CgTrtGVSVGoxAIFj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxQrh8ACgkQJNaLcl1U
h9BKegf9GSpPgMsSZ8+baI488sSxFArgNtmkz/Up3BYdJQqJ9rzs72vy75bC8w30
FBAcek/uFv3LfyutjRwYXi/tWdppUsZ3zvScwjYFS4PbEYTKOzawrooUiBnVvMxB
vlFjvHz4euRp9nbQMAX0j/QrZYmGQHILqUkIxzauh5i28SZV8TxO1LqMycHJrKiT
+caheQu/vCzMxoHVUOTG8g0iNMstTaUkYlAOb2kVjejApW0RyvJfYXU8JIdIvL/9
ds6GAfr9VMFDUo01W9Qi1n5ufnyHIv69sSTx5MgAoGqK7/0z3MGDggcnJYYq/9nN
a3iAT04jnHdg5TGMaV8LCU0w0JXdhw==
=HQeR
-----END PGP SIGNATURE-----

--CgTrtGVSVGoxAIFj--

--===============3939650061063961291==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3939650061063961291==--
