From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [alsa-devel] [PATCH 1/5] ASoC: wm8731: rework power management
Date: Thu, 30 Jun 2011 17:04:02 +0200
Message-ID: <4E0C9062.4010901@atmel.com>
References: <1309370419-22810-1-git-send-email-nicolas.ferre@atmel.com>	<ccd4b125244271af7978948689cf1dcef37bc06b.1309368631.git.nicolas.ferre@atmel.com>	<20110629171148.GB10798@opensource.wolfsonmicro.com>
	<4E0C80B8.7030006@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4E0C80B8.7030006@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org, =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Le 30/06/2011 15:57, Nicolas Ferre :
> Le 29/06/2011 19:11, Mark Brown :
>> On Wed, Jun 29, 2011 at 08:00:15PM +0200, Nicolas Ferre wrote:
>>
>> Don't mix multiple changes into a single patch!  There's no perceptible
>> code overlap between these so I don't understand why you've merged them,
>> it just makes review harder and the changelog less descriptive.
> 
> Ok.
> 
>>> - preserve crystal oscillator across suspend/resume sequence:
>>>   enabled by default, it should be kept enabled on resume.
>>
>> This isn't what your code does...
>>
>>>  		snd_soc_write(codec, WM8731_ACTIVE, 0x0);
>>> -		snd_soc_write(codec, WM8731_PWR, 0xffff);
>>> +		/* standby: keep crystal oscillator enabled */
>>> +		snd_soc_write(codec, WM8731_PWR, 0x00df);
>>
>> This doesn't keep the crystal oscillator enabled, this forces it on in
>> suspend (and without looking at the datasheet it also changes way more
>> than the one register bit I'd expect to be changed).  If the system
>> isn't using the oscillator then that's not good.
>>
>> I'd expect to see a change to using snd_soc_update_bits() based on your
>> description, or more likely something more involved.
> 
> First of all, I experienced issues while not having OSC enabled during suspend/resume cycle. Am I right supposing that, if using oscillator to clock the codec, I have to keep it running during a suspend/resume cycle?
> 
> Is something like this sounds like an acceptable option or we need something more sophisticated?
> 
> @@ -481,7 +481,10 @@ static int wm8731_set_bias_level(struct snd_soc_codec *codec,
>                 break;
>         case SND_SOC_BIAS_OFF:
>                 snd_soc_write(codec, WM8731_ACTIVE, 0x0);
> -               snd_soc_write(codec, WM8731_PWR, 0xffff);
> +               reg = 0xdf;
> +               if (wm8731->sysclk_type == WM8731_SYSCLK_XTAL)

Actually it is: if... != WM8731_SYSCLK_XTAL

> +                               reg |= 1 << 0x5;
> +               snd_soc_update_bits(codec, WM8731_PWR, 0x00ff, reg);

And maybe here a simple snd_soc_write() is sufficient...

>                 regulator_bulk_disable(ARRAY_SIZE(wm8731->supplies),
>                                        wm8731->supplies);
>                 break;
> 
> And, yes, there is only 8 bits dedicated to power down control in this register.
> 
> Best regards,

-- 
Nicolas Ferre
