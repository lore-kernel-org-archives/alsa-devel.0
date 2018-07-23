From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/11] ASoC: SOF: Add Sound Open Firmware
	driver core
Date: Mon, 23 Jul 2018 19:56:33 +0100
Message-ID: <20180723185633.GI13981@sirena.org.uk>
References: <20180719185335.30912-1-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0632769853041349303=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 904DA2675FC
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2018 20:56:35 +0200 (CEST)
In-Reply-To: <20180719185335.30912-1-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0632769853041349303==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZPDwMsyfds7q4mrK"
Content-Disposition: inline


--ZPDwMsyfds7q4mrK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 19, 2018 at 07:53:25PM +0100, Liam Girdwood wrote:

> The Sound Open Firmware driver core is a generic architecture
> independent layer that allows SOF to be used on many different different
> architectures and platforms. It abstracts DSP operations and IO methods

> +++ b/include/sound/soc.h
> @@ -1133,6 +1133,7 @@ struct snd_soc_pcm_runtime {
>  	/* runtime devices */
>  	struct snd_pcm *pcm;
>  	struct snd_compr *compr;
> +	struct snd_sof_pcm *sof;
>  	struct snd_soc_dai *codec_dai;
>  	struct snd_soc_dai *cpu_dai;

Can we rename this somehow to be less specific to SoF or move it to be
somewhere other than the runtime structure?  I can see why you've done
this but I can also see every DSP vendor turning up and trying to add
their own field in here.

> +/*
> + * This file is provided under a dual BSD/GPLv2 license.  When using or
> + * redistributing this file, you may do so under either license.
> + *
> + * Copyright(c) 2017 Intel Corporation. All rights reserved.

2017?

> index 000000000000..29458909182a
> --- /dev/null
> +++ b/sound/soc/sof/core.c
> @@ -0,0 +1,373 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +/*
> + * This file is provided under a dual BSD/GPLv2 license.  When using or

Please make the entire comment a C++ one, it makes it look more
intentional.

> +static inline unsigned int sof_get_pages(size_t size)
> +{
> +	return (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +}

This feels like there should be a generic MM function for it?

> +/*
> + * Generic buffer page table creation.
> + */
> +
> +int snd_sof_create_page_table(struct snd_sof_dev *sdev,
> +			      struct snd_dma_buffer *dmab,
> +			      unsigned char *page_table, size_t size)
> +{
> +	int i, pages;
> +
> +	pages = snd_sgbuf_aligned_pages(size);
> +
> +	dev_dbg(sdev->dev, "generating page table for %p size 0x%zx pages %d\n",
> +		dmab->area, size, pages);
> +
> +	for (i = 0; i < pages; i++) {
> +		u32 idx = (((i << 2) + i)) >> 1;
> +		u32 pfn = snd_sgbuf_get_addr(dmab, i * PAGE_SIZE) >> PAGE_SHIFT;
> +		u32 *pg_table;
> +
> +		dev_dbg(sdev->dev, "pfn i %i idx %d pfn %x\n", i, idx, pfn);
> +
> +		pg_table = (u32 *)(page_table + idx);
> +
> +		if (i & 1)
> +			*pg_table |= (pfn << 4);
> +		else
> +			*pg_table |= pfn;
> +	}

I'm not 100% clear what this is intended to do - lots of magic numbers
and dependencies on the host memory configuration.

--ZPDwMsyfds7q4mrK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltWJOEACgkQJNaLcl1U
h9Caogf+MKjGyaqo1eBP+KA4lIBeIeD+IrPYCraXfaklx2FN36SGKUEZk8dHuBNz
+39w06VH3PMwEGbJaXw77UzNMca/gk7Z1iffmbbh2XAnrN4XxQ/x1mx0ZDL9T0NI
X828SHemzaAGWAlmyE/XzMSVkZ/qllzfewDZmfZypQjUV2yb66dJLplyv6V7mVXU
66ZR1ghGTPZkVAzkxi5BhK6E4uKe7w/6ELR5TYQ/TsPsm9GeP7gmhJPavgeGhl65
Kqxe613P2WqSDlhKpy4RxLlma3jf0M1UWzvVi1ooeVMR2oIfxXnAd++IoE1BYvdi
9WppOgMlFOrd/KSvtuRlRbr+z8cwcQ==
=uxiL
-----END PGP SIGNATURE-----

--ZPDwMsyfds7q4mrK--

--===============0632769853041349303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0632769853041349303==--
