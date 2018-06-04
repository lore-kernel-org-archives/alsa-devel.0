From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: delete dapm_kcontrol_data
 paths entry before freeing
Date: Mon, 4 Jun 2018 11:45:41 +0100
Message-ID: <20180604104541.GB7536@sirena.org.uk>
References: <20180601225334.19064-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7828174497593275602=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E82626786E
 for <alsa-devel@alsa-project.org>; Mon,  4 Jun 2018 12:45:44 +0200 (CEST)
In-Reply-To: <20180601225334.19064-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-arm-msm@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============7828174497593275602==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 11:53:34PM +0100, Srinivas Kandagatla wrote:

> Below is the kernel BUG with SLAB Poisoning

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> BUG kmalloc-128 (Tainted: G        W        ): Poison overwritten
> -------------------------------------------------------------------------=
----
>=20
> Disabling lock debugging due to kernel taint
> INFO: 0xffff80003cf1c310-0xffff80003cf1c31f. First byte 0x10 instead of 0=
x6b
> INFO: Allocated in dapm_kcontrol_data_alloc.isra.37+0x34/0x2a8 age=3D6929=
 cpu=3D0 pid=3D50
>  __slab_alloc.isra.24+0x24/0x38
>  kmem_cache_alloc+0x190/0x1d8

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsVGFQACgkQJNaLcl1U
h9DFlQf+KuP/lW/iPvlcjQ0oZp8RvCj0F1kfnQuRB5G/+5QM5yzH9aEVgIcK5JYq
lcWNVkYmd+c8wa8xyWDcObTGfJIzo5cVWqoau4VoemZspU7VgH74X/SSTcynZiTQ
LYoWZ6b6yIL3yfQUlbB65qxCkxFxza96Lug6keLwbsHiGCrO1yF/izzaE7MPswZV
oBHlJoEVG5VYpKxBc5BsqUSUVJRX1afbQ6F8iouUgGTttm6fLq5k4prfsojBg46G
uYHp4O3fNEAtkWR46h9XcogwlsGal4B/hEpZAcLdx89GTrh9192uwhcPaG+Ho2+R
Y+vuAJgm2G2wsDN4/wmIcOsN52CV2A==
=v59X
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--

--===============7828174497593275602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7828174497593275602==--
