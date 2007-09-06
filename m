From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] Gallant SC-6000 driver (4th version)
Date: Thu, 06 Sep 2007 12:12:42 +0200
Message-ID: <46DFD29A.6020601@gmail.com>
References: <46dfa2e7d6be4@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 4771924363
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 12:19:11 +0200 (CEST)
In-Reply-To: <46dfa2e7d6be4@wp.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09/06/2007 08:49 AM, Krzysztof Helt wrote:

> Actually, the parport_pc driver is loaded by the udev by default, so the
> IRQ7 cannot be requested (I tested - IRQ7 request failed even if I had 
> not used the printer).

Not everybody uses udev. But more importantly, only if the hardware in 
question is discoverable. A parallel port will these days normally be 
advertised using PnP (BIOS/ACPI) in fact which puts it on the same footing 
as ISA-PnP and PCI with respect to this issue, but we are specifically 
discussing this in the context of legacy ISA cards.

So imagine you have another piece of legacy ISA hardware sitting on the 
resources. Nothing will tell your driver that it is occupying the resources 
in question so it goes ahead and grabs them after which both your hardware 
and the other one fail, leaving this poor unaware user for whom autoprobing 
is supposedly helpful clueless as to why nothing works.

Then there's the bit about this user generally needing to know what resource 
is going to be assigned so he can reserve it in the BIOS anyway. Without, an 
IRQ may not even be useable from the ISA bus on some systems.

And _then_ there's the bit about the ISA probing being a huge gaping race by 
design. There's really no defending that massive junk. All ISA autoprobing 
is bad engineering and should be ripped out and shot, period. It's broken 
both by design and implementation. The solution to making things nicer is 
not autoprobing but not using legacy ISA -- and basically noone is other 
than for entertainment purposes.

Any system with ISA slots and running a modern kernel support ISA-PnP or 
PnP-BIOS for onboard chips (and not to mention PCI) which solves the problem 
nicely through being discoverable. Us entertainment-value users do not feel 
there's anything wrong with sticking

	options snd-foo port=0x220 irq=5 dma=1

in /etc/modprobe.conf

> I don't know what is expected from WSS, but if the SB Pro mode gives
> full duplex 16-bit stereo, there is no reason to use WSS mode.

Full duplex (simultaneous playback and capture) is something that neither Sb 
Pro nor CS4231 does. I do see that SB Pro doesn't natively support S16_LE it 
seems...

>> Quite sure that 5 works by the way? On a Sound Galaxy, 5 only works for
>> the SB part (and 11 only for the WSS).

> It is the IRQ found most times as the first free during card tests. It
> worked on all free IRQs from the range (the 10 or 11 is occupied by
> USB/PS2 and I haven't bothered to make it free). It seems that ASC-9308
> is more capable (in this respect) than SG chips.

Okay, so it's at least in some respects really different. That probably 
means a seperate driver makes sense.

Rene.
