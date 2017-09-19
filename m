From: Meng Xu <meng.xu@gatech.edu>
Subject: Re: [PATCH] ALSA: asihpi: fix a potential double-fetch bug when
 copying puhm
Date: Tue, 19 Sep 2017 09:54:22 -0400
Message-ID: <8b2e7d4a-6b77-ffed-176f-257219b9ecb5@gatech.edu>
References: <1505798516-22482-1-git-send-email-mengxu.gatech@gmail.com>
 <s5h377jgncb.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h377jgncb.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Meng Xu <mengxu.gatech@gmail.com>
Cc: alsa-devel@alsa-project.org, perex@perex.cz, vlad@tsyrklevich.net, linux-kernel@vger.kernel.org, sanidhya@gatech.edu, taesoo@gatech.edu
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Thanks for the reply. In my opinion, many security issues
are in fact unhandled corner cases and this could be one.

In the first fetch, get_user(hm->h.size, (u16 __user *)puhm),
only 2 bytes from puhm are copied in and later it is ensured
that hm->h.size (which is also hm->m0.size given hm is a union)
is no larger than sizeof(*hm). However, this relation is broken
after the second fetch, copy_from_user(hm, puhm, hm->h.size).

As a concrete example, a user could put 0x000A when the first
fetch happens which make hm->h.size <= sizeof(*hm) and later
races to change it to 0xFFFF in the second fetch. What makes it
even worse is this call: hpi_send_recv_f(&hm->m0, &hr->r0, file),
which sends &hm->m0 to a lot of destinations. If any of the
downstream functions assumes that hm->m0.size <= sizeof(*hm)
which is actually not, an exploit can be constructed.

In fact, similar issues have caused vulnerabilities before as in
https://bugzilla.kernel.org/show_bug.cgi?id=116651
https://bugzilla.kernel.org/show_bug.cgi?id=120131,
and more recently the fix in sched/perf
https://marc.info/?l=linux-kernel&m=150401225812533&w=2

Feel free to let us know your opinion.

Best Regards,
Meng

On 09/19/2017 03:27 AM, Takashi Iwai wrote:
> On Tue, 19 Sep 2017 07:21:56 +0200,
> Meng Xu wrote:
>> The hm->h.size is intended to hold the actual size of the hm struct
>> that is copied from userspace and should always be <= sizeof(*hm).
>>
>> However, after copy_from_user(hm, puhm, hm->h.size), since userspace
>> process has full control over the memory region pointed by puhm, it is
>> possible that the value of hm->h.size is different from what is fetched-in
>> previously (get_user(hm->h.size, (u16 __user *)puhm)). In other words,
>> hm->h.size is overriden and the relation between hm->h.size and the hm
>> struct is broken.
>>
>> This patch proposes to use a seperate variable, msg_size, to hold
>> the value of the first fetch and override hm->h.size to msg_size
>> after the second fetch to maintain the relation.
>>
>> Signed-off-by: Meng Xu <mengxu.gatech@gmail.com>
> But when user-space already changes the data, the data being read is
> more or less broken in anyway no matter whether we keep the original
> h.size or not, because it doesn't match with h.size, no?
>
> I'd take a fix patch if it would fix some out-of-bounds access or such
> severe issues.  But this sounds like covering a corner-case that is
> broken in anyway.  Or am I missing something else?
>
>
> thanks,
>
> Takashi
>
>> ---
>>   sound/pci/asihpi/hpioctl.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
>> index 7e3aa50..5badd08 100644
>> --- a/sound/pci/asihpi/hpioctl.c
>> +++ b/sound/pci/asihpi/hpioctl.c
>> @@ -103,6 +103,7 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>>   	void __user *puhr;
>>   	union hpi_message_buffer_v1 *hm;
>>   	union hpi_response_buffer_v1 *hr;
>> +	u16 msg_size;
>>   	u16 res_max_size;
>>   	u32 uncopied_bytes;
>>   	int err = 0;
>> @@ -127,22 +128,25 @@ long asihpi_hpi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>>   	}
>>   
>>   	/* Now read the message size and data from user space.  */
>> -	if (get_user(hm->h.size, (u16 __user *)puhm)) {
>> +	if (get_user(msg_size, (u16 __user *)puhm)) {
>>   		err = -EFAULT;
>>   		goto out;
>>   	}
>> -	if (hm->h.size > sizeof(*hm))
>> -		hm->h.size = sizeof(*hm);
>> +	if (msg_size > sizeof(*hm))
>> +		msg_size = sizeof(*hm);
>>   
>>   	/* printk(KERN_INFO "message size %d\n", hm->h.wSize); */
>>   
>> -	uncopied_bytes = copy_from_user(hm, puhm, hm->h.size);
>> +	uncopied_bytes = copy_from_user(hm, puhm, msg_size);
>>   	if (uncopied_bytes) {
>>   		HPI_DEBUG_LOG(ERROR, "uncopied bytes %d\n", uncopied_bytes);
>>   		err = -EFAULT;
>>   		goto out;
>>   	}
>>   
>> +	/* Override h.size in case it is changed between two userspace fetches */
>> +	hm->h.size = msg_size;
>> +
>>   	if (get_user(res_max_size, (u16 __user *)puhr)) {
>>   		err = -EFAULT;
>>   		goto out;
>> -- 
>> 2.7.4
>>
>>
