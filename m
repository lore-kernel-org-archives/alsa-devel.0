From: Roman Haefeli <reduzent@gmail.com>
Subject: Re: hdsp rpm support
Date: Wed, 15 Feb 2012 00:07:20 +0100
Message-ID: <1329260840.2350.27.camel@yoyo5>
References: <1326877559.24738.84.camel@yoyo4>
	<20120118102658.GA5351@linuxaudio.org> <1326884040.18308.6.camel@yoyo4>
	<4F3926E3.1050809@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DA8D24158
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 00:07:26 +0100 (CET)
Received: by eaan11 with SMTP id n11so149946eaa.38
	for <alsa-devel@alsa-project.org>; Tue, 14 Feb 2012 15:07:26 -0800 (PST)
In-Reply-To: <4F3926E3.1050809@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Adrian

On Mon, 2012-02-13 at 16:06 +0100, Adrian Knoth wrote:
> On 01/18/2012 11:54 AM, Roman Haefeli wrote:
> Sorry for the late reply, I was on vacation...

No problem at all. I'm glad to get a response.

> [RME HDSP RPM]
> > May I ask kindly for the 'other' version of the driver, which I would be
> > happy to test?
> 
> As already mentioned by Fons, there are so many differnt versions now
> that I hardly remember which one is supposed to work. ;)
> 
>     http://adi.loris.tv/hdsp_20111031.tar.bz2
> 
> 
> seems to be a combined archive. It contains two versions of the driver,
> the first (hdsp.c) is more or less what's in current alsa-driver, the
> other one (hdsp-test.c) is what turned out to be working for one user,
> so you would do

Unfortunately, it seems that none of those versions is working for me. 
I did as you suggested and inserted the module based on hdsp-test.c.
When inserting the cardbus interface (with connected iobox), I get this:

---
Feb 14 23:48:38 yoyo5 kernel: [40573.384092] pcmcia_socket pcmcia_socket0: pccard: CardBus card inserted into slot 0
Feb 14 23:48:38 yoyo5 kernel: [40573.384130] pci 0000:16:00.0: [10ee:3fc5] type 0 class 0x000401
Feb 14 23:48:38 yoyo5 kernel: [40573.384172] pci 0000:16:00.0: reg 10: [mem 0x00000000-0x0000ffff]
Feb 14 23:48:38 yoyo5 kernel: [40573.384337] pci 0000:16:00.0: BAR 0: assigned [mem 0x80000000-0x8000ffff]
Feb 14 23:48:38 yoyo5 kernel: [40573.384352] pci 0000:16:00.0: BAR 0: set to [mem 0x80000000-0x8000ffff] (PCI address [0x80000000-0x8000ffff])
Feb 14 23:48:38 yoyo5 kernel: [40573.384376] pci 0000:16:00.0: cache line size of 64 is not supported
Feb 14 23:48:38 yoyo5 kernel: [40573.384673] hdsp 0000:16:00.0: enabling device (0000 -> 0002)
Feb 14 23:48:38 yoyo5 kernel: [40573.384691] hdsp 0000:16:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
Feb 14 23:48:41 yoyo5 kernel: [40576.408074] Hammerfall-DSP: no IO box connected!
Feb 14 23:48:41 yoyo5 kernel: [40576.408148] hdsp 0000:16:00.0: PCI INT A disabled
Feb 14 23:48:41 yoyo5 kernel: [40576.408173] hdsp: probe of 0000:16:00.0 failed with error -5
---

It's seems it's not even recognizing that an RPM box is attached.

The other version (hdsp.c from your archive) gives me this, which is
similar to what I get with the stock alsa drivers:

---
Feb 14 23:57:52 yoyo5 kernel: [41126.784055] pcmcia_socket pcmcia_socket0: pccard: CardBus card inserted into slot 0
Feb 14 23:57:52 yoyo5 kernel: [41126.784093] pci 0000:16:00.0: [10ee:3fc5] type 0 class 0x000401
Feb 14 23:57:52 yoyo5 kernel: [41126.784134] pci 0000:16:00.0: reg 10: [mem 0x00000000-0x0000ffff]
Feb 14 23:57:52 yoyo5 kernel: [41126.784300] pci 0000:16:00.0: BAR 0: assigned [mem 0x80000000-0x8000ffff]
Feb 14 23:57:52 yoyo5 kernel: [41126.784315] pci 0000:16:00.0: BAR 0: set to [mem 0x80000000-0x8000ffff] (PCI address [0x80000000-0x8000ffff])
Feb 14 23:57:52 yoyo5 kernel: [41126.784339] pci 0000:16:00.0: cache line size of 64 is not supported
Feb 14 23:57:52 yoyo5 kernel: [41126.784639] hdsp 0000:16:00.0: enabling device (0000 -> 0002)
Feb 14 23:57:52 yoyo5 kernel: [41126.784658] hdsp 0000:16:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
Feb 14 23:57:54 yoyo5 kernel: [41129.343204] Hammerfall-DSP: wait for FIFO status <= 0 failed after 30 iterations
Feb 14 23:57:54 yoyo5 kernel: [41129.346250] Hammerfall-DSP: wait for FIFO status <= 0 failed after 30 iterations
Feb 14 23:57:54 yoyo5 kernel: [41129.351601] Hammerfall-DSP: loading firmware
Feb 14 23:57:55 yoyo5 kernel: [41129.857764] Hammerfall-DSP: wait for FIFO status <= 0 failed after 5000 iterations
Feb 14 23:57:55 yoyo5 kernel: [41129.857767] Hammerfall-DSP: timeout waiting for download preparation
Feb 14 23:57:55 yoyo5 kernel: [41129.857769] Hammerfall-DSP: couldn't get firmware from userspace. try using hdsploader
Feb 14 23:57:55 yoyo5 kernel: [41129.857771] Hammerfall-DSP: card initialization pending : waiting for firmware
---

>From what I can tell, it finds the correct firmware. If I remove the
firmware file, I get different messages. So the problem must be
something else.


> Final remark: For some devices (digiface, multiface, iirc), the firmware
> filename was too long. mv /lib/firmware/hdsploader/* /lib/firmware/ did
> the trick, but iirc, the RPM wasn't affected.

With hdsp-test.c, it doesn't even try to find the firmware, since it
doesn't seem to see the attached iobox.

Is there something else I could try?

Roman
