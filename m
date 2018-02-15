From: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
Subject: Re: [PATCH v12 6/8] media: i2c: Add TDA1997x HDMI receiver driver
Date: Thu, 15 Feb 2018 09:43:38 -0800
Message-ID: <CAJ+vNU1ZZnrMJgmOA+XBRjnV0WE8uyc4OSJvdKyZ_eooWGLqRA@mail.gmail.com>
References: <1518712767-21928-1-git-send-email-tharvey@gateworks.com>
 <1518712767-21928-7-git-send-email-tharvey@gateworks.com> <10f08dfb-cc23-a9e3-7439-95955661cb77@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <10f08dfb-cc23-a9e3-7439-95955661cb77-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Cc: linux-media <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Steve Longerbeam <slongerbeam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Hans Verkuil <hansverk-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JsYNTwtnfakRB7SZvlqPiA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 15, 2018 at 9:16 AM, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org> wrote:
> On 15/02/18 17:39, Tim Harvey wrote:
>> Add support for the TDA1997x HDMI receivers.
>>
>> Cc: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
>> Signed-off-by: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>
>> ---
>> v12:
>>  - fix coccinelle warnings
>
> Did you post the right version? I still see the owner being set and the
> other kbuild warning ('note: in expansion of macro 'v4l_dbg'') is also
> still there.
>
> Note that the last one also shows these errors:
>
> drivers/media/i2c/tda1997x.c:387:5-8: WARNING: Unsigned expression compared with zero: val < 0
> drivers/media/i2c/tda1997x.c:391:5-8: WARNING: Unsigned expression compared with zero: val < 0
> drivers/media/i2c/tda1997x.c:404:5-8: WARNING: Unsigned expression compared with zero: val < 0
> drivers/media/i2c/tda1997x.c:408:5-8: WARNING: Unsigned expression compared with zero: val < 0
> drivers/media/i2c/tda1997x.c:412:5-8: WARNING: Unsigned expression compared with zero: val < 0
> drivers/media/i2c/tda1997x.c:427:6-9: WARNING: Unsigned expression compared with zero: val < 0
>
> This is indeed wrong.
>
> Regards,
>
>         Hans

oh geez... no I goofed that up. I'll send a v13 now.

Tim
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
