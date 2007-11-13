From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: asihpi driver -> kernel
Date: Tue, 13 Nov 2007 23:01:57 +1300
Message-ID: <47397615.4000201@audioscience.com>
References: <200709051300.35503.linux@audioscience.com>
	<s5hzm01tn8w.wl%tiwai@suse.de> <47141823.4000307@audioscience.com>
	<s5hbqaqrppa.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id E687D2439A
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 11:02:04 +0100 (CET)
Received: from [192.168.1.4]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JRF00GEEVVDQT30@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Tue, 13 Nov 2007 23:02:01 +1300 (NZDT)
In-reply-to: <s5hbqaqrppa.wl%tiwai@suse.de>
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
Cc: Greg KH <greg@kroah.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Hi Eliot,
> 
> [it seems that you Cc'ed to the old alsa-devel ML so the last one
>  seemed missing.]
> 
> At Tue, 16 Oct 2007 14:47:15 +1300,
> Eliot Blennerhassett wrote:
>> Hi Takashi,
>>
>> still trying to move forward on this...
>>
>> Looking for "what is the first step" change to make in your opinion?
> 
> The first step would be to get closer to linux kernel coding style.
> Namely,
> - get rid of C++ style function names, variables and field names
>   (no hungarian!)

This (though 'frowned on') is not *required* by kernel coding_style
document.  I don't plan on doing such major cosmetic surgery if not
necessary.   If I can get source to pass checkpatch.pl, I would hope it
would be considered.

> - remove API wrappers

Working on it, will submit new patches in the next week or so.

Spin lock wrappers can not be removed because of the way alsa midlevel
calls driver with different IRQ disabling context for different functions.

> Eventually, we may get rid of unneeded typedefs, too.
> 
> Then, we can begin with simplifying the driver structure.  Currently,
> asihpi and hpi are almost indepedent implementations.  This makes life
> harder.
> 
> 
>> Takashi Iwai wrote:
>>> At Wed, 05 Sep 2007 13:00:35 +1200,
>>> Eliot Blennerhassett wrote:
>>>> Hi Takashi,
>>>>
>>>> I'd like to talk more about what you think is needed to get asihpi driver 
>>>> ready for kernel tree.
>>>>
>>>> I think for now we should put aside cosmetic coding style changes (eg. comment 
>>>> style, whitespace etc.) these are fixable with combination of automated tools 
>>>> and some monkey work.
>>>>
>>>> So, lets start with the hard part. If we can't solve that there is no point in 
>>>> cosmetics!
>>>>
>>>> A while ago you said "The specific problem I'm concerned is the "glue-code" 
>>>> style in HPI driver.  The OS-independent wrapper code is often disliked by 
>>>> kernel maintainers. "
>>>>
>>>> Can you point to specific examples.  Even better suggest how you think it 
>>>> should be done better.  Either way I need to consider how your concerns could 
>>>> be addressed without breaking our codebase for other OSes etc. 
>>>>
>>>> thanks and regards
>>> The problem is that the whole "wrapping" is superfluous when you
>>> concentrate on Linux driver.  Merging into the linux kernel tree means
>>> that the driver would be dedicated to Linux.  It's no longer your
>>> child, and it's no longer for every other OS.  Thus, "common codebase"
>>> doesn't exist per se.
>>>
>>> For example, the whole definitions in hpios_linux_kernel.h should go
>>> away.  The driver should use the native kernel API instead.
>> Even this is not so hard, as it a mechanical process to replace wrapped
>> calls with linux native calls.
> 
> OK, then it's fine.
> 
>>> I know it's a very hard decision.  Supporting other OSes is very
>>> important in most cases.  OTOH, the slim-down is the best way to make
>>> the driver code maintainable for other people.  Honestly, I find it
>>> also hard to maintain/debug the current ASIHPI code.  It's too
>>> different from the normal codes, and understanding it alone takes too
>>> much energy before analyzing the problem.

Still I cannot imagine that anyone else will be at the sharp end of
debugging and adding extra features to the driver other than ASI
personnel.  When I see a significant patch I'll revise my opinion.

If porting of new features is not an automated process, it is the linux
driver that will start to rot.

I stick to my position that 95% windows users finding bugs benefits the
5% linux users when common code is used, and this is worth much more
than how identifiers are spelled.

>> This is where I need more input, because to _me_ (of course) the code is
>> understandable.
>>
>> Is it the whole source or just parts that are hard.
>> E.g toplevel asihpi.c Ok/No?
> 
> The code in asihpi.c is readable enough.  But, other parts are
> different.  The difficulty is that the driver structure isn't
> straight (apart from the coding style issues).  We have an entry point
> for PCI driver _and_ indepdendent HPI initialization.  This is already
> puzzling because HPI is also assigned to the corresponding PCI
> device.

HPI is still needed for e.g compressed audio play/record, profile and
assert monitoring, existing HPI applications.

It provides the ability to use HPI-only applications while at the same
time using channels with ALSA to 'just play some sound'

> Also, the message union/struct is another stuff that is pretty hard to
> follow.  Since we use no C++, union is often bad for readability.
> Could it be a bit simpler?

Very difficult. message/response structure/unions are deeply embedded in
the DSP code that runs on the cards. They must remain exactly as
specified in hpi.h

> 
> 
>>> The coding-style issues are similar problems.  When C++-style codes
>>> appear in the tree of C-codes, they are strange.  Simply so.  It makes
>>> difficult to find the problematic part.  "A buggy part looks buggy" --
>>> it's the whole point of having a uniform coding style.
>> Again, a mechanical process to change comments and style etc.
> 
> Then it's fine with me.  Let's try and see the progress.


regards

Eliot
