From: Kevin Cernekee <cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH V3 1/4] regmap: Use regcache_mark_dirty() to indicate
 power loss or reset
Date: Mon, 4 May 2015 07:05:38 -0700
Message-ID: <CAJzqFta5nHr+KiWfAVgV_iaycpLZ3h2MUYfSSqZ1Z72UP0hOcA@mail.gmail.com>
References: <1430697619-22773-1-git-send-email-cernekee@chromium.org>
 <1430697619-22773-2-git-send-email-cernekee@chromium.org> <554713DD.4020006@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <554713DD.4020006-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olofj-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Sun, May 3, 2015 at 11:38 PM, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:
>> diff --git a/drivers/base/regmap/regcache.c
>> b/drivers/base/regmap/regcache.c
>> index 7eb7b3b98794..63af3103d0c6 100644
>> --- a/drivers/base/regmap/regcache.c
>> +++ b/drivers/base/regmap/regcache.c
>> @@ -253,6 +253,9 @@ static int regcache_default_sync(struct regmap *map,
>> unsigned int min,
>>                                  unsigned int max)
>>   {
>>         unsigned int reg;
>> +       bool no_sync_defaults = map->no_sync_defaults;
>> +
>> +       map->no_sync_defaults = false;
>
>
> This needs to be done at the end in regcache_sync(), the same place where
> dirty is set to false.

But map->cache_dirty means "any register is dirty," not "all registers
are dirty."  So it can only be cleared after a successful flush.

If one of the writes fails and regcache_sync() has to return
prematurely, we probably don't want no_sync_defaults to stay true
because some of the HW registers might not match map->reg_defaults
anymore.

Leaving it set to true wouldn't break the current regcache_sync()
implementation, but no_sync_defaults is documented as: "if set, the HW
registers are known to match map->reg_defaults".  Writing any register
to a non-default value makes it false.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
