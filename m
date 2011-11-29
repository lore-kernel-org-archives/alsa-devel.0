From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Kernel: snd-usb-audio: probe of 2-2:1.0 failed
	with error -5
Date: Tue, 29 Nov 2011 08:58:51 -0800
Message-ID: <CA+55aFxjrCZTEzznjEK_FjadortNS9GPtcDH=D8-HebKKhQ8Bg@mail.gmail.com>
References: <4ED4D58D.60109@nixbits.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DF5124340
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 17:59:14 +0100 (CET)
Received: by eaai13 with SMTP id i13so3323884eaa.38
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 08:59:14 -0800 (PST)
In-Reply-To: <4ED4D58D.60109@nixbits.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: admin@nixbits.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 29, 2011 at 4:52 AM, Nixbits Admin <admin@nixbits.org> wrote:
>
> While knowing that your time is precious and without wanting to making you
> spend more than what you may be able to spare for my problem; i would like
> ask you if you could take a look at this issue.
>
> https://forums.gentoo.org/viewtopic-p-6885908.html#6885908
>
> snd-usb-audio: probe of 2-2:1.0 failed with error -5

This is related to the line above it:

  Nov 29 07:21:21  kernel: skipping empty audio interface (v1)
  Nov 29 07:21:21  kernel: snd-usb-audio: probe of 2-3:1.0 failed with error -5

which in turn is because of a zero "bInCollection" value in the device
control header. I'm adding some sound people to the cc, in case
anybody has more clues about what's wrong with that particular device
- I don't personally have any real clue about usb audio.

As to your UHCI/EHCI confusion - it's actually a USB confusion. EHCI
was done as a add-on to UHCI (or OHCI), to the point where there is
both a UHCI *and* an EHCI controller involved (on the same silicon)
and they have this odd hand-over thing where one part (the UHCI part)
handles legacy devices, and then the new bolted-on EHCI part handles
the full USB-2.0 functionality.

So the UHCI/EHCI confusion is deep in the silicon itself. If you
attach a usb-1.1 device, it will be handed off to the UHCI part, if
you attach a 2.0 device it will be handled by the EHCI part of the
controller. Oh the wonders of crazy backwards compatibility hacks..

                                      Linus
