From: Joao Bonina <bonina_2001-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] Alsa: USB Class 2 Audio soundcard device disappears suddenly
Date: Tue, 31 Jul 2012 05:04:56 -0700 (PDT)
Message-ID: <1343736296.42529.YahooMailNeo@web121606.mail.ne1.yahoo.com>
References: <1343687555.25545.YahooMailNeo@web121601.mail.ne1.yahoo.com> <50176C21.4080203@gmail.com> <1343729241.63273.YahooMailNeo@web121603.mail.ne1.yahoo.com> <1343729559.92141.YahooMailNeo@web121604.mail.ne1.yahoo.com> <5017C3AC.4050302@gmail.com>
Reply-To: Joao Bonina <bonina_2001-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5017C3AC.4050302-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

You're right about the EMI message, it's happening when the streaming s=
tops.

I've tried different cables before, but that didn't solve the problem.

The motherboard is an Alix 1D, and I'm using the onboard USB 2.0 ports.

If this really is an EMI issue, guess I'll have to source some kind of =
miniPCI-USB 2.0 card and see if that solves the problem.




----- Original Message -----
=46rom: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Joao Bonina <bonina_2001-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>; linux-=
usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sent: Tuesday, 31 July 2012, 12:38
Subject: Re: [alsa-devel] Alsa: USB Class 2 Audio soundcard device disa=
ppears suddenly

On 31.07.2012 12:12, Joao Bonina wrote:
>=20
>=20
> It doesn't show anything when that happens.

Well, it shows:

[=A0 349.789200] hub 1-0:1.0: port 4 disabled by hub (EMI?), re-enablin=
g...

I guess this about the time when the streaming stops? How does your USB
wiring setup look like and what kind of system is that? Smells like a
hardware issue, to be honest. You could do some stress-testing by
transferring huge amounts of data from one USB storage media to another=
=2E
Also try replacing the cables maybe.

I'm Cc'ing the linux-usb list, maybe someone there has an idea.


Daniel


>=20
> Looking at dmesg (I'm attaching it), it shows this:
> [=A0 350.170478] usb 1-4: config 1 has an invalid interface number: 3=
 but max is 2
> [=A0 350.170500] usb 1-4: config 1 has no interface number 2
> [=A0 350.170843] usb 1-4: config 1 has an invalid interface number: 3=
 but max is 2
> [=A0 350.170864] usb 1-4: config 1 has no interface number 2
> [=A0 350.171344] usb 1-4: New USB device found, idVendor=3D21b4, idPr=
oduct=3D0230
>=20
> [=A0 350.171366] usb 1-4: New USB device strings: Mfr=3D1, Product=3D=
2, SerialNumber=3D3
> [=A0 350.171385] usb 1-4: Product: Ayre USB Interface
> [=A0 350.171401] usb 1-4: Manufacturer: Ayre Acoustics
> [=A0 350.171418] usb 1-4: SerialNumber: (C) 2010 XMOS/Wavelength Audi=
o
>=20
>=20
> Don't know if those 'invalid interface number' messages are relevant =
for the issue.
>=20
> Joao
>=20
>=20
> ----- Original Message -----
> From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> To: Joao Bonina <bonina_2001-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
> Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
> Sent: Tuesday, 31 July 2012, 6:24
> Subject: Re: [alsa-devel] Alsa: USB Class 2 Audio soundcard device di=
sappears suddenly
>=20
> On 31.07.2012 00:32, Joao Bonina wrote:
>> Hi,
>>
>> I'm using an USB Class 2 Audio DAC (basically a soundcard) with my L=
inux box and MPD software.
>>
>> It works great when playing files stored in a remote share, but when=
=20
>> playing files from an USB pen, it stops playing in a few minutes.
>>
>> Mpd.log shows this:
>>
>> Code:
>> Jul 30 13:03 : output: "USB" [alsa] failed to play: No such device
>> Jul 30 13:03 : output: closed plugin=3Dalsa name=3D"USB"
>> ALSA lib pcm_hw.c:1401:(_snd_pcm_hw_open) Invalid value for card
>> Jul 30 13:03 : output: Failed to open "USB" [alsa]: Failed to open A=
LSA device "hw:0,0": No such file or directoryIt seems to be somewhat r=
elated to the USB bus not being able to=20
>> cope with both PCM streaming to the soundcard and reading from the f=
lash pen simultaneously, I guess.
>>
>> So, anybody faced this issue previously and can provide some hints t=
o solve this?
>>
>> MPD is 0.17, kernel is 3.2.17, alsa-utils is 1.0.25.
>=20
> Does the kernel log or 'dmesg' show anything weird what that happens?
>=20
>=20
> Daniel
>=20


_______________________________________________
Alsa-devel mailing list
Alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
