From: Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [RFC PATCH 1/2] regmap: add configurable lock
	class key for lockdep
Date: Fri, 26 Jun 2015 10:34:58 +0800
Message-ID: <CANMq1KA_0m0phpg3JjXagRdzZX7Ar8ZCmUVHhZUyP4OirV7krw@mail.gmail.com>
References: <1435224904-35517-1-git-send-email-drinkcat@chromium.org>
 <558C2577.2040404@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com
 [209.85.218.52])
 by alsa0.perex.cz (Postfix) with ESMTP id A40472606E9
 for <alsa-devel@alsa-project.org>; Fri, 26 Jun 2015 04:34:59 +0200 (CEST)
Received: by oiax193 with SMTP id x193so66237501oia.2
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2015 19:34:58 -0700 (PDT)
In-Reply-To: <558C2577.2040404@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Antti Palosaari <crope@iki.fi>, Bard Liao <bardliao@realtek.com>, Arjan van de Ven <arjan@linux.intel.com>, Ingo Molnar <mingo@redhat.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 25, 2015 at 11:59 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> [...]
>>
>> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
>> index 116655d..09aaaf5 100644
>> --- a/include/linux/regmap.h
>> +++ b/include/linux/regmap.h
>> @@ -135,6 +135,12 @@ typedef void (*regmap_unlock)(void *);
>>    * @lock_arg:   this field is passed as the only argument of lock/unlock
>>    *              functions (ignored in case regular lock/unlock functions
>>    *              are not overridden).
>> + * @lock_class_key: Custom lock class key for lockdep validator. Use that
>> to
>> + *                  silence false lockdep nested locking warning, when
>> this
>> + *                  regmap needs to access another regmap during
>> read/write
>> + *                  operations (directly in read/write functions, or
>> + *                  indirectly, e.g. through bus accesses).
>
>
> The recommendation when to use this is the wrong way around. The presented
> criteria is true for all devices since the bus master might be using regmap
> to implements its IO. Any regmap instance that might be used from within
> another regmap instance needs a custom lock class. This includes bus masters
> as well as resource providers like clock chips or regulators.

I would have thought that it is easier to figure out that a regmap is
going to access another one, instead of figuring out all possible uses
of a regmap...

As it stands, I could only see 2 cases where this kind of warning
happens (I did not find any other recursive locking warning involving
regmaps...):
1. rt5677: The "master" regmap is a "virtual" regmap, that, depending
on the device mode (DSP or not), either directly access the register
on a physical regmap on i2c bus, or does it indirectly, by doing a
number of read/write on that same physical regmap.
2. drivers/media/dvb-frontends/rtl2832.c: That's Antti's case. If I
understand correctly, regmap access require transfers on a private i2c
bus, which, itself, uses a regmap.

I think both cases are _fairly_ clear, but of course that may not
cover everything (and I'm not sure if anyone would figure it out
before the warning shows up...), and I'm not sure if there are cases
that look similar but don't require a lockdep class.
