From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: RE: Problem with USB Class 2 Audio Driver
Date: Mon, 6 Sep 2010 16:05:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009061601160.20302-100000@netrider.rowland.org>
References: <003801cb4df1$ad160670$07421350$@com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <003801cb4df1$ad160670$07421350$@com>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Demian Martin <demianm_1-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: 'Daniel Mack' <daniel-rDUAYElUppE@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "'J. Gordon Rankin'" <waudio-P3U7sUXGDiZeoWH0uzbU5w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, 6 Sep 2010, Demian Martin wrote:

> Sorry for the slow response, the communications were trapped by Yahoo's spam
> filter. More details to follow.
> 
> First, I switched to a more powerful platform (slightly) the Intel Atom
> D945GSEJT.
> I have managed to get Win & to run on this and it allowed me to test the

Windows 7?

> same hardware doing the same task (as much as Windows permits). I can using
> adjacent USB ports boot Win & and play 192 KHz content through to the
> Wavelink 192 KHz USB audio interface without problems. This suggests (but
> isn't absolute proof) that the hardware is not a restriction.
> 
> Second, trying the suggestions below I noticed an error making this more
> difficult. When connecting the Wavelink I see its accessible from ALSA:
> auraliti-player:~# aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 1: SPDIF [WaveLink HS SPDIF], device 0: USB Audio [USB Audio]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> 
> But invisible to lsusb. Its device 009 below:

What do you mean by "invisible"?  It's plainly visible as device 009,
as you point out.

> auraliti-player:~# lsusb
> Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 002 Device 006: ID 413c:3012 Dell Computer Corp. Optical Wheel Mouse
> Bus 002 Device 005: ID 413c:2006 Dell Computer Corp.
> Bus 002 Device 004: ID 10d5:000d Uni Class Technology Co., Ltd
> Bus 002 Device 003: ID 413c:1004 Dell Computer Corp.
> Bus 002 Device 002: ID 058f:9254 Alcor Micro Corp. Hub
> Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
> Bus 001 Device 009: ID 21b4:0210
> Bus 001 Device 003: ID 1307:0163 Transcend Information, Inc. 256MB/512MB/1GB
> Flash Drive
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> 
> Here is the message when its installed:
> Sep  6 17:22:29 localhost vmunix: [ 1537.716042] usb 1-7: new high speed USB
> device using ehci_hcd and address 9
> Sep  6 17:22:29 localhost vmunix: [ 1537.830436] usb 1-7: config 1 has an
> invalid interface number: 3 but max is 2
> Sep  6 17:22:29 localhost vmunix: [ 1537.830518] usb 1-7: config 1 has no
> interface number 2
> Sep  6 17:22:29 localhost vmunix: [ 1537.830804] usb 1-7: config 1 has an
> invalid interface number: 3 but max is 2
> Sep  6 17:22:29 localhost vmunix: [ 1537.830884] usb 1-7: config 1 has no
> interface number 2
> Sep  6 17:22:29 localhost vmunix: [ 1537.833069] usb 1-7: configuration #1
> chosen from 2 choices

The stupid firmware lists config 1 twice!  And within config 1, it has 
interfaces 0, 1, and 3!  Nevertheless, it should still work.

> I need to figure out how to install usbmon on this debian platform before I
> can get a trace. I may be able to borrow a USB sniffer if that helps.

There's probably nothing to install.  Try just following the 
instructions.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
