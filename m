From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Subject: Re: [patch] ALSA: asihpi: fix an information leak in
	asihpi_hpi_ioctl()
Date: Tue, 30 Dec 2014 21:07:37 +1300
Message-ID: <54A25D49.4000502@blennerhassett.gen.nz>
References: <20141222074946.GA9737@mwanda> <s5hmw6ais9g.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from omr.mail.isx.net.nz (omr.mail.isx.net.nz [111.65.230.130])
 by alsa0.perex.cz (Postfix) with ESMTP id C91F42605DF
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 09:07:41 +0100 (CET)
In-Reply-To: <s5hmw6ais9g.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 27/12/14 00:07, Takashi Iwai wrote:
> At Mon, 22 Dec 2014 10:49:46 +0300,
> Dan Carpenter wrote:
>>
>> So far as I can see "hr->h.size" is set to "res_max_size" which is a
>> user controlled value between 12 and USHRT_MAX.  If it's larger than
>> sizeof(*hr), then that leads to an information leak.
>>
>> I am not very familiar with this code, my other question here is that
>> on lines before we set "hr->h.size = sizeof(hr->h)".  It think this is
>> a bug.  I also think this particular code is never executed and I added
>> a comment to that effect.  But we do it in earlier in the function as
>> well:
>>
>> 	copy_to_user(puhr, hr, sizeof(hr->h));
>>
>> It doesn't make sense to me.
>>
>> Anyway, I think my patch is safe and it seems to fix a real information
>> leak.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>
>> diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
>> index 6aa677e..f88109a 100644
>> --- a/sound/pci/asihpi/hpioctl.c
>> +++ b/sound/pci/asihpi/hpioctl.c
>> @@ -283,6 +283,7 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>>  		goto out;
>>  	}
>>  
>> +	/* FIXME:  isn't this a no-op? */
> 
> The whole union member may be overwritten by a response.
> 
>>  	if (hr->h.size > res_max_size) {
>>  		HPI_DEBUG_LOG(ERROR, "response too big %d %d\n", hr->h.size,
>>  			res_max_size);
>> @@ -290,6 +291,9 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>>  		hr->h.specific_error = hr->h.size;
>>  		hr->h.size = sizeof(hr->h);
>>  	}
>> +	/* prevent an information leak */
>> +	if (hr->h.size > sizeof(*hr))
>> +		hr->h.size = sizeof(*hr);
> 
> Checking the size is good, but there is already a check against
> res_max_size.  So, we'd rather need to check res_max_size itself
> whether it's in a sane range.  The more fitting place would be at the
> beginning of the function where it checks already res_max_size <
> sizeof(struct hpi_response_header)).

Yes.

At that point res_max_size is size of userspace buffer, and *hr is
effectively kernelspace buffer,  so take lowest of the two.

i.e.
    res_max_size = min(res_max_size, sizeof(*hr));

On the way "down" from here hr->h.size is available buffer size for a
response from card DSP, then on the way "up", hr->h.size is the actual
size of the response.  This value comes from DSP by DMA or IO read.

Which leads me to notice another problem in hpi6000.c, where the
response read from DSP is not limited to the given buffer size.

I will follow up with a patch in the next few days.

> 
> 
> thanks,
> 
> Takashi
> 
>>  
>>  	uncopied_bytes = copy_to_user(puhr, hr, hr->h.size);
>>  	if (uncopied_bytes) {
>>


-- 
Eliot
