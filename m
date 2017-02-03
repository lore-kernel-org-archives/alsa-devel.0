From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 4/4] ALSA: x86: Refactor PCM process engine
Date: Fri, 3 Feb 2017 17:22:00 -0600
Message-ID: <e6fec9f8-47ab-3f6a-6c61-774f78e49fb6@linux.intel.com>
References: <20170203164400.12983-1-tiwai@suse.de>
 <20170203164400.12983-5-tiwai@suse.de>
 <8efd0a5e-6c2a-7b97-11e7-cd22f68a9cbd@linux.intel.com>
 <s5h8tpnhw6e.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F5922669C4
 for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2017 00:22:01 +0100 (CET)
In-Reply-To: <s5h8tpnhw6e.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Jerome Anand <jerome.anand@intel.com>
List-Id: alsa-devel@alsa-project.org



On 02/03/2017 02:11 PM, Takashi Iwai wrote:
> On Fri, 03 Feb 2017 20:47:55 +0100,
> Pierre-Louis Bossart wrote:
>> On 2/3/17 10:44 AM, Takashi Iwai wrote:
>>> This is again a big rewrite of the driver; now it touches the code to
>>> process PCM stream transfers.
>>>
>>> The most fundamental change is that now the driver supports more than
>>> four periods.  Instead of keeping the same index between the ring
>>> buffers (from A to D) and the PCM buffer periods, now we keep
>>> difference indices for both.  Also, for the cases with less periods
>>> than four, we track the head index, too.  That is, we now have four
>>> indices: ringbuf_head, pcm_head, ringbuf_filled, and pcm_filled.
>> Well that's not completely right. The DMA can only generate an
>> interrupt once the buffer you submit was played, and with 4
>> descriptors you can't have more than 4 points where interrupts are
>> generated.  If you program different values in different descriptors
>> then the notion of periodic hardware interrupts will be lost.
> There is a standard trick such as used for ICH or other drivers.
> With this kind of hardware, the address to be written to each buffer
> descriptor can be changed dynamically while streaming.  (BTW, on some
> hardware like HD-audio, it's not allowed, but HD-audio has a larger
> table, so it doesn't matter.)
>
> That is, each BD maps to each period on the PCM buffer, and it moves
> there.  A picture like below would illustrate:
>
> At time=0
>
>    PCM | 0 | 1 | 2 | 3 | 4 | 5 | .... |n-1|
>    BD  | A | B | C | D |
>
> At time=1 (period elapsed)
>
>    PCM | 0 | 1 | 2 | 3 | 4 | 5 | .... |n-1|
>    BD      | B | C | D | A |
>
> At time=2
>
>    PCM | 0 | 1 | 2 | 3 | 4 | 5 | .... |n-1|
>    BD          | C | D | A | B |
Yes I thought this was a case of a moving window being used but what 
sort of application needs this? I never understood the benefits of 
expanding the number of periods, it just forces additional wake-ups for 
no good reason. It's really silly from a power perspective.

>
> and so on.
>
> For the case periods < 4, it works other way round:
>
> t=0
>    PCM | 0 | 1 |
>    BD  | A | B | - | - |
>
> t=1
>    PCM     | 1 | 0 |
>    BD  | - | B | C | - |
>
> t=2
>    PCM         | 0 | 1 |
>    BD  | - | - | C | D |
it can be done this way but I don't believe this is required. I think 
you can mark 2 descriptors as invalid and use only two, i.e. to follow 
your example you'd loop on A-B. The hardware will loop on the 4 
descriptors, ignore the invalid ones and stop if it can't find a valid one.

>
>
>>> By this flexibility, we can use even dmix, which requires 16 periods
>>> as default.
>>>
>>> The buffer size could be up to 20bit, so it's set to that value.  But
>>> the pre-allocation is limited to 128k as default.  It's because the
>>> chip requires the continuous pages (unfortunately no-SG possible),
>>> thus we don't want too much continuous pages.
>> No, that's not true. You need contiguous regions for each descriptor,
>> but the entire buffer doesn't need to be contiguous.
> Yeah, in theory, it's possible, but it actually doesn't help much with
> only four descriptors.  Usually SG buffer management is per page.  And
> if we fix the size per descriptor, it won't fit what user-space apps
> want in most cases.  So practically it mandates the continuous pages.
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
