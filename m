From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Future of the HDA driver
Date: Mon, 03 Oct 2011 16:04:46 +0200
Message-ID: <4E89C0FE.1070001@perex.cz>
References: <4E89A3FC.4070606@canonical.com> <s5haa9is1jd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id D200D24368
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 16:04:46 +0200 (CEST)
In-Reply-To: <s5haa9is1jd.wl%tiwai@suse.de>
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

Date 3.10.2011 14:27, Takashi Iwai wrote:
> At Mon, 03 Oct 2011 14:01:00 +0200,
> David Henningsson wrote:
>>
>> Hi Takashi etc,
>>
>> 1) I think it would make sense to have a designated time and room for a 
>> "future of HDA" discussion in Prague. We could e g discuss input jacks 
>> as kcontrols, and exposing routing to user space, as IIRC Mark Brown was 
>> suggestion earlier. What do you think?
> 
> Sure, we can hold a meeting spontaneously, as this would be for
> smaller group.  The sound BoF isn't exactly scheduled at all yet.
> I don't know how many guys will be there, so I thought it can be
> managed spontaneously by announcing on the message board there or so.

I'll be there (LinuxCon), so you may count me in.

To this topics: For some months, I play with an idea to move the whole
HDA configuration stuff outside the kernel and leave in kernel just
mandatory things like the HDA controller code and a library with
functions for the user space code.

Because it's a bit nonsense to start with something totaly new when we
have a good C codebase with hw descriptions. I looked around the net for
a simple, small C compiler and it seems that TCC (www.tinycc.org) is
ideal for this purpose.

I created own instruction 32/64-bit set (C optimized) and I'm now at the
point that I can compile the HDA code to this instruction set with
special TCC version and I have a simple disassembler to figure the
compilation/linking issues.

The ELF loader and instruction parser is also quite complete. but a lot
of work is missing especially to create the in-kernel library for all
stuff which is required from the codec description code (kcontrol,
procfs interface etc.). Also, the codec specific source code should not
use some in-kernel things directly, but via macros or in-line helpers.

The end result should be "one universal kernel driver and firmware files
describing the codecs". The possibility to compile the codec specific
source code directly in the kernel should be retained and the source
code between build-in driver codes and firmware codes should be shared.

I hope that you like this idea like me. All opinions are welcome. We may
discuss this idea in Prague. I can post my work somewhere for further
discussion or collaborative development.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
