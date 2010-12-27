From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: sound: usb-audio: full capture/playback/spdif
 support for Digidesign Mbox 2
Date: Tue, 28 Dec 2010 01:50:14 +1100
Message-ID: <AANLkTimH8OfncsS_WPtXGgFN316YeJQMtEEfkxXmEuQ8@mail.gmail.com>
References: <AANLkTi=cSDq5SEh321Zy2n2RMHWFnW2-hd-=k9mz+eEz@mail.gmail.com>
	<4CEED787.9050504@gmail.com>
	<AANLkTimjaYMaqA3fFqWKi0+8nsaqENe8oWj=hph1Hv09@mail.gmail.com>
	<s5hfwukp4k4.wl%tiwai@suse.de>
	<AANLkTi=3JSsaa=P5s31+fq75Jp0WQUKD7mu0Ft8Tq+bP@mail.gmail.com>
	<4CF517BF.4020706@ladisch.de>
	<AANLkTi=Y6tA=1CW6Yu0rpAm7=JyLLjA1A-4cL-JFaBrP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B51821037F5
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2010 15:50:15 +0100 (CET)
Received: by qwj8 with SMTP id 8so8447885qwj.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2010 06:50:14 -0800 (PST)
In-Reply-To: <AANLkTi=Y6tA=1CW6Yu0rpAm7=JyLLjA1A-4cL-JFaBrP@mail.gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

> On Wed, Dec 1, 2010 at 2:26 AM, Clemens Ladisch <clemens@ladisch.de> wrot=
e:
>> Damien Zammit wrote:
>>> Unfortunately I am sending this email from gmail, so I'm not sure
>>> about line formatting, yikes.
>>
>> Long lines are wrapped.

Not much i can do about that, i dont have a plain text email client.

>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* We have to make sure that the USB core l=
ooks
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* again at interface 6 by calling usb_set_=
interface() on it.
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 =A0 =A0 =A0 usb_set_interface(umidi->dev, 6, 0);
>>
>> Why? =A0Is this another duplicate endpoint number?

The windows driver did this, and it doesn't work unless this code is here.

>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 memcpy(&endpoints[0], quirk->data,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(struct snd_usb_midi_en=
dpoint_info));
>>
>> I think you should be able to call snd_usbmidi_detect_per_port_endpoints
>> here.

Can you explain this a bit further, i'm not sure what this means.


>>
>>> +/* DIGIDESIGN MBOX 2 */
>>> +{
>>> + =A0 =A0 =A0 /* Damien Zammit <damien.zammit@gmail.com> */
>>
>> This usually goes into the commit log.

I removed this from my patch

>>
>>> + =A0 =A0 =A0 USB_DEVICE(0x0dba, 0x3000),
>>
>> The entries are supposed to be ordered by their IDs.
>>

I put this in order

>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * but now we will try=
 sending
>>> capture/playback enable magic
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * 80 bb 00 =3D 24bit =
mode - S24_3BE
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * 44 ac 00 =3D 16bit =
mode?
>>
>> Why the question mark?

These are actually old comments which are irrelevant, i have removed this.

>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0//enablemagic[0]=3D0x4=
4;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0//enablemagic[1]=3D0xa=
c;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0//enablemagic[2]=3D0x0=
0;
>>
>> Why is this commented out?
>>

Again, i was testing different sample rates, this is unnecessary and
has been removed.

>>> +#define MBOX2_SET_48K_SPDIF =A0 =A0 =A0 =A0 =A0 =A00
>>> +#define MBOX2_SET_44K_SPDIF =A0 =A0 =A0 =A0 =A0 =A01
>>> +#define MBOX2_SET_48K_ANALOG =A0 =A0 =A0 =A0 =A0 2
>>> +#define MBOX2_SET_44K_ANALOG =A0 =A0 =A0 =A0 =A0 3
>>
>> In theory, this should be some control instead of a module parameter.

I have removed support for spdif mode because the rest of the driver
doesnt support sending the full spdif frames anyway.

>>
>>> +static int mbox2_skip_setting_quirk(struct snd_usb_audio *chip,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0int iface, int altno)
>>
>> This function isn't consistently indented with tabs.
>>

I fixed the tab indentation


Clemens wrote last year:
>> +mbox2_reboot:
>> +                snd_usb_ctl_msg(dev, usb_rcvctrlpipe(dev, 0),
>> +                        0x85, 0xc0, 0x0001, 0x0000, &bootresponse, 0x00=
12, 1000);
>> +
>> +                if (bootresponse =3D=3D MBOX2_BOOT_LOADING) {
>> +                        snd_printdd("device not ready, resending boot s=
equence...\n");
>> +                        goto mbox2_reboot;
>> +                }

>This could be made a loop.  And it could run infinitely long; maybe you
>should add a timeout.  (How long does it usually need?)

Can you help me write a loop with a timeout that is RT safe? I don't
know how to "sleep" for say 300ms in a safe way for all kernel
versions.  The device responds before 5 seconds from zero power to
bootup.

I am eager to get support into the kernel for this device because it
is very popular among audio enthusiasts.
SPDIF isnt all that important i think, but I made duplex mode work a
few weeks ago and could just enable that by default without the
device_setup parameter if that is preferred by the kernel developers.

Damien
