From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Problem with intel-hda integrated audio
Date: Thu, 22 May 2008 15:51:39 -0700
Message-ID: <1211496699.8312.155.camel@razman>
References: <200805222138.35409.matteo.sasso@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B9C1103802
	for <alsa-devel@alsa-project.org>;
	Fri, 23 May 2008 00:51:42 +0200 (CEST)
In-Reply-To: <200805222138.35409.matteo.sasso@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matteo Sasso <matteo.sasso@gmail.com>
Cc: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

IF this is the same issue as previously posted in alsa-user, then i have
an idea what may be going on.  Try rebooting the system with "acpi=off"
in the kernel boot parameters.  If this makes audio work, you have an
issue with your acpi tables.

Could you also download and run alsa-info.sh from
http://alsa-project.org/ Help to debug section?

Tobin


On Thu, 2008-05-22 at 21:38 +0200, Matteo Sasso wrote: 

> Hello, I'm having a problem with a soundcard under ubuntu. I tried nearly 
> every workaround I could find on the Internet but I have not been successful 
> so far.
> 
> The computer in question is a Toshiba Satellite Pro U200 series. The soundcard 
> seems to be correctly identified by ALSA but it seems muted, nothing I tried 
> seems to work. I followed the instructions given at
> http://www.mjmwired.net/kernel/Documentation/sound/alsa/ALSA-Configuration.txt
> I determined that my card uses a AD1981 codec, so I added the following 
> to /etc/modprobe.d/alsa-base:
> 
> options snd-hda-intel model=toshiba
> 
> I tried many other combinations (3stack, basic, laptop), with and 
> without "position_fix=1". I also tried using underscores instead of hypens 
> ("snd_hda_intel"). I run update-initramfs -u after every try.
> 
> lspci -vn has to say the following:
> 00:1b.0 0403: 8086:27d8 (rev 02)
>         Sybsystem: 1179:0001
>         Flags: bus master, fast devsel, latency 0, IRQ 23
>         Memory at 50080000 (64-bit, non-prefetchable) [size=16K]
>         Capabilities: [50] Power Management version 2
>         Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+ 
> Queue=0/0 Enable-
>         Capabilities: [70] Express Unknown type IRQ 0
> 
> I'll keep tabs on this mailing list, so feel free to ask for more info.
> Any help is appreciated.
> Thanks.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- Tobin Davis 


Actresses will happen in the best regulated families.
		-- Addison Mizner and Oliver Herford, "The Entirely
		New Cynic's Calendar", 1905
