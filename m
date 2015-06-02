From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH 2/7] ASoC: rt5677: clean up gpiolib callbacks
Date: Tue, 02 Jun 2015 23:39:03 +0300
Message-ID: <556E1467.9030406@mleia.com>
References: <1433200158-6890-2-git-send-email-vz@mleia.com> <20150602193818.GG14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150602193818.GG14071@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 02.06.2015 22:38, Mark Brown wrote:
> On Tue, Jun 02, 2015 at 02:09:13AM +0300, Vladimir Zapolskiy wrote:
> 
>> +		if (value)
>> +			val = RT5677_GPIO_OUT_HI(offset);
> 
> It seems like a greater variation in variable names might be called for
> here.

thank you for review, you mean "val" vs. "value" I guess. May be you
have a better register value naming in mind?

>>  		regmap_update_bits(rt5677->regmap, RT5677_GPIO_CTRL2,
>> -			0x1 << (offset * 3 + 1), !!value << (offset * 3 + 1));
>> +				   RT5677_GPIO_OUT_MASK(offset), val);
> 
> Besides, isn't the minimal change here just to remove the !! (or do
> nothing)?

this particular change mainly addresses "clean up gpiolib callbacks"
target as it is stated in subject/commit message. Removing of "!!" might
be unsafe, because the input value is not necessary 0 or 1 at the moment.

>  C defines a mapping between boolean and integer values.
> 

As for today it is correct. In the kernel right now there is a movement
of replacing for instance explicit integer constants to false/true, when
they are used with variables of bool type, e.g. see
scripts/coccinelle/misc/bool{init,return}.cocci.

In my opinion changing GPIO level argument from int to bool should be
done, when all confusing cases like "!!false << (offset * 3 + 1)" above
(if just type of "value" is modified) are cleaned up in the code firstly.

--
With best wishes,
Vladimir
