From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH 4/7] ASoC: wm8903: simplify gpiolib callbacks
Date: Tue, 02 Jun 2015 23:41:01 +0300
Message-ID: <556E14DD.5040606@mleia.com>
References: <1433200031-6748-1-git-send-email-vz@mleia.com> <1433200158-6890-4-git-send-email-vz@mleia.com> <20150602194153.GH14071@sirena.org.uk> <556E0F8F.1050307@mleia.com> <20150602203130.GU14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150602203130.GU14071@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 02.06.2015 23:31, Mark Brown wrote:
> On Tue, Jun 02, 2015 at 11:18:23PM +0300, Vladimir Zapolskiy wrote:
>> On 02.06.2015 22:41, Mark Brown wrote:
>>> On Tue, Jun 02, 2015 at 02:09:15AM +0300, Vladimir Zapolskiy wrote:
> 
>>>> @@ -1783,18 +1783,13 @@ static int wm8903_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
>>>>  {
>>>>  	struct wm8903_priv *wm8903 = gpio_to_wm8903(chip);
>>>>  	unsigned int mask, val;
>>>> -	int ret;
>>>>  
>>>>  	mask = WM8903_GPn_FN_MASK | WM8903_GPn_DIR_MASK;
>>>>  	val = (WM8903_GPn_FN_GPIO_INPUT << WM8903_GPn_FN_SHIFT) |
>>>>  		WM8903_GPn_DIR;
>>>>  
>>>> -	ret = regmap_update_bits(wm8903->regmap,
>>>> -				 WM8903_GPIO_CONTROL_1 + offset, mask, val);
>>>> -	if (ret < 0)
>>>> -		return ret;
>>>> -
>>>> -	return 0;
>>>> +	return regmap_update_bits(wm8903->regmap,
>>>> +				  WM8903_GPIO_CONTROL_1 + offset, mask, val);
>>>>  }
>>>>  
>>>>  static int wm8903_gpio_get(struct gpio_chip *chip, unsigned offset)
> 
>>> This appears to be an unrelated coding style change.
> 
>> this particular patch is named "simplify gpiolib callbacks".
> 
>> Do you prefer to separate the change here in .direction_in
>> implementation from the rest?
> 
> It doesn't appear to make any changes related to boolean variables
> (AFAICT it's just removing the ret variable) so it shouldn't be in a
> change about boolean variables.
> 

Okay, will split the change then.

--
With best wishes,
Vladimir
