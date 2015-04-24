From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 6/9] ASoC: hda: Add Code Loader DMA support
Date: Fri, 24 Apr 2015 18:18:38 +0100
Message-ID: <20150424171838.GV22845@sirena.org.uk>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <1429276567-29007-7-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6334395154546910106=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5953F2605CE
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 19:18:43 +0200 (CEST)
In-Reply-To: <1429276567-29007-7-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6334395154546910106==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g25aLs01KP84V+yN"
Content-Disposition: inline


--g25aLs01KP84V+yN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 17, 2015 at 06:46:04PM +0530, Vinod Koul wrote:

> +void ssth_cldma_int_enable(struct ssth_lib *ctx)
> +{
> +	ssth_updatel_bits(ctx, HDA_ADSP_REG_ADSPIC,
> +			ADSPIC_CL_DMA, 0x2);
> +}
> +void ssth_cldma_int_disable(struct ssth_lib *ctx)
> +{
> +	ssth_updatel_bits(ctx, HDA_ADSP_REG_ADSPIC,
> +			ADSPIC_CL_DMA, 0);
> +}

Blank lines between functions.  Seems to be an Intel coding style thing?
:P

> +/* Code loader helper APIs */
> +static void ssth_skl_cl_setup_bdle(struct snd_dma_buffer *dmab_data,
> +		u32 **bdlp, u32 count)
> +{
> +	u32 *bdl = *bdlp;
> +	int i = 0;
> +
> +	for (i = 0; i < count; i++) {
> +		phys_addr_t addr = virt_to_phys(dmab_data->area + i * PAGE_SIZE);

So this we index by i and...

> +
> +		bdl[0] = cpu_to_le32(lower_32_bits(addr));
> +		bdl[1] = cpu_to_le32(upper_32_bits(addr));
> +		bdl[2] = cpu_to_le32(PAGE_SIZE);
> +		bdl[3] = 0;
> +		bdl += 4;
> +	}

...this we index by stepping through the array with increments in the
body of the loop.  Consistency would be nice (and more obviously
correct).

> +static void ssth_skl_cl_cleaup(struct ssth_lib  *ctx)
> +{

Can't we clean it up instead?

> +	if (ctx->cl_dev.bytes_left <= ctx->cl_dev.bufsize &&
> +			ctx->cl_dev.bytes_left > ctx->cl_dev.period_size) {
> +
> +		dev_dbg(ctx->dev, "%s: size less than buffer size: %u\n",
> +			       __func__, ctx->cl_dev.bytes_left);
> +		ssth_cldma_int_disable(ctx);
> +		ctx->cl_dev.curr_spib_pos = ctx->cl_dev.bytes_left;
> +		ssth_cl_dma_fill_buffer(ctx, size, false, false, 0, false, true);
> +		do {
> +			mdelay(5);
> +			link_pos = ssth_readl(ctx, CL_SD_LPIB);
> +		} while (link_pos < size);

Should time out in case the DMA got stuck somehow.

> +		goto cleanup;
> +	}

What if the buffer is just too big?  Looks like this would loop for
ever.

--g25aLs01KP84V+yN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOnrtAAoJECTWi3JdVIfQ1D8H/Rr4dJ3HNyGQJI4Gd5RKPZAs
w+5qnAyT/Duuz+MCzbkD1axGbEMS4X0r01v7nPpMARjOskQnHFj5EHdZ4TRwznQe
fgt5e4M8qpFqAS9/bmNTGRG3SFY/0jy5HeobKGr7w9fY1DLlE4ydDA08nyBUzhlS
jTqrwyJrpXRfQeSnYtAoBlqD0Yz7yePaV1a85n0koWKxPU9B/6BFkyVt7q0Vx5vu
Ho+YWxt+KVf/7erLDVcNrWCPRCkRVo8pSx2ssi/ZUhH+cpGx3zVoR3PiaeeN+Y1u
7wpoaKOiaY6LEx1CK8llvLRAoMWRvk8693nGBVmyFdHh7/xx979f6vpHPymGB/8=
=JWUp
-----END PGP SIGNATURE-----

--g25aLs01KP84V+yN--

--===============6334395154546910106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6334395154546910106==--
