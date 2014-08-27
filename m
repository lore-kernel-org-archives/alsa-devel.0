From: Mark Brown <broonie@kernel.org>
Subject: Re: [v3 02/11] ASoC: Intel: mrfld - Add DSP load and
	management
Date: Wed, 27 Aug 2014 21:17:19 +0100
Message-ID: <20140827201719.GV17528@sirena.org.uk>
References: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
 <1408625450-32315-3-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8583370053003554410=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 354F3268178
 for <alsa-devel@alsa-project.org>; Wed, 27 Aug 2014 22:17:27 +0200 (CEST)
In-Reply-To: <1408625450-32315-3-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8583370053003554410==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Vyn75Q+zsA3wSO6z"
Content-Disposition: inline


--Vyn75Q+zsA3wSO6z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 21, 2014 at 06:20:41PM +0530, Subhransu S. Prusty wrote:

> +#ifndef CONFIG_X86_64
> +#define MEMCPY_TOIO memcpy_toio
> +#else
> +#define MEMCPY_TOIO memcpy32_toio
> +#endif

This is a counterintuitve way to write this (with a reversed test) and
surely if this is needed it would be better done by the architecture
headers defining memcpy32_toio on 32 bit platforms too?  I'm also not
immediately seeing memcpy32_toio() defined when I grep except as a local
definition in the Atmel NAND driver.  Oh, except...

> +/**
> + * memcpy32_toio: Copy using writel commands
> + *
> + * This is needed because the hardware does not support
> + * 64-bit moveq insructions while writing to PCI MMIO
> + */
> +void memcpy32_toio(void *dst, const void *src, int count)
> +{
> +	int i;
> +	const u32 *src_32 = src;
> +	u32 *dst_32 = dst;
> +
> +	for (i = 0; i < count/sizeof(u32); i++)
> +		writel(*src_32++, dst_32++);
> +}

...which is very similar but missing static, __iomem and const
annotations.  I'd suggest lifting the existing version into generic
code.

> +#define SST_CALC_DMA_DSTN(lpe_viewpt_rqd, ia_viewpt_addr, elf_paddr, \
> +			lpe_viewpt_addr) ((lpe_viewpt_rqd) ? \
> +		elf_paddr : (ia_viewpt_addr + elf_paddr - lpe_viewpt_addr))

Can we make this a function please?

