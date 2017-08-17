From: jeffy <jeffy.chen@rock-chips.com>
Subject: Re: [PATCH v2 1/3] ASoC: rockchip: Parse dai links from dts
Date: Thu, 17 Aug 2017 12:45:13 +0800
Message-ID: <59951F59.3010101@rock-chips.com>
References: <1502340898-28403-1-git-send-email-jeffy.chen@rock-chips.com> <1502340898-28403-2-git-send-email-jeffy.chen@rock-chips.com> <20170816215909.GC109008@google.com> <5994CD58.7030406@rock-chips.com> <20170816235058.GA173745@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170816235058.GA173745@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: linux-kernel@vger.kernel.org, dgreid@chromium.org, heiko@sntech.de, briannorris@chromium.org, dianders@chromium.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Matthias,

On 08/17/2017 07:50 AM, Matthias Kaehlcke wrote:
> El Thu, Aug 17, 2017 at 06:55:20AM +0800 jeffy ha dit:
>
>> hi matthias,
>>
>> thanks for your suggestion.
>>
>> On 08/17/2017 05:59 AM, Matthias Kaehlcke wrote:
>>> El Thu, Aug 10, 2017 at 12:54:56PM +0800 Jeffy Chen ha dit:
>>>
>>>>> Refactor rockchip_sound_probe, parse dai links from dts instead of
>>>>> hard coding them.
>>> Mark doesn't seem to be overly convinced that 'rockchip,codec-names'
>>> is a good idea (https://lkml.org/lkml/2017/8/10/511).
>>>
>>> How about using something like this instead:
>>>
>>> static const char *dailink_compat[] = {
>>> 	[DAILINK_MAX98357A] = "maxim,max98357a",
>>> 	[DAILINK_RT5514] = "realtek,rt5514",
>>> 	[DAILINK_DA7219] = "dlg,da7219",
>>> };
>> i've thought about this too, but i'm working on converting rt5514
>> dsp(spi) from codec name matching to of_node, and it would have the
>> same compatible with rt5514(i2c)
>
> Bummer!
>
> I wonder if a relatively inoffensive DT hack would be an appropriate
> solution in this case, since the conflicting compatible string is a
> somewhat special case and this change only affects the DT and the
> driver/glue of a specific device (family).
>
> The hack would consist in adding an additional 'compatible' entry to
> the DT entry of the codec, which is ignored by the rt5514 driver, and
> only used by the sound glue to identify it:
>
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> @@ -671,7 +671,7 @@ ap_i2c_mic: &i2c1 {
>          i2c-scl-rising-time-ns = <300>;
>
>          headsetcodec: rt5514@57 {
> -               compatible = "realtek,rt5514";
> +               compatible = "realtek,rt5514", "realtek,rt5514-i2c";
>
>
> And then use "realtek,rt5514-i2c" in dailink_compat.
this should work, i'll do that in new version, thanks.

>
> Mark, would you prefer a hack like this over the list of codec names
> or do you have any other suggestions?
>
> Matthias
>
>
>
