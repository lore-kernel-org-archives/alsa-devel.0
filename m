From: Marco Vermeulen <vermeulen.mp@gmail.com>
Subject: Re: No sound on MacBook 3.1
Date: Thu, 26 Jun 2008 09:02:02 +0100
Message-ID: <1214467322.3268.11.camel@blackadder.site>
References: <1214384314.21257.12.camel@blackadder.site>
	<48627AD7.4070109@cox.net>
	<7D07D569-9984-4D79-8FD0-9D83C8EC7F27@gmail.com>
	<s5hr6ak4ubv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by alsa0.perex.cz (Postfix) with ESMTP id A442E2459D
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jun 2008 10:02:10 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id e27so183752nfd.32
	for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2008 01:02:06 -0700 (PDT)
In-Reply-To: <s5hr6ak4ubv.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, stan <ghjeold_i_mwee@cox.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2008-06-26 at 07:51 +0200, Takashi Iwai wrote:
> It'd be helpful if we can share the solution in a bit more details...
> 
> 
> thanks,
> 
> Takashi

Sure, no problem. The MacBook in question is the black model, version
3.1. The lspci dump of the sound card is as follows:

00:1b.0 Audio device [0403]: Intel Corporation 82801H (ICH8 Family) HD
Audio Controller [8086:284b] (rev 03)
        Subsystem: Apple Computer Inc. Device [106b:00a1]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 256 bytes
        Interrupt: pin A routed to IRQ 20
        Region 0: Memory at d0700000 (64-bit, non-prefetchable)
[size=16K]
        Capabilities: <access denied>
        Kernel driver in use: HDA Intel
        Kernel modules: snd-hda-intel

On comparing my dump with Leonardo's I found that they were identical.
Now I knew that it could be done.

I then added the following line to my /etc/modprobe.d/sound file:
options snd_hda_intel model=mbp3

This worked fine on openSuse 11.0, but I simply could not get the same
thing to work on Ubuntu Hardy. Perhaps the mactel patches were not
applied to the kernel or something?

Apart from that, the volume still seems to be very low, but sound
quality is perfect.

Hope that sheds some light on it all,
Regards,
Marco.
