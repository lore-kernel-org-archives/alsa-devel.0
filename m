From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Future of the HDA driver
Date: Tue, 04 Oct 2011 10:56:13 +0200
Message-ID: <4E8ACA2D.9050908@perex.cz>
References: <4E89A3FC.4070606@canonical.com> <s5haa9is1jd.wl%tiwai@suse.de>
	<4E89C0FE.1070001@perex.cz> <s5hsjnaqdyu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 3666124585
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 10:56:14 +0200 (CEST)
In-Reply-To: <s5hsjnaqdyu.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Date 3.10.2011 17:42, Takashi Iwai wrote:
> At Mon, 03 Oct 2011 16:04:46 +0200,
> Jaroslav Kysela wrote:
>>
>> Date 3.10.2011 14:27, Takashi Iwai wrote:
>>> At Mon, 03 Oct 2011 14:01:00 +0200,
>>> David Henningsson wrote:
>>>>
>>>> Hi Takashi etc,
>>>>
>>>> 1) I think it would make sense to have a designated time and room for a 
>>>> "future of HDA" discussion in Prague. We could e g discuss input jacks 
>>>> as kcontrols, and exposing routing to user space, as IIRC Mark Brown was 
>>>> suggestion earlier. What do you think?
>>>
>>> Sure, we can hold a meeting spontaneously, as this would be for
>>> smaller group.  The sound BoF isn't exactly scheduled at all yet.
>>> I don't know how many guys will be there, so I thought it can be
>>> managed spontaneously by announcing on the message board there or so.
>>
>> I'll be there (LinuxCon), so you may count me in.
> 
> Good to hear!
> 
>> To this topics: For some months, I play with an idea to move the whole
>> HDA configuration stuff outside the kernel and leave in kernel just
>> mandatory things like the HDA controller code and a library with
>> functions for the user space code.
>>
>> Because it's a bit nonsense to start with something totaly new when we
>> have a good C codebase with hw descriptions. I looked around the net for
>> a simple, small C compiler and it seems that TCC (www.tinycc.org) is
>> ideal for this purpose.
>>
>> I created own instruction 32/64-bit set (C optimized) and I'm now at the
>> point that I can compile the HDA code to this instruction set with
>> special TCC version and I have a simple disassembler to figure the
>> compilation/linking issues.
>>
>> The ELF loader and instruction parser is also quite complete. but a lot
>> of work is missing especially to create the in-kernel library for all
>> stuff which is required from the codec description code (kcontrol,
>> procfs interface etc.). Also, the codec specific source code should not
>> use some in-kernel things directly, but via macros or in-line helpers.
>>
>> The end result should be "one universal kernel driver and firmware files
>> describing the codecs". The possibility to compile the codec specific
>> source code directly in the kernel should be retained and the source
>> code between build-in driver codes and firmware codes should be shared.
>>
>> I hope that you like this idea like me. All opinions are welcome. We may
>> discuss this idea in Prague. I can post my work somewhere for further
>> discussion or collaborative development.
> 
> As David already wrote, moving a big stuff into user-space is nice in
> one side.  I fully agree, too.  And, the techniques you described in
> the above sounds pretty interesting, makes me curious about the
> detailed implementation.  But, it's a different question whether this
> would be accepted as the standard.
> 
> First off, the biggest concern in this approach is the extra step user
> need.  In general, moving configuration to user-space from the device
> driver tends to fail.  You might remember the attempt of em28xx
> TV-tuner driver, or such examples.  It's mostly because the extra step 
> and lost sync of code control from the kernel tree lead to more
> burden for users, even for distros.

I read the lwn artice about the em28xx driver and this is a bit
different example.

> Another big concern is that you'll run a native code in kernel-space.
> Such a support is unlikely welcome into the kernel tree, no matter how
> you say it must be safe.

Yes, it is for the linux kernel list discussion what the native means
and what kind of userspace <-> kernel space interaction is allowed. For
example, the BPF JIT landed to the current 3.x kernels.

>From the security perspective, the loading of the firmware files with
the interpreted bytecode can be handled in exactly same way as the
native kernel modules. If someone creates a broken native kernel module,
it has the same impact as a broken interpreted code, but the interpreter
can detect the failure (when the interpreter is properly written) and
terminate the bytecode processing.

> Lastly, there is no much need of specific "firmware" nowadays in most
> cases.  The most of the parser code can be shared by each codec, and
> the difference between codec drivers would become minimum in the end.
> If so, there is no need for loading some codes dynamically.  You can
> simply use a module as of now.

I meant to move all codec (patch/quirk) codes outside the kernel space.
Ideally, only the HDA PCM interface and basic verb I/O should be in the
kernel, all other things (PCM assignment, kcontrol creation and
handling, unsolicited event handling, HDMI handling etc.) might be moved
outside. Basically, only hda_intel.c and some portions of hda_codec.c
should be in the kernel.

> Anyway, the technique sounds interesting, as mentioned, so let's keep
> discussions.

I created a wiki page
http://www.alsa-project.org/main/index.php/HDA_UserSpace which tries to
gather all major information for further discussions. I will release
some code in few days.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
