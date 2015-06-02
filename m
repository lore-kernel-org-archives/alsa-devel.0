From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH 2/7] ASoC: rt5677: clean up gpiolib callbacks
Date: Wed, 03 Jun 2015 00:54:22 +0300
Message-ID: <556E260E.2030507@mleia.com>
References: <1433200158-6890-2-git-send-email-vz@mleia.com> <20150602193818.GG14071@sirena.org.uk> <556E1467.9030406@mleia.com> <20150602205017.GY14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150602205017.GY14071@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 02.06.2015 23:50, Mark Brown wrote:
> On Tue, Jun 02, 2015 at 11:39:03PM +0300, Vladimir Zapolskiy wrote:
>> On 02.06.2015 22:38, Mark Brown wrote:
>>> On Tue, Jun 02, 2015 at 02:09:13AM +0300, Vladimir Zapolskiy wrote:
> 
>>>> +		if (value)
>>>> +			val = RT5677_GPIO_OUT_HI(offset);
> 
>>> It seems like a greater variation in variable names might be called for
>>> here.
> 
>> thank you for review, you mean "val" vs. "value" I guess. May be you
>> have a better register value naming in mind?
> 
> I mean val vs value, yes.
> 
>>>>  		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
>>>> -			0x1 << (offset * 3 + 1), !!value << (offset * 3 + 1));
>>>> +				   RT5677_GPIO_OUT_MASK(offset), val);
> 
>>> Besides, isn't the minimal change here just to remove the !! (or do
>>> nothing)?
> 
>> this particular change mainly addresses "clean up gpiolib callbacks"
>> target as it is stated in subject/commit message. Removing of "!!" might
>> be unsafe, because the input value is not necessary 0 or 1 at the moment.
> 
> Sure, but if we use that we could also just not make any change to the
> code except for changing the type of the argument when that's needed.
> 
>>>  C defines a mapping between boolean and integer values.
> 
>> As for today it is correct. In the kernel right now there is a movement
>> of replacing for instance explicit integer constants to false/true, when
>> they are used with variables of bool type, e.g. see
>> scripts/coccinelle/misc/bool{init,return}.cocci.
> 
> Hrm, right.  I suppose it's more useful than checkpatch cleanups.  In
> any case I'm not sure it's relevant here where we're reading a value?

That's the question of bool type comprehension in my opinion. If bool is
seen from mathematical point of view, then arithmetic and bitwise
operations (except inapplicable shift) may be applied only if the result
is expected to be of bool type as well.

>> In my opinion changing GPIO level argument from int to bool should be
>> done, when all confusing cases like "!!false << (offset * 3 + 1)" above
>> (if just type of "value" is modified) are cleaned up in the code firstly.
> 
> I have to say I'm not sure I'm finding this is actually adding to the
> clarity - it was partly a cheap trick for compiler implementation but
> the int as boolean thing C has does also make this sort of code for
> mapping values onto bitfields more direct which is handy for low level
> systems programming like drivers.
> 

IIRC C95 doesn't define bool or _Bool at all, C99 implementations store
one bool value in one "char" (or one byte/8 bit memory cell), so
personally I'm not sure if arithmetic over boolean is so different from
arithmetic over char/unsigned char (with exception of implicit type and
value conversion).

Of course I'm not a C standard writer, but I have a feeling that one day
bool type may become quite distinct from int (or in other words bool
type will not be one of integer types). This may explain why C99 and C11
has "_Bool" type, not a hypothetically finalized in future "bool" type.
Also C99 clearly states that macro "false" and "true" may be undefined
and redefined to any arbitrary values.

I'm going to fix review comments and resend the series tomorrow, if you
find some of the changes wanted, please apply them, the rest may be
actually just covered by a simple function argument type change, which
hopefully happen in 4.2

--
With best wishes,
Vladimir
