From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH 5/7] ASoC: wm5100: remove bitwise operations involving
 GPIO level value
Date: Tue, 02 Jun 2015 23:23:41 +0300
Message-ID: <556E10CD.3090301@mleia.com>
References: <1433200031-6748-1-git-send-email-vz@mleia.com> <1433200158-6890-5-git-send-email-vz@mleia.com> <20150602194558.GI14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150602194558.GI14071@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 02.06.2015 22:45, Mark Brown wrote:
> On Tue, Jun 02, 2015 at 02:09:16AM +0300, Vladimir Zapolskiy wrote:
> 
>> @@ -2244,26 +2244,27 @@ static inline struct wm5100_priv *gpio_to_wm5100(struct gpio_chip *chip)
>>  static void wm5100_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>>  {
>>  	struct wm5100_priv *wm5100 = gpio_to_wm5100(chip);
>> +	unsigned int val = 0;
>> +
>> +	if (value)
>> +		val = 0x1 << WM5100_GP1_LVL_SHIFT;
> 
> Write this as an if/else so the reader doesn't have to wonder why you've
> missed the handling of the false case.  
> 

the only objection I have is that the resulting code will be two lines
longer. If you think this code is not clear enough (is "val" vs. "value"
misleading?), I'll change the rest of my patches, which contain the same
logic structure, please let me know.

--
With best wishes,
Vladimir
