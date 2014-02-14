From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [PATCH 3/5] ASoC: Intel: Add Intel SST audio DSP
 Firmware loader.
Date: Fri, 14 Feb 2014 16:11:15 +0000
Message-ID: <1392394275.2300.86.camel@loki>
References: <1392318930-8771-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392318930-8771-3-git-send-email-liam.r.girdwood@linux.intel.com>
 <s5hy51ehy40.wl%tiwai@suse.de> <1392370729.2300.6.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 00E88261663
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2014 17:11:39 +0100 (CET)
In-Reply-To: <1392370729.2300.6.camel@loki>
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

On Fri, 2014-02-14 at 09:38 +0000, Liam Girdwood wrote:
> On Fri, 2014-02-14 at 09:55 +0100, Takashi Iwai wrote:
> > At Thu, 13 Feb 2014 19:15:28 +0000,
> > Liam Girdwood wrote:
> 
> > > +
> > > +/* allocate contiguous free DSP blocks - callers hold locks */
> > > +static int block_alloc_contiguous(struct sst_module *module,
> > > +	struct sst_module_data *data, u32 next_offset, int size)
> > > +{
> > > +	struct sst_dsp *dsp = module->dsp;
> > > +	struct sst_mem_block *block, *tmp;
> > > +	int ret;
> > > +
> > > +	/* find first free blocks that can hold module */
> > > +	list_for_each_entry_safe(block, tmp, &dsp->free_block_list, list) {
> > > +
> > > +		/* ignore blocks that dont match type */
> > > +		if (block->type != data->type)
> > > +			continue;
> > > +
> > > +		/* is block next after parent ? */
> > > +		if (next_offset == block->offset) {
> > > +
> > > +			/* do we need more blocks */
> > > +			if (size > block->size) {
> > > +				ret = block_alloc_contiguous(module,
> > > +					data, block->offset + block->size,
> > > +					size - block->size);
> > > +				if (ret < 0)
> > > +					return ret;
> > 
> > How many contiguous blocks can be?
> 
> In theory, the whole DSP memory can be allocated as a contiguous block,
> but in practice it's only really a few blocks contiguous per module atm.
> 
> > The recursive call for each one block doesn't look scaling.
> > 

I've double checked the logic here and added more comments and debug. I
may be missing something though, but it does work and is designed to
deal with unordered blocks (on address) in the list.

The recursion basically checks the whole list each time for the next
block in address order. It then checks if the required size > current
block size. We decrement size on each by block size and increment
address by block size on every call. If the required size < current
block size we allocate the block and come back up the stack allocating
the other blocks in the sequence.

>From the debug we get :-

> [    6.733916] haswell-pcm-audio haswell-pcm-audio:  module 0 added block 0:4 at offset 0xc0000
> [    6.733925] haswell-pcm-audio haswell-pcm-audio:  module 0 added block 0:3 at offset 0xb8000
> [    6.733930] haswell-pcm-audio haswell-pcm-audio:  module 0 added block 0:2 at offset 0xb0000
> [    6.733936] haswell-pcm-audio haswell-pcm-audio:  module 0 added block 0:1 at offset 0xa8000
> [    6.810179] haswell-pcm-audio haswell-pcm-audio:  module 0 added block 1:1 at offset 0x88000
> [    6.810189] haswell-pcm-audio haswell-pcm-audio:  module 0 added block 1:0 at offset 0x80000
> [    6.857452] haswell-pcm-audio haswell-pcm-audio: scratch buffer required is 56320 bytes
> [    6.857461] haswell-pcm-audio haswell-pcm-audio: allocating scratch blocks
> [    6.857469] haswell-pcm-audio haswell-pcm-audio:  module 0 added block 1:6 at offset 0x70000
> [    6.860268] haswell-pcm-audio haswell-pcm-audio: FW loaded: type 172 - version: 0.0 build 1

Thanks

Liam

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
