From: Lori Hikichi <lhikichi-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: add core audio driver for Broadcom Cygnus SOC.
Date: Thu, 9 Apr 2015 19:06:22 -0700
Message-ID: <5527301E.6070906@broadcom.com>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com> <1427771784-29950-3-git-send-email-sbranden@broadcom.com> <20150331064209.GD2869@sirena.org.uk> <551D8EB6.1050004@broadcom.com> <20150406161939.GJ6023@sirena.org.uk> <552492E1.3050207@broadcom.com> <20150408192309.GI6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150408192309.GI6023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Anatol Pomazao <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, abrestic-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, bryeung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, olofj-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, pwestin-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org



On 15-04-08 12:23 PM, Mark Brown wrote:
> On Tue, Apr 07, 2015 at 07:30:57PM -0700, Lori Hikichi wrote:
>> On 15-04-06 09:19 AM, Mark Brown wrote:
>=20
>>> OK, so that seems fragile - what happens if we're slightly late
>>> processing an interrupt or miss one entirely?  Most hardware has so=
me
>>> way to read back the current position which tends to be more reliab=
le,
>>> is that not an option here?
>=20
>> The hardware updates a read pointer (rdaddr) which we feed to ALSA v=
ia the
>> ".pointer" hook. So yes, the hardware does have a register that tell=
s us its
>> progress.  This routine (ringbuf_inc) actually updates a write point=
er
>> (wraddr) which is a misnomer.  The write pointer doesn=E2=80=99t act=
ually tell us
>> where we are writing to =E2=80=93 ALSA keeps track of that. The wrad=
dr only prevents
>> the hardware from reading past it.  We just use it, along with a low=
 water
>> mark configuration register, to keep the periodic interrupts firing.=
  The
>> hardware is tracking the distance between rdaddr and wraddr and comp=
aring
>> that to the low water mark.
>=20
> The code has handling for both read and write so it's not just updati=
ng
> a write pointer.  Is there no flexibility in the hardware regarding
> interrupt generation?
>=20
>> Being late processing the interrupt is okay since there are more sam=
ples to
>> read.  That is, it was only a low water mark interrupt and we have o=
ne
>> period of valid data still (we configure low water to be one period)=
=2E
>> Missing an interrupt is okay since the hardware will just stop readi=
ng from
>> buffer when rdaddr has hit wraddr.
>=20
> Stopping if we miss an interrupt is precisely the sort of situation w=
e
> want to avoid if we can - if the application is sufficiently far ahea=
d
> of the hardware everything should continue to work fine.  The minimal
> period size appears to be very small so this is a potential issue, if=
 an
> application tries to use many very small periods it's both more
> vulnerable to some other interrupt taking longer than might be desira=
ble
> and likely that things would be fine as the application is hopefully
> more than one period ahead of where the hardware is at.
>=20
> If the hardware is always going to halt at the end of the period ther=
e's
> not a huge amount we can do about this except possibly raise the mini=
mum
> period if systems are running into trouble but if there's a way to av=
oid
> doing that then that would be even better.
>=20
Makes sense, thanks for clarifying the desired behaviour, I will make t=
he=20
necessary adjustments to keep the hardware supplied with valid data eve=
n if=20
interrupts are held off past a whole period.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
