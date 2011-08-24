From: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] USB: Gadget: Add Audio Class 2.0 Driver
Date: Wed, 24 Aug 2011 09:52:52 +0530
Message-ID: <CABb+yY0pX=1Ye7dqcrocq4vHThPV35xAs=XmFsopJ22hPEUH=Q@mail.gmail.com>
References: <1313752934-20081-1-git-send-email-jassisinghbrar@gmail.com>
	<35AB98346D25394A9354ED89C4D7658717FD0C@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <35AB98346D25394A9354ED89C4D7658717FD0C-TcFNo7jSaXOLgTCmFNXF2K4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chen Peter-B29397 <B29397-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, "gregkh-l3A5Bk7waGM@public.gmane.org" <gregkh-l3A5Bk7waGM@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "yadi.brar01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <yadi.brar01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 24, 2011 at 7:30 AM, Chen Peter-B29397 <B29397-KZfg59tc24x4beGV+Eop3g@public.gmane.org=
m> wrote:
>>
>> This is a flexible USB Audio Class 2.0 compliant gadget driver that
>> implements a simple topology with a virtual sound card exposed at
>> the function side.
>>
>> The driver doesn't expect any real audio codec to be present on the
>> function - the audio streams are simply sinked to and sourced from a
>> virtual ALSA sound card created. The user-space application may choo=
se
>> to do whatever it wants with the data received from the USB Host and
>> choose to provide whatever it wants as audio data to the USB Host.
>>
>> Capture(USB-Out) and Playback(USB-In) can be run at independent
>> configurations specified via module parameters while loading the dri=
ver.
>>
>
> Have you a chance to test at Macbook (10.6.5+) which has USB Audio 2.=
0 support well?
>
Nopes, haven't had my hands on one yet.
It would help if someone could verify.

=2E....

>> +/* STD AS ISO OUT Endpoint */
>> +struct usb_endpoint_descriptor fs_epout_desc =3D {
>> + =C2=A0 =C2=A0 .bLength =3D USB_DT_ENDPOINT_SIZE,
>> + =C2=A0 =C2=A0 .bDescriptorType =3D USB_DT_ENDPOINT,
>> +
>> + =C2=A0 =C2=A0 .bEndpointAddress =3D USB_DIR_OUT,
>> + =C2=A0 =C2=A0 .bmAttributes =3D USB_ENDPOINT_XFER_ISOC | USB_ENDPO=
INT_SYNC_ASYNC,
>> + =C2=A0 =C2=A0 .bInterval =3D 1,
>> +};
>> +
>> +struct usb_endpoint_descriptor hs_epout_desc =3D {
>> + =C2=A0 =C2=A0 .bLength =3D USB_DT_ENDPOINT_SIZE,
>> + =C2=A0 =C2=A0 .bDescriptorType =3D USB_DT_ENDPOINT,
>> +
>> + =C2=A0 =C2=A0 .bmAttributes =3D USB_ENDPOINT_XFER_ISOC | USB_ENDPO=
INT_SYNC_ASYNC,
>> + =C2=A0 =C2=A0 .bInterval =3D 4,
>> +};
> The sync type is asynchronous, do you have plan to add feedback for h=
andling
> overflow and underflow?
>
umm... I was not sure if the feature is worth the overhead/complexity
of maintaining timers in the driver. Though I welcome hearing why not
so?
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
