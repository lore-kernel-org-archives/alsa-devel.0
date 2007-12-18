From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: asihpi driver -> kernel
Date: Wed, 19 Dec 2007 09:52:08 +1300
Message-ID: <476832F8.6070001@audioscience.com>
References: <200709051300.35503.linux@audioscience.com>
	<s5hzm01tn8w.wl%tiwai@suse.de> <47141823.4000307@audioscience.com>
	<s5hbqaqrppa.wl%tiwai@suse.de> <47397615.4000201@audioscience.com>
	<475886C3.9070301@audioscience.com> <s5hve71dzqx.wl%tiwai@suse.de>
	<47671166.2050405@audioscience.com> <s5hlk7sxisi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 4D37210385C
	for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2007 21:52:16 +0100 (CET)
Received: from [192.168.1.4]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JT900MPHJAZK920@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Wed, 19 Dec 2007 09:52:13 +1300 (NZDT)
In-reply-to: <s5hlk7sxisi.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 18 Dec 2007 13:16:38 +1300,
> Eliot Blennerhassett wrote:

> Well, the doxygen comment is another issue.  Usually, the kerneldoc
> allows you to write (semi-)javadoc style comments for each function.
> It begins with "/**" and has standard "@parameter description" lines.

This breaks "define things in only one place" rule. I.e. my style
doesn't require the parameter name etc to be repeated in the comment.


> So, one thing I forgot to mention is to avoid /** for non-kerneldoc
> comments.

What! just when I think I have everything covered, another picky
requirement pops up. When will this end!

>> I think all the thin wrappers have been removed. What remain are
>>
>> 1) Spinlock wrappers, the comments in the code tell why
>> /* The reason for all this evilness is that ALSA calls some of a drivers
>>  * operators in atomic context, and some not.  But all our functions channel
>>  * through the HPI_Message conduit, so we can't handle the different context
>>  * per function
>>  */
> 
> Then this shouldn't be expressed as a spinlock wrapper.  You cannot
> use a single lock for that.  And the way you hack doesn't look correct
> for schedulable contexts...

AFAIK it works.  We can do away with it if you can tell me how to stop
alsa midlevel calling HPI functions in both schedulable and
non-schedulable contexts.

>> 2) LockedMem wrappers.  These provide tracking for the DMA areas
>> Need to keep track of all the info about the mem area so it can be freed
>> again at the end
> 
> Hm, but still I don't see the reason to use kmem_cache there.

Its a convenient way to allocate however many small chunks are needed.
Otherwise we need to statically allocate or malloc enough space for
every possible stream on every possible card. I.e. 32 streams * 16 cards.

Or can do a major redesign of this part and absorb the DMA mem tracking
into per-adapter data structures. Not gonna happen soon here.

> 
>> E.g. pci_free_consistent(pMemArea->pdev, pMemArea->size,
>> 			pMemArea->cpu_addr, pMemArea->dma_addr);
> 
> Use dma_alloc_coherent() / dma_free_coherent() instead.
> pci_*_consistent() are obsolete.
> 
>>> I feel the chrdev should be
>>>   rather bound to the existing ALSA device, e.g. using hwdep instead.
>>>   Then the whole story about registration would become more straight.
>> ...yes I'm interested.
>> Currently HPI userspace lib just works whether ALSA or plain HPI driver
>> is loaded. How would this work with your scenario?
> 
> The independent HPI driver doesn't exist with your current version
> (all merged to snd-asihpi).  So, this question sounds irrelevant as
> now.

It exists for those who build it themselves or get it from 3rd party
repos.  We have a number of applications that use HPI, we still want to
be able to use them to test the cards etc, even if ALSA driver is loaded.

For our existing customers, HPI has been around much longer than ALSA,
so we need a transitional period where both interfaces are available
simultaneously. I'd say about 5 years from when the driver is accepted
into the kernel should be sufficient.

(For example Rivendell http://www.rivendellaudio.org/ radio automation
uses HPI to play/record mpeg audio using our on-card processing)

> If we *really* need to provide an independent HPI access, then hpi
> should have its own device (most easily via platform device).  But, I
> feel it's just give compliexity in the end.

Another possibility is to make HPI access via optional loadable module.
ALSA driver would only need to export HPI_Message() for this to be
workable.  Already need to export HPI_Message to support our V4L driver.

>>> - Don't use bitfields for data communication.  It's higly unportable.
>>>   Use explit bit shift and mask instead.
>
> struct hpi_handle has bitfields.  I think it's used very commonly in
> asihpi.

The bitfields are all created and used by the same code module,  they
are never referenced outside hpifunc.c (so its not "data communication"
in my book).
IMO it improves readability, and let the compiler figure out the bit
shift and mask stuff.

regards

Eliot
