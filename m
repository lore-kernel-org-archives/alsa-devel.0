From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [PATCH 03/10] ALSA: add AXD Audio Processing IP alsa driver
Date: Fri, 28 Aug 2015 10:22:57 +0100
Message-ID: <55E02871.9050607@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-4-git-send-email-qais.yousef@imgtec.com>
 <20150826183700.GD28760@sirena.org.uk> <55DEFF77.8070309@imgtec.com>
 <20150827153233.GD5313@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150827153233.GD5313@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 08/27/2015 04:32 PM, Mark Brown wrote:
> On Thu, Aug 27, 2015 at 01:15:51PM +0100, Qais Yousef wrote:
>> On 08/26/2015 07:37 PM, Mark Brown wrote:
>>> On Mon, Aug 24, 2015 at 01:39:12PM +0100, Qais Yousef wrote:
>>>> +#define AXD_INPUT_DESCRIPTORS 10
>>>> +struct axd_input {
>>>> +	struct axd_buffer_desc descriptors[AXD_INPUT_DESCRIPTORS];
>>>> +};
>>> Where do these numbers come from?  Are they hardware limits or something
>>> else?
>> These numbers are what the firmware designed to work with. We had to set a
>> limit and we sought 10 to be a good one for our purposes. We don't expect to
>> need to change this number.
> So we have hard coded numbers in the firmware that we need in the driver
> but we can't read those numbers back from the firmware.  That's sad.
>
>>>> +#define AXD_BASE_VADDR		0xD0000000
>>> This sounds like something that is going to be platform dependant,
>>> should this be supplied from board configuration?
>> I don't expect this to change. Can we add the configuration later if we hit
>> the need to change it?
> It should be trivial to make things configurable shouldn't it?

Yes and I am all with configurability but I don't think it makes sense 
here. AXD will always have its own MMU and will not share virtual 
address space, so the possibility of us wanting to move this somewhere 
else is really very thin. Also I don't think this is the kind of detail 
we need to concern the user with. I'll see if I can make the binary 
header parsing more flexible so we can add more info like this and the 
one above in the future and be more future proof.

>>>> +	if (!*offp) {
>>>> +		unsigned int flags = axd_platform_lock();
>>>> +		unsigned int log_offset = ioread32(log_addr);
>>>> +		unsigned int log_wrapped = ioread32(log_addr + 8);
>>>> +		char __iomem *log_buff = (char __iomem *)(log_addr + 12);
>>>> +
>>>> +		/* new read from beginning, fill up our internal buffer */
>>>> +		if (!log_wrapped) {
>>>> +			memcpy_fromio(axd->log_rbuf, log_buff, log_offset);
>>>> +			axd->log_rbuf_rem = log_offset;
>>>> +		} else {
>>>> +			char __iomem *pos = log_buff + log_offset;
>>>> +			unsigned int rem = log_size - log_offset;
>>>> +
>>>> +			memcpy_fromio(axd->log_rbuf, pos, rem);
>>>> +			memcpy_fromio(axd->log_rbuf + rem, log_buff, log_offset);
>>>> +			axd->log_rbuf_rem = log_size;
>>>> +		}
>>>> +		axd_platform_unlock(flags);
>>> I didn't see the lock being taken?
>> The lock is the first line in the block (unsigned int flags =
>> axd_platform_lock()). I'll tidy it up to make it more readable.
> It's very bad practice to bury lock taking in with the variable
> declaration.

Yes. I'll fix it.

>>>> +#ifdef CONFIG_CRYPTO_LZO
>>>> +#include <linux/crypto.h>
>>> This include should be with all the other includes, not down here.
>> Was trying to reduce the ifdefery. Will fix.
> You don't need any ifdefs for the include, you can just include the
> header.
>
>>>> +{
>>>> +	dev_err(axd->dev, "The firmware must be lzo decompressed first, compile driver again with CONFIG_CRYPTO_LZO enabled in kernel or do the decompression in user space.\n");
>>> Please split this up into a few prints for wrapping, similarly in
>>> several other places.
>> OK. I thought the convention for strings to leave them as is to allow
>> grepping. I'll fix it.
> You should keep strings that are displayed as a single string together
> but if you are splitting something in the output then that split won't
> hurt grepping in the source.
>
>>>> +	 * We copy through the cache, fw will do the necessary cache
>>>> +	 * flushes and syncing at startup.
>>>> +	 * Copying from uncached makes it more difficult for the
>>>> +	 * firmware to keep the caches coherent with memory when it sets
>>>> +	 * tlbs and start running.
>>>> +	 */
>>>> +	memcpy_toio((void *)cached_fw_base, fw->data, fw->size);
>>> Why the cast here?  I'm also not seeing where we handled the copying to
>>> I/O in the decompression case?
>> I couldn't avoid the cast. If cached_fw_base is 'void *' I'll get a warning
>> when initialising cached_fw_base from CAC_ADDR().
> Why do you get a warning from that?  Perhaps the warnings are trying to
> tell us something...

Because we try to assign an int to a pointer. So the error is 'makes 
pointer from integer without a cast'. To convert an address from 
uncached to cached we need to convert to an int as in MIPS it's a case 
of adding or subtracting a value then convert this value back to it's 
original form.
I'll see if I can find a better way to fix the coherency issue when we 
copy through uncached.

>
>> Good point. When decompressing crypto_comp_decompress() will write directly
>> to the memory. It is safe but it doesn't go through the correct API. Not
>> sure what I can do here.
> Uncompress to a buffer then write that buffer to the final destination?

Yes but the binary could be multi MiB so we can't get a temp buffer that 
large. If the crypto API allows decompressing in steps we can use a 
small buffer to move the data iteratively. I'll have a look.

>
>>>> +	dev_info(axd->dev, "Loading firmware at 0x%p ...\n", axd->fw_base_m);
>>> This should be _dbg() at most, otherwise it's going to get noisy.
>>>> +	t0_new_pc = (unsigned long) axd->fw_base_m + (t0_new_pc - AXD_BASE_VADDR);
>>> Those casts look fishy...
>> I am happy to try something else. axd->fw_base_m is of type void * __iomem
>> but we want to do some arithmetic on it.
>> Is there a better way to do it?
> Pointer arithmetic or converting it to a number?

We are just converting to a number.

>
>>>> +	/* wake up any task sleeping on command response */
>>>> +	wake_up(&axd->cmd.wait);
>>>> +	/* give chance to user land tasks to react to the crash */
>>>> +	ssleep(2);
>>> This looks horribly racy, I'd expect us to be trashing and/or killing
>>> off any active work and resources here.
>> OK. I was trying to play nicely by giving the chance to userland to repond
>> to -ERESTART which would be sent from aborting any pending reads/writes.
>> Are you suggesting to send SIGKILL using force_sig()?
> No, I'm suggesting tearing down the kernel side of any work and kicking
> errors back to userspace if it continues to interact with anything that
> was ongoing.

OK. This is what we do (see my other email about abort). I'll have a 
think for a way to get rid of the ssleep(). Any ideas are welcome.

Thanks,
Qais
