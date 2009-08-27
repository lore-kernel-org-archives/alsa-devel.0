From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: [PATCH 1/1] sound: usb-audio: support for
	Digidesign Mbox 2
Date: Thu, 27 Aug 2009 11:22:33 +1000
Message-ID: <98ec50f0908261822m3d5bb75aw347c858efef7c8cc@mail.gmail.com>
References: <4A8EBB35.2010604@gmail.com> <4A92B95E.9090905@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f220.google.com (mail-ew0-f220.google.com
	[209.85.219.220])
	by alsa0.perex.cz (Postfix) with ESMTP id BEBE2243CB
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Aug 2009 03:22:34 +0200 (CEST)
Received: by ewy20 with SMTP id 20so787267ewy.46
	for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2009 18:22:34 -0700 (PDT)
In-Reply-To: <4A92B95E.9090905@ladisch.de>
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

On Tue, Aug 25, 2009 at 2:01 AM, Clemens Ladisch<clemens@ladisch.de> wrote:
> Damien Zammit wrote:
>> S/PDIF mode works by setting the required flag
>> in usbaudio.c. I think the device can't do both simultaneously,
>> since different altsettings are required to set it.
>
> Does the Windows driver allow it?

In windows, you can map output ports 1-2 as analogue and 3-4 as spdif
but I don't know if they both work simultaneously, I am having trouble
using the windows software...


>> =A0 =A0 =A0 =A0 =A0 =A0 =A0Remaining issues:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01) Double check endianess of 24 bit c=
apture.
>
> This should be apparent even in low-amplitude noise.
> Do you have a hex dump of recorded data?

First 2 samples of audio recorded with jackrec (hexdumped from wav file):
0D 00 00    EE FF FF

Seems to be little endian, which is consistent with the wav
standard... which implies the driver's capture endianess is correct.
(S24_3BE)


>> +mbox2_reboot:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_usb_ctl_msg(dev, usb_rcvctrlpipe(de=
v, 0),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x85, 0xc0, 0x0001, 0x0=
000, &bootresponse, 0x0012, 1000);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (bootresponse =3D=3D MBOX2_BOOT_LOAD=
ING) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_printdd("device not=
 ready, resending boot sequence...\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto mbox2_reboot;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> This could be made a loop. =A0And it could run infinitely long; maybe you
> should add a timeout. =A0(How long does it usually need?)

It takes about 3 seconds from the instant you modprobe the driver to
the lights coming on.
I don't know the correct way to code a timeout. I assume it involves
checking the clock at the start, and then checking it at regular
intervals to see if the time has elapsed.
I think a 6 second timeout would be appropriate.


>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D usb_get_descrip=
tor(dev, USB_DT_DEVICE, 0,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&dev->d=
escriptor, sizeof(dev->descriptor));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0config =3D dev->actconf=
ig;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err < 0) snd_printd=
d("error usb_get_descriptor: %d\n", err);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D usb_reset_confi=
guration(dev);
>
> Does this device change its descriptors without a reset?
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * 80 bb 00 =3D 24bit m=
ode - S24_3BE
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * 44 ac 00 =3D 16bit m=
ode?
>
> 0xbb80 =3D 48000
> 0xac44 =3D 44100
>
> Do the descriptors change if you change the sample rate? =A0Or does using
> 44.1 kHz result in another altsetting?

The altsettings are the same for 44.1 and 48, and the windows driver
re-reads the descriptors quite often, and resets all altsettings on
ifaces 2-5 to 0 before setting the required altsettings, so I assume
they change.  Does that mean we need to re-read the descriptors too
after every mode change?

I captured the setup packets & data required for setting the device
into 16/24 bit modes and 44.1/48kHz, but I'm not sure where to code
them in the driver so that ALSA can set the modes automatically, I
don't think it follows standard usb audio devices.


>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_printdd("unknown bootresponse, igno=
ring device: %d\n",bootresponse);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>> + =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0snd_printdd("Invalid firmware size: %d\n",fwsize);
>> + =A0 =A0 =A0 =A0return -ENODEV;
>
> snd_printdd is for debugging output, but a failure due to a new firmware
> revision should be indicated in any case.

Which "printf" function should i be using for this?  I am a kernel newbie.


>> +#ifdef MBOX2_SPDIF_IO
>
> This should be done at runtime. =A0This would need logic to prevent using
> analog/digital at the same time(?), and it might be necessary to
> hardcode interfaces and if numbers in find_format().

In windows, the I/O settings allow you to set SPDIF as a clock source
at runtime, but when I captured this over usbsnoop, there were no
setuppackets relating to this.  (I know this because I worked out what
all the other setup packets do.)
Using SPDIF as a clock source, does that mean it uses spdif RCA jacks
as input/output? Or just using the digital input as a clock whilst
feeding the signals through the analogue jacks?
I don't have an external device with spdif to test...

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * We have to make sure that the USB co=
re looks
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * again at interface 6
>
> Why?

Not sure, I just copied that code from another device... It seems to
work when I comment it out, so I'll get rid of it.

Regards,
Damien
