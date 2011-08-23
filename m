From: Daniel Mack <zonque@gmail.com>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Tue, 23 Aug 2011 12:16:53 +0200
Message-ID: <CACTFLAPzug5yxmhxDKocdLt-eoHXr6nOwmyOqWkEJ_vjqNff6w@mail.gmail.com>
References: <4E5234F0.8000502@amlie.name>
	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>
	<4E52401C.8030605@amlie.name> <4E537524.9010303@ladisch.de>
	<4E537BE9.4050004@amlie.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f43.google.com (mail-pz0-f43.google.com
	[209.85.210.43]) by alsa0.perex.cz (Postfix) with ESMTP id 45E8D2462F
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 12:16:54 +0200 (CEST)
Received: by pzk1 with SMTP id 1so10896930pzk.2
	for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2011 03:16:53 -0700 (PDT)
In-Reply-To: <4E537BE9.4050004@amlie.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kristian Amlie <kristian@amlie.name>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 23, 2011 at 12:07 PM, Kristian Amlie <kristian@amlie.name> wrot=
e:
> On 08/23/11 11:38, Clemens Ladisch wrote:
>> Kristian Amlie wrote:
>>> =A0 idVendor =A0 =A0 =A0 =A0 =A0 0x0403 Future Technology Devices Inter=
national, Ltd
>>> =A0 idProduct =A0 =A0 =A0 =A0 =A00xb8d8
>>
>> There is a kernel driver for this chipset; try
>> "modprobe ftdi_sio product=3D0xb8d8". =A0This will give you a serial port
>> which you can try to configure for the correct baud rate and see whether
>> MIDI bytes come out. =A0(There is currently no mechanism to make a MIDI
>> device from such a serial port; this would require extending or creating
>> a driver.)
>
> Forgive me, I'm not very well acquainted with how serial drivers work in
> Linux. The driver did give me a new device, so here is what I tried:
>
> $ setserial /dev/ttyUSB0 spd_normal uart 16550A
> $ cat /dev/ttyUSB0 > dump
>
> I was not able to get any output from the serial device, however, while
> cat was running and I was pressing buttons on the instrument, it
> spontaneously changed program on me (MIDI program change), so
> *something* goes across the wire.

Try "cu" (provided in the package "uucp" on some distributions), and
see if you can make the hardware operate on 31250 Baud, which is the
nominal rate for MIDI. If you can, you should be able to receive a raw
MIDI byte stream. But as I say, I think that requires a special
divider setup that is not supported by the ftdi_sio driver.


Daniel
