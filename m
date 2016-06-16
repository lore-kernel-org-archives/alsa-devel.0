From: Ben Zhang <benzh@chromium.org>
Subject: Re: [alsa-devel] [PATCH v5] ASoC: rockchip: Add machine driver for
 RK3399 GRU Boards
Date: Wed, 15 Jun 2016 19:36:17 -0700
Message-ID: <CAOV7By+hU3c0CVzW0_V+g6iwpzVk_A4GMR5ie6afkhLO9Lv0tQ@mail.gmail.com>
References: <1465807339-1100-1-git-send-email-zhengxing@rock-chips.com>
 <20160614223810.GA7925@rob-hp-laptop> <20160615095312.GY2282@sirena.org.uk> <CAL_JsqKEDw14HmbW=78_4P03nFDfmT7kOn4RsTF-PrBi+jWr0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKEDw14HmbW=78_4P03nFDfmT7kOn4RsTF-PrBi+jWr0g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Xing Zheng <zhengxing@rock-chips.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Doug Anderson <dianders@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Kumar Gala <galak@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, smbarber@chromium.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 15, 2016 at 5:44 AM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Jun 15, 2016 at 4:53 AM, Mark Brown <broonie@kernel.org> wrote:
>> On Tue, Jun 14, 2016 at 05:38:10PM -0500, Rob Herring wrote:
>>> On Mon, Jun 13, 2016 at 04:42:18PM +0800, Xing Zheng wrote:
>>
>>> > +sound {
>>> > +   compatible = "rockchip,rk3399-gru-sound";
>>> > +   rockchip,cpu = <&i2s0>;
>>> > +   rockchip,codec = <&max98357a &rt5514 &da7219>;
>>
>>> These seem fairly standard though a variety of versions in the bindings.
>>> Can we use audio-codec and audio-cpu (or cpu or audio-dai) here? Mark?
>>
>> Well, the roles aren't actually that standard (the fact that there's
>> multiple CODECs and one CPU DAI here is really odd and definitely needs
>> a very system specific interpretation).  If they were standard we
>> already have the simple-card binding that things should be using.
>> There's no point in standard property names if the interpretation has to
>> be non-standard.
>
> Okay, I agree with the system specific interpretation part. However, I
> don't think using simple-card or not determines using common
> properties.
>

Hi Mark, I have a question for the one CPU DAI + multiple CODECs
setup. The machine driver defines 3 DAI links, connecting the same CPU
DAI to 3 different CODEC DAIs. Does ASoC/DAPM support
enabling/disabling an individual DAI link based on the status of the
endpoint widget (e.g. DAPM_SPK) connected to the corresponding CODEC?

The goal is to let user select either headphone(da7219) or
speaker(max98357a) as output. max98357a driver does not expose a
kcontrol for mute. It sets a shutdown GPIO on PCM_TRIGGER_START/STOP.
And it seems soc_pcm_trigger calls the trigger op of all 3 CODEC DAIs,
even when the DAPM_SPK widget is disabled by its pin switch.

>> The vendor specific prefixes are there because all bindings are supposed
>> to add prefixes to property names.
>
> ...unless they are common.
>
> Rob
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Thanks,
Ben
