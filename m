From: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [LAD] USB-Audio and XHCI (USB 3)
Date: Sun, 1 Jan 2012 17:57:32 +0000
Message-ID: <CAE-xCyPhrS6pgY0T9SG0TCubSi0CE2Yd5H=ttOzBmvgrR8fTPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/options/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, gdiffey-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org, linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi everyone,

I was wondering if anyone managed to run a USB 2 soundcard on a USB3
(XHCI) port?

I'm running the kernel 3.2 rc7.

With the M-Audio Fast Track Ultra (USB 2):
The output of dmesg is this:
[  475.094595] usb 3-1: new high-speed USB device number 2 using xhci_hcd
[  475.108605] usb 3-1: config 1 interface 3 altsetting 0 bulk
endpoint 0x7 has invalid maxpacket 8
[  475.108615] usb 3-1: config 1 interface 3 altsetting 0 bulk
endpoint 0x87 has invalid maxpacket 8
[  475.108958] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[  475.109328] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[  475.109879] xhci_hcd 0000:04:00.0: WARN: short transfer on control ep
[  475.110564] xhci_hcd 0000:04:00.0: ERROR: unexpected command
completion code 0x11.
[  475.110585] usb 3-1: can't set config #1, error -22

The snd-usb-audio module is not probed automatically, and if I
modprobe it manually, no sound card is detected.

The error message is described in this bug:
https://bugzilla.novell.com/show_bug.cgi?id=3D679944
but if I understand well, kernel wise, everything is "ok" and the
issue lies in Alsa

The output of lsusb is:
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 002: ID 8087:0020 Intel Corp. Integrated Rate Matching Hub
Bus 002 Device 002: ID 8087:0020 Intel Corp. Integrated Rate Matching Hub
Bus 001 Device 003: ID 050d:0307 Belkin Components
Bus 002 Device 003: ID 0408:1af1 Quanta Computer, Inc.
Bus 001 Device 004: ID 046d:c51b Logitech, Inc. V220 Cordless Optical
Mouse for Notebooks
Bus 003 Device 002: ID 0763:2080 Midiman M-Audio RunTime DFU

The Edirol UA-25Ex (USB 1) works fine, I get a few warnings in dmesg
but the sound card is detected and functional...

Let me know if I should provide any more info, or outputs, anything
that can help.

Kind Regards,
Aur=E9lien
