From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 09/14] ASoC: SOF: Add firmware,
 loader support
Date: Thu, 20 Dec 2018 09:07:54 -0600
Message-ID: <05d38b48-559f-75ce-6299-e1dfd3a62c30@linux.intel.com>
References: <mailman.3934.1544619824.753.alsa-devel@alsa-project.org>
 <1ce21393-048f-6c04-b899-8cbfbf93983e@linux.intel.com>
 <s5h8t0kobov.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5h8t0kobov.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Bard liao <yung-chuan.liao@linux.intel.com>
Cc: daniel.baluta@gmail.com, andriy.shevchenko@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, sound-open-firmware@alsa-project.org, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org


>>>> +		snd_sof_dsp_block_write(sdev, offset,
>>>> +					(void *)block + sizeof(*block),
>>>> +					block->size);
>>>> +
>>>> +		/* next block */
>>>> +		block = (void *)block + sizeof(*block) + block->size;
>>> This may lead to an unaligned access.
>> Did you mean we should double check the block->size to
>> prevent access to an invalid address?
> You need two types of checks for the given data:
> - The bounce check of block->size;
>    We need to avoid out-of-bounce access.
s/bounce/bounds ?
>
> - Alignment of block->size;
>    For some non-x86 platforms, the access to an unaligned address might
>    be illegal.

Maybe I am missing something but I don't see any sort of explicit 
restriction on alignment in the SOF tools. it looks implicit based on 
address offsets and bases.

Liam, do you see any negative side effects if we enforce a 32-bit 
alignment for all blocks (which essentially means all block sizes are 
multiple of 4)? we can try and experiment but it's better if we have an 
agreement on the design.

>
> Oh, and recently another thing is sometimes needed for avoiding
> Spectre.  This can be covered by array_index_nospec().
>
>
>>> Also how is the endianess guaranteed?
>> Did you mean we should guarantee the driver can work no
>> matter what kernel's endianess is?
>> ie. Use le32_to_cpu() to handle it?
> Depends on the implementation.  IIRC, topology API refuses the data
> in a different endianess by checking the magic number at beginning.
snd_sof_dsp_block_write() is implemented with a platform-specific 
callback, I'd expect any endianess issues to be handled in that 
platform-specific code?