> +static int sst_fill_dstn(struct intel_sst_drv *sst, struct sst_info info,
> +		Elf32_Phdr *pr, void **dstn, unsigned int *dstn_phys,
> +		int *mem_type)
> +{
> +	/* work arnd-since only 4 byte align copying is only allowed for ICCM */

around.

> +static inline int sst_validate_elf(const struct firmware *sst_bin, bool dynamic)

Why is this inlined?  My previous comments about this looking very
generic also still remain unaddressed - it looks a lot like the
remoteproc ELF code for example though a bit less thorough.  I'm really
not thrilled about the idea of duplicating something like ELF parsing,
it seems like an excellent candidate for a library.

> + * Adds the node to the list after required fields
> + * are populated in the node
> + */
> +
> +static int sst_fill_memcpy_list(struct list_head *memcpy_list,
> +			void *destn, const void *src, u32 size, bool is_io)

Extra blank line.

> +	for (count = 0; count < module->blocks; count++) {

> +		block = (void *)block + sizeof(*block) + block->size;

We're not doing any validation that the data we're reading from the
firmware file isn't corrupt here - we're just trusting both the number
of blocks and the sizes of the blocks.  We should be a bit less trusting
about userspace data.

> +static void sst_memcpy_free_lib_resources(struct intel_sst_drv *sst_drv_ctx)
> +{
> +	struct sst_memcpy_list *listnode, *tmplistnode;
> +
> +	pr_debug("entry:%s\n", __func__);
> +
> +	/*Free the list*/
> +	if (!list_empty(&sst_drv_ctx->libmemcpy_list)) {

Why the list_empty() check here?

> +		list_for_each_entry_safe(listnode, tmplistnode,
> +				&sst_drv_ctx->libmemcpy_list, memcpylist) {
> +			list_del(&listnode->memcpylist);
> +			kfree(listnode);
> +		}
> +	}
> +}
> +
> +void sst_memcpy_free_resources(struct intel_sst_drv *sst_drv_ctx)
> +{
> +	struct sst_memcpy_list *listnode, *tmplistnode;
> +
> +	pr_debug("entry:%s\n", __func__);
> +
> +	/*Free the list*/
> +	if (!list_empty(&sst_drv_ctx->memcpy_list)) {

So we have a memcpy() list and a libmemcpy() list?  That seems confusing
and redundant...

> +	if (ctx->sst_state != SST_RESET ||
> +			ctx->fw_in_mem != NULL)
> +		goto out;

Is this perhaps an error conditon we should complain about?

> +	if (ctx->info.use_elf == true)
> +		ret = sst_validate_elf(fw, false);

I can't find anything that ever sets use_elf...

> +static int sst_request_fw(struct intel_sst_drv *sst)
> +{
> +	int retval = 0;
> +	char name[20];
> +	const struct firmware *fw;
> +
> +	snprintf(name, sizeof(name), "%s%04x%s", "fw_sst_",
> +				sst->pci_id, ".bin");
> +	pr_debug("Requesting FW %s now...\n", name);
> +
> +	retval = request_firmware(&fw, name, sst->dev);

There was a name in the driver struct for async requests and this does
appear to duplicate a lot of code from the async callback...

> +static inline void print_lib_info(struct snd_sst_lib_download_info *resp)
> +{
> +	pr_debug("codec Type %d Ver %d Built %s: %s\n",
> +		resp->dload_lib.lib_info.lib_type,
> +		resp->dload_lib.lib_info.lib_version,
> +		resp->dload_lib.lib_info.b_date,
> +		resp->dload_lib.lib_info.b_time);
> +}

sysfs or debugfs?  There don't seem to be any users of this anyway...

--Vyn75Q+zsA3wSO6z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/jzMAAoJELSic+t+oim9bW4P/RLOxX1Sh/DD4yq0xzPT/4tx
PWolwvccGzKpdj5GNVoiQfkrXchCScJHVFpDzzaTkr+urnIvw8GU1kNZboo6Mvjd
+zfy66g9Cdo8fYkfKOA7JaCCYKGQGhZOe38Vr7HcTotW2OeZqPnHIa1bj2cO/NV5
dMhOzCdA5kdsmwSRdccLasvR32DIePKhWoU+vBu+TsOuhNUfNS3J/DPOTQpgoeRt
ECBJdonsKSZXruNMZvCH/PVPXq7lImThaJgZ0rEHigBll9JAQ2bt4Jl+CCJDhtIQ
d6nxsoIO5yoDymYHXrZe0kRHn5lLY8ZfDBnNGeoqoMG8OzObOVesFtgz1wf3q6aT
R0jrDDxP1n9JbP7/2ILq1wB9GtrqDavt72cUdfual3lLSICrkf4uTA7TBq4YN2W7
zL2rHlopjpsMYIsTvENjBSO89kbj6lG/rFt5+Q5OFGVp6L4bYjJYo1Jj8/9kvLJQ
WwWEzdbFCCetOtTHwHveqExZGNDjfVxHbd6+ttV0nyhvSMiCla6kKXxOkduANN9N
3dGOf7xCBI0ysKB7wjyPdTNHea+kkQpd9P9C6sHyGa57ZBsW9EV9nR0dcfCLtZSR
HEFBnUliXCu1hhsEfwfAnUi4A+Mg0pC0MYFEQ6ektUvE7hsxMqBBsisL3UogGDF3
9vnh+JF9zNtws+KVI4BE
=nvdD
-----END PGP SIGNATURE-----

--Vyn75Q+zsA3wSO6z--

--===============8583370053003554410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8583370053003554410==--
