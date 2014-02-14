From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 3/5] ASoC: Intel: Add Intel SST audio DSP
 Firmware loader.
Date: Fri, 14 Feb 2014 09:38:49 +0000
Message-ID: <1392370729.2300.6.camel@loki>
References: <1392318930-8771-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392318930-8771-3-git-send-email-liam.r.girdwood@linux.intel.com>
 <s5hy51ehy40.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id A1F262616CB
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2014 10:39:06 +0100 (CET)
In-Reply-To: <s5hy51ehy40.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Benson Leung <bleung@google.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2014-02-14 at 09:55 +0100, Takashi Iwai wrote:
> At Thu, 13 Feb 2014 19:15:28 +0000,
> Liam Girdwood wrote:
> > 
> > +
> > +/* create new generic firmware object */
> > +struct sst_fw *sst_fw_new(struct sst_dsp *dsp,
> > +	const struct firmware *fw, void *private)
> > +{
> > +	struct sst_fw *sst_fw;
> > +	int err;
> > +
> > +	if (!dsp->ops->parse_fw)
> > +		return NULL;
> > +
> > +	sst_fw = kzalloc(sizeof(*sst_fw), GFP_KERNEL);
> > +	if (sst_fw == NULL)
> > +		return NULL;
> > +
> > +	sst_fw->dsp = dsp;
> > +	sst_fw->private = private;
> > +	sst_fw->size = fw->size;
> > +
> > +	err = dma_coerce_mask_and_coherent(dsp->dev, DMA_BIT_MASK(32));
> > +	if (err < 0) {
> > +		kfree(sst_fw);
> > +		return NULL;
> > +	}
> > +
> > +	/* allocate DMA buffer to store FW data */
> > +	sst_fw->dma_buf = dma_alloc_coherent(dsp->dev, sst_fw->size,
> > +				&sst_fw->dmable_fw_paddr, GFP_DMA);
> > +	if (!sst_fw->dma_buf) {
> > +		dev_err(dsp->dev, "error: DMA alloc failed\n");
> > +		kfree(sst_fw);
> > +		return NULL;
> > +	}
> > +
> > +	/* copy FW data to DMA-able memory */
> > +	memcpy((void *)sst_fw->dma_buf, (void *)fw->data, fw->size);
> > +	release_firmware(fw);
> 
> Should fw object be really released here?
> For example, if this function returns NULL after this point, the
> caller doesn't know whether fw was released or not.  It'd be more
> consistent to release it in the caller side, or always release no
> matter whether the function succeeds or not.

Yep, your right. I'll fix this in V2. Fwiw, we only need to take a copy
of the FW and store that copy in DMA-able memory (32bit addressable). So
the DMA memory will be used for context restore (from resume), DMA
firmware loading etc.

> 

> > +
> > +/* allocate contiguous free DSP blocks - callers hold locks */
> > +static int block_alloc_contiguous(struct sst_module *module,
> > +	struct sst_module_data *data, u32 next_offset, int size)
> > +{
> > +	struct sst_dsp *dsp = module->dsp;
> > +	struct sst_mem_block *block, *tmp;
> > +	int ret;
> > +
> > +	/* find first free blocks that can hold module */
> > +	list_for_each_entry_safe(block, tmp, &dsp->free_block_list, list) {
> > +
> > +		/* ignore blocks that dont match type */
> > +		if (block->type != data->type)
> > +			continue;
> > +
> > +		/* is block next after parent ? */
> > +		if (next_offset == block->offset) {
> > +
> > +			/* do we need more blocks */
> > +			if (size > block->size) {
> > +				ret = block_alloc_contiguous(module,
> > +					data, block->offset + block->size,
> > +					size - block->size);
> > +				if (ret < 0)
> > +					return ret;
> 
> How many contiguous blocks can be?

In theory, the whole DSP memory can be allocated as a contiguous block,
but in practice it's only really a few blocks contiguous per module atm.

> The recursive call for each one block doesn't look scaling.
> 

It seems to work atm, but I'll update this too for V2.

Liam
