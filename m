From: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] ASoC: wm8985: add device-tree support
Date: Tue, 24 May 2016 10:00:52 +0200
Message-ID: <CAEP=dzDm3a+NZoxD-qi_U5q=HxUvv8LDK5KJDXqgj_jMqCpn-w@mail.gmail.com>
References: <1463489389-17719-1-git-send-email-petr@barix.com>
 <1463489389-17719-2-git-send-email-petr@barix.com> <20160520162128.GS1646@localhost.localdomain>
 <CAEP=dzB2527G27ym5pP2C1AxMKKeU7HMiYZ8_=48VBZdv6jxbw@mail.gmail.com> <20160523083140.GB20422@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160523083140.GB20422-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, ALSA Development Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Plamen Prodanov <plamen-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 23 May 2016 at 10:31, Charles Keepax
<ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> On Mon, May 23, 2016 at 09:23:05AM +0200, Petr Kulhavy wrote:
>> On 20 May 2016 at 18:21, Charles Keepax
>> <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
>> > On Tue, May 17, 2016 at 02:49:49PM +0200, Petr Kulhavy wrote:
>> >> +static enum wm8985_type wm8985_data = WM8985;
>> >> +static enum wm8985_type wm8758_data = WM8758;
>> >> +
>> >> +static const struct of_device_id wm8985_of_match[] = {
>> >> +     { .compatible = "wlf,wm8985", .data = &wm8985_data},
>> >> +     { .compatible = "wlf,wm8758", .data = &wm8758_data},
>> >
>> > You can probably just use (void *)WM8985 instead here.
>>
>> I know this pretty safe with integers but can you do this with enums?
>> Doesn't it lead to undefined behaviour?
>
> Hmm... its not uncommon that it is done in the kernel, but
> that is rarely an indicator of if something is actually
> technically valid or not. Casting from an integer to a pointer
> is technically implementation defined, but we clearly rely on
> gcc's implementation in the kernel. However, without actually
> reading the spec in more detail I am unclear on if an enum counts
> as an integer here, my suspicion is that it would since it
> generally always implicitly casts to an int.
>
> I guess the correct fix is that .data should probably be a
> kernel_ulong_t in of_device_id. But if no one else objects I am
> happy for you to leave your current code as is.

If I understand this Stack Overflow answer right:
http://stackoverflow.com/a/2331327
The enum should be casted to an integer of size <= size of a pointer
for the architecture.
So this should be more or less ok?
.data = (void*)(int)WM8985

Thanks
Petr
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
