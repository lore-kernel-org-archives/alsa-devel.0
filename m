From: "Ivica Ico Bukvic" <ico@fuse.net>
Subject: RE: [linux-audio-user] snd-hdsp+cardbus=distortion -- the sagacontinues (cardbus driver=culprit?) UPDATE: 99.9% sure it is the cardbus driver yenta_socket
Date: Tue, 30 Mar 2004 14:15:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040330191504.WSHZ17964.smtp2.fuse.net@64BitBadass>
References: <20040330090053.A3956@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040330090053.A3956@flint.arm.linux.org.uk>
To: 'Russell King' <rmk+lkml@arm.linux.org.uk>
Cc: 'A list for linux audio users' <linux-audio-user@music.columbia.edu>, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Russell King [mailto:rmk@arm.linux.org.uk] On Behalf Of Russell King
> Sent: Tuesday, March 30, 2004 3:01 AM
> To: Ivica Ico Bukvic
> Cc: 'A list for linux audio users'; alsa-devel@lists.sourceforge.net;
> linux-kernel@vger.kernel.org; linux-pcmcia@lists.infradead.org
> Subject: Re: [linux-audio-user] snd-hdsp+cardbus=distortion -- the
> sagacontinues (cardbus driver=culprit?) UPDATE: 99.9% sure it is the
> cardbus driver yenta_socket
> 
> On Tue, Mar 30, 2004 at 12:52:11AM -0500, Ivica Ico Bukvic wrote:
> > 6) Pester alsa-dev, lau, and kernel/pcmcia people to death begging for
> help
> > :-)
> >
> > IN-PROGRESS :-)
> 
> What needs to happen is that the card driver author needs to investigate
> what is going on, and, if it seems related to the core PCMCIA core or
> the socket driver, we need to get involved.
> 
> IOW, linux-pcmcia people don't debug card drivers.
> 

To add to what Tim mentioned, I think that the driver is fine as it does
work on select notebooks and desktops (the card can be plugged into either
PCI card or PCMCIA cardbus). Yet, in these select instances it does not work
even though neither the cardbus driver nor the actual card driver do not
report any particular problems. Hence the only logical explanation is that
there is something wrong with the pcmcia controller driver.

This card does tax the throughput of the cardbus like no other card I can
think of, hence the problem may be more widespread, but exhibits itself just
in this case where the cardbus is being pushed to its limits. Yet, the
hardware is not the issue when the same notebook/soundcard combo works
flawlessly in WinXP.

Hope this helps!

Ico
