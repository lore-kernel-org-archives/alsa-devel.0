From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Jaume?= <frederic.jaume@gmail.com>
Subject: Re: Alsa Support for Korg Pandora Mini, Vox ToneLab ST
Date: Mon, 16 May 2011 20:39:27 +0200
Message-ID: <BANLkTimnP47ym6SJSwuqx6C2Y=_N4ntqvg@mail.gmail.com>
References: <BANLkTikGDzzhXQLTpsHvqqJ=b30JgkumJQ@mail.gmail.com>
	<BANLkTinXgstKju=8-Ow7o542-zZxvKZdTQ@mail.gmail.com>
	<loom.20110514T184918-282@post.gmane.org>
	<BANLkTi=uT5xEJ1xtOqXFqPAH6ghRcJhEhg@mail.gmail.com>
	<BANLkTimWe6OJjRLjNFKKSKyPuSjuZcBLgQ@mail.gmail.com>
	<BANLkTin7JRp6wZeX049Atqn+zmZdkQ1vGQ@mail.gmail.com>
	<BANLkTikUS1qcLa_OdCkW68cwFLRB7qqFbg@mail.gmail.com>
	<BANLkTinUrXN6KiYLOT=F=jdPmn=2t5F5OQ@mail.gmail.com>
	<BANLkTikjU3KiL9HJJSwjHQ8qO-eLG3HWzQ@mail.gmail.com>
	<BANLkTimUPRYXcpY9fhcyOACJG+NaurOZxA@mail.gmail.com>
	<BANLkTimY9ux5+LS4dv04XpQxbwArHWrsuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AE69C24572
	for <alsa-devel@alsa-project.org>;
	Mon, 16 May 2011 20:39:28 +0200 (CEST)
Received: by eyg5 with SMTP id 5so1422879eyg.38
	for <alsa-devel@alsa-project.org>; Mon, 16 May 2011 11:39:27 -0700 (PDT)
In-Reply-To: <BANLkTimY9ux5+LS4dv04XpQxbwArHWrsuA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Grant Diffey <gdiffey@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

Hi everyone!

Daniel, I successfully applied the patch for the Korg Pandora PX5D
(USB_DEVICE_VENDOR_SPEC), and got both working USB Audio and USB Midi from
the Pandora! Got audio from the Pandora and was able to send midi notes to
it and get sound back. It's a winner!

Fred.

2011/5/16 Daniel Mack <zonque@gmail.com>

> On Mon, May 16, 2011 at 5:20 PM, Grant Diffey <gdiffey@gmail.com> wrote:
> > A winner.
> >
> > [  115.420064] usb 4-1: new high speed USB device using ehci_hcd and
> address
> > 3
> > [  115.553783] usb 4-1: config 1 interface 3 altsetting 0 bulk endpoint
> 0x7
> > has invalid maxpacket 8
> > [  115.553789] usb 4-1: config 1 interface 3 altsetting 0 bulk endpoint
> 0x87
> > has invalid maxpacket 8
> > [  115.554896] usb 4-1: New USB device found, idVendor=3D0763,
> idProduct=3D2080
> > [  115.554898] usb 4-1: New USB device strings: Mfr=3D1, Product=3D2,
> > SerialNumber=3D0
> > [  115.554901] usb 4-1: Product: Fast Track Ultra
> > [  115.554903] usb 4-1: Manufacturer: M-Audio
> > nevyn@cetacea:~/linux$ amidi -l
> > Dir Device    Name
> > IO  hw:1,0,0  Fast Track Ultra MIDI 1
> >
> > Huzzah! Please commit. your 8 character diff ;) oh. and you probably
> should
> > change the 8R at the same time given it's essentially the same hardware
> with
> > different analog bits. (8 pre's instead of 4)
>
> Nice, thank for testing :)
>
> Takashi, I'm currently collecting some patches and will send them in
> one go soonish.
>
> And Fr=E9d=E9ric, if you could report that the Pandora works with the
> patch I sent this morning, it will also be part of this series.
>
>
> Daniel
>
