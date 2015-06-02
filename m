From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH 5/7] ASoC: wm5100: remove bitwise operations involving
 GPIO level value
Date: Tue, 02 Jun 2015 23:58:25 +0300
Message-ID: <556E18F1.7030008@mleia.com>
References: <1433200031-6748-1-git-send-email-vz@mleia.com> <1433200158-6890-5-git-send-email-vz@mleia.com> <20150602194558.GI14071@sirena.org.uk> <556E10CD.3090301@mleia.com> <20150602203631.GV14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150602203631.GV14071@sirena.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 02.06.2015 23:36, Mark Brown wrote:
> On Tue, Jun 02, 2015 at 11:23:41PM +0300, Vladimir Zapolskiy wrote:
>> On 02.06.2015 22:45, Mark Brown wrote:
>>> On Tue, Jun 02, 2015 at 02:09:16AM +0300, Vladimir Zapolskiy wrote:
> 
>>>> +	unsigned int val = 0;
>>>> +
>>>> +	if (value)
>>>> +		val = 0x1 << WM5100_GP1_LVL_SHIFT;
> 
>>> Write this as an if/else so the reader doesn't have to wonder why you've
>>> missed the handling of the false case.  
> 
>> the only objection I have is that the resulting code will be two lines
>> longer. If you think this code is not clear enough (is "val" vs. "value"
>> misleading?), I'll change the rest of my patches, which contain the same
>> logic structure, please let me know.
> 
> Especially after the unrelated style change thing earlier on (which
> meant I was reading things more carefully than usual) it'd be good to
> make things as clear as possible - you're right that the val vs value
> thing isn't helping either.  

got your concern, will send an update.

> Like I say I am a bit surprised that the int/bool conversion doesn't do
> the right thing without any code changes other than the type of the
> parameter but ICBW, I didn't actually check.
> 

My tested compilers do the work right, but I can not be sure about the
whole variety of compilers, well, probably I should just follow the
standard, which in turn is expected to be quite volatile in future
revisions regarding usage of "_Bool" or future "bool" type.

If we assume the preferred Linux kernel style to use true/false
constants for boolean variables only (see the reference to
bool{init,return}.cocci), then even if bitwise and arithmetic operations
on bool type are understandable to a compiler, but probably "false <<
true" (or whatever is hidden under a variable name) is not quite
aesthetic for a human eye. This is not a technical argument though, and
I'm not sure if any clear code style policy related to the case is agreed.

--
With best wishes,
Vladimir
