From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Future of the HDA driver
Date: Mon, 03 Oct 2011 17:05:31 +0200
Message-ID: <4E89CF3B.3080509@canonical.com>
References: <4E89A3FC.4070606@canonical.com> <s5haa9is1jd.wl%tiwai@suse.de>
	<4E89C0FE.1070001@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 93F8F243F9
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 17:05:32 +0200 (CEST)
In-Reply-To: <4E89C0FE.1070001@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 10/03/2011 04:04 PM, Jaroslav Kysela wrote:
> Date 3.10.2011 14:27, Takashi Iwai wrote:
>> At Mon, 03 Oct 2011 14:01:00 +0200,
>> David Henningsson wrote:
>>>
>>> Hi Takashi etc,
>>>
>>> 1) I think it would make sense to have a designated time and room for a
>>> "future of HDA" discussion in Prague. We could e g discuss input jacks
>>> as kcontrols, and exposing routing to user space, as IIRC Mark Brown was
>>> suggestion earlier. What do you think?
>>
>> Sure, we can hold a meeting spontaneously, as this would be for
>> smaller group.  The sound BoF isn't exactly scheduled at all yet.
>> I don't know how many guys will be there, so I thought it can be
>> managed spontaneously by announcing on the message board there or so.
>
> I'll be there (LinuxCon), so you may count me in.

Ok, looking forward to meeting you!

> To this topics: For some months, I play with an idea to move the whole
> HDA configuration stuff outside the kernel and leave in kernel just
> mandatory things like the HDA controller code and a library with
> functions for the user space code.

In general I like the idea of moving the codec stuff to userspace, 
because that opens up for post-release updates where distributions can 
fix things without having to release an entire kernel.

> Because it's a bit nonsense to start with something totaly new when we
> have a good C codebase with hw descriptions. I looked around the net for
> a simple, small C compiler and it seems that TCC (www.tinycc.org) is
> ideal for this purpose.
>
> I created own instruction 32/64-bit set (C optimized) and I'm now at the
> point that I can compile the HDA code to this instruction set with
> special TCC version and I have a simple disassembler to figure the
> compilation/linking issues.
>
> The ELF loader and instruction parser is also quite complete. but a lot
> of work is missing especially to create the in-kernel library for all
> stuff which is required from the codec description code (kcontrol,
> procfs interface etc.). Also, the codec specific source code should not
> use some in-kernel things directly, but via macros or in-line helpers.

Hmm. I'm not a kernel veteran, but I wonder how well received this will 
be in the wider community. I'm a little sceptic to the additional step 
this will be when it comes to bootstrapping a Linux system, or that you 
need to fix a bug in the userspace code. An extra dependency on a 
compiler. Debugging the interpreter and all that, which must also be 
reasonably easy to understand and maintain. Having a low entrance for 
new contributors is important, and I'm a little worried that this will 
be worse with the suggested implementation.

Also, what about code size here, will the sum of firmware + kernel code 
exceed the current kernel code size?

> The end result should be "one universal kernel driver and firmware files
> describing the codecs". The possibility to compile the codec specific
> source code directly in the kernel should be retained and the source
> code between build-in driver codes and firmware codes should be shared.
>
> I hope that you like this idea like me. All opinions are welcome. We may
> discuss this idea in Prague. I can post my work somewhere for further
> discussion or collaborative development.

Well, having a well working HDA driver for both current and future 
codecs and controllers is very important and from time to time I'll be 
able to contribute moderately. So whatever is decided upon will be my 
focus of contributions personally.

Also, what do you think is the time frame for having something like this 
in mainline kernel?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
