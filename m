From: chris@idlelion.net
Subject: Re: Bug 305
Date: Fri, 10 Aug 2007 09:50:21 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0708100947310.16282@tick.idlelion.net>
References: <Pine.LNX.4.64.0708091016470.10961@tick.idlelion.net>
	<s5hmyx0wrj2.wl%tiwai@suse.de>
	<Pine.LNX.4.64.0708100932240.16282@tick.idlelion.net>
	<s5hfy2rcv0o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rwcrmhc15.comcast.net (rwcrmhc15.comcast.net [216.148.227.155])
	by alsa0.perex.cz (Postfix) with ESMTP id EAF161038A0
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Aug 2007 16:50:36 +0200 (CEST)
In-Reply-To: <s5hfy2rcv0o.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 10 Aug 2007, Takashi Iwai wrote:

> At Fri, 10 Aug 2007 09:32:59 -0500 (CDT),
> chris@idlelion.net wrote:
>>
>> On Thu, 9 Aug 2007, Takashi Iwai wrote:
>>
>>> At Thu, 9 Aug 2007 10:18:14 -0500 (CDT),
>>> chris@idlelion.net wrote:
>>>>
>>>> I tested Fedora 8 on my ThinkPad 600X. The 600X has a CS4264, and F8 uses
>>>> a 2.6.23 kernel (I forget the version at the moment). The sound does not
>>>> work after resume.
>>>
>>> I think it nevered worked after resume?
>>>
>>>> How should I check whether the fix for this issue is included in a kernel?
>>>> Version number?
>>>
>>> The fixes for cs46xx are already in 2.6.23-rc* kernel.
>>
>> OK. That's in F8T1 stock kernel, so 305 is not fixed. Can I do anything
>> else to help out?
>
> Didn't you read my last mail?
>
> You can build ALSA drivers externally from ALSA driver tree, at best,
> from HG repository.  Please consult furhter on alsa-devel ML.

I did read your mail.

It is not at all clear that getting the latest build would be useful if 
the patch that was supposed to fix this bug is already in the kernel I'm 
using.

If I missed any traffic about more changes to the cs46xx driver, my 
apologies. I'll download the latest code as soon as my schedule allows.

Chris
