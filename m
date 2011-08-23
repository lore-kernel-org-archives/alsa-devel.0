From: Daniel Mack <zonque@gmail.com>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Tue, 23 Aug 2011 11:42:05 +0200
Message-ID: <CACTFLAP3F9zhQNa8p5769MCAouweUL01P39fB6gmfJodxhyMBA@mail.gmail.com>
References: <4E5234F0.8000502@amlie.name>
	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>
	<4E52401C.8030605@amlie.name> <4E537524.9010303@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AC77103903
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 11:42:06 +0200 (CEST)
Received: by pzk1 with SMTP id 1so10854234pzk.2
	for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2011 02:42:05 -0700 (PDT)
In-Reply-To: <4E537524.9010303@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 23, 2011 at 11:38 AM, Clemens Ladisch <clemens@ladisch.de> wrot=
e:
> Kristian Amlie wrote:
>> =A0 idVendor =A0 =A0 =A0 =A0 =A0 0x0403 Future Technology Devices Intern=
ational, Ltd
>> =A0 idProduct =A0 =A0 =A0 =A0 =A00xb8d8
>
> There is a kernel driver for this chipset; try
> "modprobe ftdi_sio product=3D0xb8d8". =A0This will give you a serial port
> which you can try to configure for the correct baud rate and see whether
> MIDI bytes come out. =A0(There is currently no mechanism to make a MIDI
> device from such a serial port; this would require extending or creating
> a driver.)

Yes, an easy one, which just hard-codes the device to 31250,8N1. I'm
not sure whether the USB serial driver can handle this baud rate, btw.
I had quick look earlier and it seems that it would require a divider
setup that is not currently supported. Hence I though just sniffing
the setup is probably the easiest way to go.


Daniel
