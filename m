From: Roman Haefeli <reduzent@gmail.com>
Subject: Re: hdsp rpm support
Date: Thu, 17 May 2012 15:21:14 +0200
Message-ID: <1337260874.2077.6.camel@yoyo5>
References: <1326877559.24738.84.camel@yoyo4>
	<20120118102658.GA5351@linuxaudio.org> <1326884040.18308.6.camel@yoyo4>
	<4F3926E3.1050809@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 522EE103FC8
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2012 15:21:17 +0200 (CEST)
Received: by bkcjg15 with SMTP id jg15so1556321bkc.38
	for <alsa-devel@alsa-project.org>; Thu, 17 May 2012 06:21:16 -0700 (PDT)
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

In the meantime I upgraded my machine to Ubuntu 12.04 which comes with
Linux 3.2.0 and alsa 1.0.25. The symptoms are still the same. When I
insert the cardbus adapter and load the snd-hdsp module, I get this in
dmesg:

May 17 15:16:47 yoyo5 kernel: [  606.545116] pcmcia_socket pcmcia_socket0: pccard: CardBus card inserted into slot 0
May 17 15:16:47 yoyo5 kernel: [  606.545151] pci 0000:16:00.0: [10ee:3fc5] type 0 class 0x000401
May 17 15:16:47 yoyo5 kernel: [  606.545194] pci 0000:16:00.0: reg 10: [mem 0x00000000-0x0000ffff]
May 17 15:16:47 yoyo5 kernel: [  606.545368] pci 0000:16:00.0: BAR 0: assigned [mem 0x80000000-0x8000ffff]
May 17 15:16:47 yoyo5 kernel: [  606.545383] pci 0000:16:00.0: BAR 0: set to [mem 0x80000000-0x8000ffff] (PCI address [0x80000000-0x8000ffff])
May 17 15:16:47 yoyo5 kernel: [  606.545407] pci 0000:16:00.0: cache line size of 64 is not supported
May 17 15:16:47 yoyo5 kernel: [  606.545723] snd_hdsp 0000:16:00.0: enabling device (0000 -> 0002)
May 17 15:16:47 yoyo5 kernel: [  606.545742] snd_hdsp 0000:16:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
May 17 15:16:50 yoyo5 kernel: [  609.106261] Hammerfall-DSP: wait for FIFO status <= 0 failed after 30 iterations
May 17 15:16:50 yoyo5 kernel: [  609.109362] Hammerfall-DSP: wait for FIFO status <= 0 failed after 30 iterations
May 17 15:16:50 yoyo5 kernel: [  609.114447] Hammerfall-DSP: loading firmware
May 17 15:16:50 yoyo5 kernel: [  609.625540] Hammerfall-DSP: wait for FIFO status <= 0 failed after 5000 iterations
May 17 15:16:50 yoyo5 kernel: [  609.625543] Hammerfall-DSP: timeout waiting for download preparation
May 17 15:16:50 yoyo5 kernel: [  609.625545] Hammerfall-DSP: couldn't get firmware from userspace. try using hdsploader
May 17 15:16:50 yoyo5 kernel: [  609.625548] Hammerfall-DSP: card initialization pending : waiting for firmware

You said you had so many different versions of the hdsp driver. I'm
willing to test them all in order to get it working, but I'd need the
sources. Can you give me access to the sources?

Many thanks in advance.

Roman


On Mon, 2012-02-13 at 16:06 +0100, Adrian Knoth wrote:
> On 01/18/2012 11:54 AM, Roman Haefeli wrote:
> 
> 
> Sorry for the late reply, I was on vacation...
> 
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
> 
>     mv hdsp-test.c hdsp.c
> 
> followed by
> 
>     make install
> 
> Note that this driver uses hdsp.ko as the module name in contrast to
> snd_hdsp.ko from your tree, so you might need to add
> 
> blacklist snd_hdsp
> 
> to /etc/modprobe.d/foobar.conf
> 
> 
> Please report back.
> 
> 
> Final remark: For some devices (digiface, multiface, iirc), the firmware
> filename was too long. mv /lib/firmware/hdsploader/* /lib/firmware/ did
> the trick, but iirc, the RPM wasn't affected.
> 
> 
> Cheers
