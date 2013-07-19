From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: sirf: add sirf platform driver
 which provides DMA
Date: Fri, 19 Jul 2013 17:12:52 +0100
Message-ID: <20130719161252.GK9858@sirena.org.uk>
References: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
 <1374232042-26088-2-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7561764700611903624=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5578B265748
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 18:12:55 +0200 (CEST)
In-Reply-To: <1374232042-26088-2-git-send-email-Baohua.Song@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, Workgroup.Linux@csr.com, Rongjun Ying <Rongjun.Ying@csr.com>, Barry Song <Baohua.Song@csr.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7561764700611903624==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1y1tiN5hVw5cPBDe"
Content-Disposition: inline


--1y1tiN5hVw5cPBDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 19, 2013 at 07:07:17PM +0800, Barry Song wrote:

> index 0000000..3678aed
> --- /dev/null
> +++ b/sound/soc/sirf/Kconfig
> @@ -0,0 +1,4 @@
> +config SND_SIRF_SOC
> +	tristate "Platform DMA driver for the SiRF SoC chips"
> +	depends on ARCH_SIRF && SND_SOC
> +	select SND_SOC_DMAENGINE_PCM

Does this have any actual platform build dependencies or can this be
ARCH_SIRF || COMPILE_TEST?

--1y1tiN5hVw5cPBDe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR6WWAAAoJELSic+t+oim9NLcP/3qkntEGbQKWr4xjK3DU92LP
n8mIU2d/97/TL6V0bhF1p+lDFHKMNePDmD6Hy/y+uDYb7n3QL6cIZW8Hr4dHtqc4
QdlM5KjlRMFrVGMLbGkITTCF3v/OZ7DwEGVrQum4cuGekGCppUu0KJvvVgttlxzG
CdATaYmnYChgP+B+CP6wyo9tghUzRSuE+5jNLo124Og3eju+Eru8oMTQBWBVhb1p
Dbm8ROiFqJLdMMI8ZBnuqe8EEEY10gtzoRlElr6xy+SeWweu6qoVhuaaLIXNdpVi
SBwrD2vLAKusXmCjjqmdW/obKRvrwuXwPvaAiUGhQ39hEcO6WDB5pIvpwWcOR4ZN
RMxD7pDytjMHWJYyy0yX27g/3SuStzoy4nBo0GDynXgrsuEroqPqqiDK8jSiMWRB
lUCFfn8KKMY4wwlcu5Im5QIu5BEL8vPzN0GLEl0bJHx3eQ0p7eLIe6wfeBmccNSu
XsNMbPVMFTePmbMUdBWfrS4eRv5/vp8DljOvGbMRlIaLoJRTZ/bXDUwVYDzS/9F2
HC2Wn5XZsMNcbQvNDtw5QNXmwvtevrHWXwD5CMtRYaf9uJTcGFje9RyX60oprygs
wM3e99LYytN4IjuE7rHpy3cONgEkxjwd8NnvgKJP9rHm1kHr8RGKu/hsikKaGR8P
k34pD2/1yXZb4Bk7o5rW
=5ZNK
-----END PGP SIGNATURE-----

--1y1tiN5hVw5cPBDe--

--===============7561764700611903624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7561764700611903624==--
