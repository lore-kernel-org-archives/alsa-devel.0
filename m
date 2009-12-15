From: Daniel Mack <daniel@caiaq.de>
Subject: Re: XMOS USB Audio Class 2.0 Reference Design
Date: Tue, 15 Dec 2009 08:00:10 +0800
Message-ID: <20091215000010.GH28375@buzzloop.caiaq.de>
References: <18c89c30912141051t3aafc060sf65ba65bb36a94e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 65B2724426
	for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2009 01:00:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <18c89c30912141051t3aafc060sf65ba65bb36a94e6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shareef Jalloq <shareef@jalloq.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 14, 2009 at 06:51:41PM +0000, Shareef Jalloq wrote:
> I'm starting a product development using the XMOS USB Audio Class 2.0
> Ref Design (http://www.xmos.com/technology/prototype-boards/usbaudio2)
> and I'd like to get some help in understanding what support there is,
> or will be, for Audio Class 2.0 devices within Linux.

This audio 2.0 USB class is currently unsupporteed by the Linux kernel,
someone would need to start implementing the protocol. Fortunately, it
is well documented on usb.org.

There have been people on this list saying they would like to work on
this, but there was no reference implementation available yet, so it
wasn't started.

> I currently have the reference design hardware but am still waiting on
> XMOS to provide the device firmware.=A0 Once I have the source I should
> be able to answer any questions regarding desriptors in more detail.
> Until then I have the previously mentioned Ubuntu system and an OS X
> machine running 10.4.11.=A0 As far as I understand, 10.6.x is the only
> OS that currently supports the Audio Class 2.0 and I'm hoping to have
> access to a machine soon, but not yet.

10.5 will also get suport for it. Which is important as it is the last
OS X that supports PPC machines. All earlier version, though, lack
support for that.

> Dec 10 00:16:00 sjalloq-desktop kernel: [53352.087740] usb 2-1.2.3:
> new high speed USB device using ehci_hcd and address 56
> Dec 10 00:16:00 sjalloq-desktop kernel: [53352.107747] hub 2-1.2:1.0:
> unable to enumerate USB device on port 3
> Dec 10 00:16:04 sjalloq-desktop kernel: [53356.286145] hub 2-1.2:1.0:
> Cannot enable port 3.=A0 Maybe the USB cable is bad?
> Dec 10 00:16:07 sjalloq-desktop kernel: [53359.285099] hub 2-1.2:1.0:
> Cannot enable port 3.=A0 Maybe the USB cable is bad?
> Dec 10 00:16:10 sjalloq-desktop kernel: [53362.284088] hub 2-1.2:1.0:
> Cannot enable port 3.=A0 Maybe the USB cable is bad?
> Dec 10 00:16:13 sjalloq-desktop kernel: [53365.282591] hub 2-1.2:1.0:
> Cannot enable port 3.=A0 Maybe the USB cable is bad?
> Dec 10 00:16:13 sjalloq-desktop kernel: [53365.282884] hub 2-1.2:1.0:
> unable to enumerate USB device on port 3

That points you to a different problem. You should report that to the
XMOS people. As long as the device probing fails at this level, there is
no way the ALSA driver will possibly get control over the device, so
that needs to be fixed first.

> However, on my OS X machine, if I run USB Prober, I get the output
> that follows the end of the email.
> =

> OUTPUT FROM MAC OS X 10.4.11 USB PROBER:

Yep, that does indeed help. You lsusb -v should print something similar,
even though it might not decode the header so well.

I don't know the USB class audio driver too well, so I can't help much
on the question where to start implementing.

HTH,
Daniel
