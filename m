From: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] USB: Gadget: Add Audio Class 2.0 Driver
Date: Thu, 2 Feb 2012 21:49:09 +0530
Message-ID: <CABb+yY3X0XDk0zByZZcJOO0h2Kxu14UD4w-GS7p1HPAAWU3SVA@mail.gmail.com>
References: <1313752934-20081-1-git-send-email-jassisinghbrar@gmail.com>
	<20110822113002.GD30398@legolas.emea.dhcp.ti.com>
	<CAJe_Zhdb7d23_x=1GWV2EnEjdn69XBKEz+hCeCuBx4v9XAmykg@mail.gmail.com>
	<20110822124406.GI30398@legolas.emea.dhcp.ti.com>
	<CABb+yY3QxvHf38-qfD5ig77nJK=0eVLiSPVpbTh_DCfHNGRyGQ@mail.gmail.com>
	<20110822134627.GP30398@legolas.emea.dhcp.ti.com>
	<CABb+yY2m2MfkFwf+XTdKzsCCeSFz_J2LoGxJricamhNtTcSAcg@mail.gmail.com>
	<20110822142805.GT30398@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110822142805.GT30398-UiBtZHVXSwEVvW8u9ZQWYwjfymiNCTlR@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yadi.brar01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jaredwiltshire-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 22, 2011 at 7:58 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
>
>> > audio.c doesn't do anything audio related. It's just adding the
>> > configuration to composite layer. The real specification is implem=
ented
>> > in f_audio.c (should probably be called f_uac1.c, though).
>> Agreed. Reusing audio.c is quite reasonable.
>> So, I'll :-
>> * Merge audio2.c into audio.c
>> * Rename f_audio.c -> f_uac1.c
>> * Add new f_audio2.c as f_uac2.c
>> * Add Kconfig switch to compile UAC_1 (audio.c + f_uac1.c) =C2=A0or =
=C2=A0UAC_2
>> (audio.c + f_uac2.c)
>>
>> I'll wait for other comments and revise the patch after a few days.
>
> ok, sounds reasonable.
>
OK, after a 'few days' on some distant giant planet, here is the revise=
d
patchset accordingly.

Cheers
-jassi
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
