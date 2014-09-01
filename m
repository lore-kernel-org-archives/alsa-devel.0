Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 81AEB264F3A
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 14:07:44 +0200 (CEST)
Date: Mon, 1 Sep 2014 17:15:14 +0530
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Message-ID: <20140901114514.GB12898@vinod.koul@linux.intel.com>
References: <1408625450-32315-1-git-send-email-subhransu.s.prusty@intel.com>
 <1408625450-32315-3-git-send-email-subhransu.s.prusty@intel.com>
 <20140827201719.GV17528@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140827201719.GV17528@sirena.org.uk>
Subject: Re: [alsa-devel] [v3 02/11] ASoC: Intel: mrfld - Add DSP load and
	management
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-ID: <alsa-devel@alsa-project.org>

On Wed, Aug 27, 2014 at 09:17:19PM +0100, Mark Brown wrote:
> On Thu, Aug 21, 2014 at 06:20:41PM +0530, Subhransu S. Prusty wrote:
> 
> > +#ifndef CONFIG_X86_64
> > +#define MEMCPY_TOIO memcpy_toio
> > +#else
> > +#define MEMCPY_TOIO memcpy32_toio
> > +#endif
> 
> This is a counterintuitve way to write this (with a reversed test) and
> surely if this is needed it would be better done by the architecture
> headers defining memcpy32_toio on 32 bit platforms too?  I'm also not
> immediately seeing memcpy32_toio() defined when I grep except as a local
> definition in the Atmel NAND driver.  Oh, except...
> 
> > +/**
> > + * memcpy32_toio: Copy using writel commands
> > + *
> > + * This is needed because the hardware does not support
> > + * 64-bit moveq insructions while writing to PCI MMIO
> > + */
> > +void memcpy32_toio(void *dst, const void *src, int count)
> > +{
> > +	int i;
> > +	const u32 *src_32 = src;
> > +	u32 *dst_32 = dst;
> > +
> > +	for (i = 0; i < count/sizeof(u32); i++)
> > +		writel(*src_32++, dst_32++);
> > +}
> 
> ...which is very similar but missing static, __iomem and const
> annotations.  I'd suggest lifting the existing version into generic
> code.

Will send a patch for generic code.
> 
> > +#define SST_CALC_DMA_DSTN(lpe_viewpt_rqd, ia_viewpt_addr, elf_paddr, \
> > +			lpe_viewpt_addr) ((lpe_viewpt_rqd) ? \
> > +		elf_paddr : (ia_viewpt_addr + elf_paddr - lpe_viewpt_addr))
> 
> Can we make this a function please?
Yes. 
> 
> > +static int sst_fill_dstn(struct intel_sst_drv *sst, struct sst_info info,
> > +		Elf32_Phdr *pr, void **dstn, unsigned int *dstn_phys,
> > +		int *mem_type)
> > +{
> > +	/* work arnd-since only 4 byte align copying is only allowed for ICCM */
> 
> around.
> 
> 
> > + * Adds the node to the list after required fields
> > + * are populated in the node
> > + */
> > +
> > +static int sst_fill_memcpy_list(struct list_head *memcpy_list,
> > +			void *destn, const void *src, u32 size, bool is_io)
> 
> Extra blank line.
Will remove.
> 
> > +	for (count = 0; count < module->blocks; count++) {
> 
> > +		block = (void *)block + sizeof(*block) + block->size;
> 
> We're not doing any validation that the data we're reading from the
> firmware file isn't corrupt here - we're just trusting both the number
> of blocks and the sizes of the blocks.  We should be a bit less trusting
> about userspace data.

Will add sanity checks.
> 
> > +static void sst_memcpy_free_lib_resources(struct intel_sst_drv *sst_drv_ctx)
> > +{
> > +	struct sst_memcpy_list *listnode, *tmplistnode;
> > +
> > +	pr_debug("entry:%s\n", __func__);
> > +
> > +	/*Free the list*/
> > +	if (!list_empty(&sst_drv_ctx->libmemcpy_list)) {
> 
> Why the list_empty() check here?
Not required here. Will remove.
> 
> > +		list_for_each_entry_safe(listnode, tmplistnode,
> > +				&sst_drv_ctx->libmemcpy_list, memcpylist) {
> > +			list_del(&listnode->memcpylist);
> > +			kfree(listnode);
> > +		}
> > +	}
> > +}
> > +
> > +void sst_memcpy_free_resources(struct intel_sst_drv *sst_drv_ctx)
> > +{
> > +	struct sst_memcpy_list *listnode, *tmplistnode;
> > +
> > +	pr_debug("entry:%s\n", __func__);
> > +
> > +	/*Free the list*/
> > +	if (!list_empty(&sst_drv_ctx->memcpy_list)) {
> 
> So we have a memcpy() list and a libmemcpy() list?  That seems confusing
> and redundant...
We need libmemcpy to load libraries. Will remove from this from this patch
series and add later.
> 
> > +	if (ctx->sst_state != SST_RESET ||
> > +			ctx->fw_in_mem != NULL)
> > +		goto out;
> 
> Is this perhaps an error conditon we should complain about?
No, this is not an error condition. The firmware can be requested from the
userspace through async request in probe or in the load_firmware through a
request from the userspace. This check is to synchroize between these two.
> 
> > +	if (ctx->info.use_elf == true)
> > +		ret = sst_validate_elf(fw, false);
> 
> I can't find anything that ever sets use_elf...
Not required. Will remove.
> 
> > +static int sst_request_fw(struct intel_sst_drv *sst)
> > +{
> > +	int retval = 0;
> > +	char name[20];
> > +	const struct firmware *fw;
> > +
> > +	snprintf(name, sizeof(name), "%s%04x%s", "fw_sst_",
> > +				sst->pci_id, ".bin");
> > +	pr_debug("Requesting FW %s now...\n", name);
> > +
> > +	retval = request_firmware(&fw, name, sst->dev);
> 
> There was a name in the driver struct for async requests and this does
> appear to duplicate a lot of code from the async callback...
Yes, will factor out the common code..
> 
> > +static inline void print_lib_info(struct snd_sst_lib_download_info *resp)
> > +{
> > +	pr_debug("codec Type %d Ver %d Built %s: %s\n",
> > +		resp->dload_lib.lib_info.lib_type,
> > +		resp->dload_lib.lib_info.lib_version,
> > +		resp->dload_lib.lib_info.b_date,
> > +		resp->dload_lib.lib_info.b_time);
> > +}
> 
> sysfs or debugfs?  There don't seem to be any users of this anyway...
Ok



-- 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
