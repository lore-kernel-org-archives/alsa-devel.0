From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH V3 1/4] regmap: Use regcache_mark_dirty() to indicate
 power loss or reset
Date: Mon, 04 May 2015 19:33:01 +0200
Message-ID: <5547AD4D.4000007@metafoo.de>
References: <1430697619-22773-1-git-send-email-cernekee@chromium.org> <1430697619-22773-2-git-send-email-cernekee@chromium.org> <554713DD.4020006@metafoo.de> <CAJzqFta5nHr+KiWfAVgV_iaycpLZ3h2MUYfSSqZ1Z72UP0hOcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJzqFta5nHr+KiWfAVgV_iaycpLZ3h2MUYfSSqZ1Z72UP0hOcA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Cernekee <cernekee@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, dgreid@chromium.org, Andrew Bresticker <abrestic@chromium.org>, Olof Johansson <olofj@chromium.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 05/04/2015 04:05 PM, Kevin Cernekee wrote:
> On Sun, May 3, 2015 at 11:38 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>> diff --git a/drivers/base/regmap/regcache.c
>>> b/drivers/base/regmap/regcache.c
>>> index 7eb7b3b98794..63af3103d0c6 100644
>>> --- a/drivers/base/regmap/regcache.c
>>> +++ b/drivers/base/regmap/regcache.c
>>> @@ -253,6 +253,9 @@ static int regcache_default_sync(struct regmap *map,
>>> unsigned int min,
>>>                                   unsigned int max)
>>>    {
>>>          unsigned int reg;
>>> +       bool no_sync_defaults = map->no_sync_defaults;
>>> +
>>> +       map->no_sync_defaults = false;
>>
>>
>> This needs to be done at the end in regcache_sync(), the same place where
>> dirty is set to false.
>
> But map->cache_dirty means "any register is dirty," not "all registers
> are dirty."  So it can only be cleared after a successful flush.
>
> If one of the writes fails and regcache_sync() has to return
> prematurely, we probably don't want no_sync_defaults to stay true
> because some of the HW registers might not match map->reg_defaults
> anymore.

Makes sense. But it should still be done in a central place rather than 
repeating it in every sync implementation. You can still put it at the end 
of regcache_sync(), just clear it regardless of whether it succeeded or not.
