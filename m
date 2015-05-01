From: Belisko Marek <marek.belisko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] ASoC: Add gtm601 codec driver
Date: Fri, 1 May 2015 13:39:39 +0200
Message-ID: <CAAfyv368_X6t7OqtP6CKttU1PKx2Su_xptUNqYZ2j2-2PmG5DA@mail.gmail.com>
References: <1430429283-27907-1-git-send-email-marek@goldelico.com>
	<1430429283-27907-2-git-send-email-marek@goldelico.com>
	<1430465409.2187.47.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430465409.2187.47.camel@x220>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org>
Cc: perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Dr. H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Paul,

On Fri, May 1, 2015 at 9:30 AM, Paul Bolle <pebolle-IWqWACnzNjzz+pZb47iToQ@public.gmane.org> wrote:
> Just a nit: a license mismatch.
Right, I copy and paste license header from wm827 driver but add
MODULE_LICENSE wrong version. I'll update in next version. Thanks.
>
> On Thu, 2015-04-30 at 23:28 +0200, Marek Belisko wrote:
>> --- /dev/null
>> +++ b/sound/soc/codecs/gtm601.c
>
>> + *  This program is free software; you can redistribute  it and/or modify it
>> + *  under  the terms of  the GNU General  Public License as published by the
>> + *  Free Software Foundation;  either version 2 of the  License, or (at your
>> + *  option) any later version.
>
> This states the license is GPL v2 or later.
>
>> +MODULE_LICENSE("GPL v2");
>
> And, according to include/linux/module.h, this states the license is
> (just) GPL v2. So I think either the comment at the top of this file or
> the ident used in the MODULE_LICESE() macro should change.
>
>
> Paul Bolle
>

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
