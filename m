From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH 1/3] ASoC: jack: Add a jack detect callback via codec
Date: Mon, 18 Apr 2016 09:40:50 -0700
Message-ID: <CAEUnVG6FWM5ud8FH7FyhNTSxOYg8GM_eeyUX7ynrSRC6uhOePg@mail.gmail.com>
References: <1460967452-24574-1-git-send-email-zhengxing@rock-chips.com>
 <1460967452-24574-2-git-send-email-zhengxing@rock-chips.com>
 <20160418092218.GL3217@sirena.org.uk> <5714AC57.2070901@rock-chips.com>
 <20160418095302.GN3217@sirena.org.uk> <5714B0D4.7080506@rock-chips.com>
 <5714B4D0.90406@rock-chips.com> <20160418114618.GW3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160418114618.GW3217@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Xing Zheng <zhengxing@rock-chips.com>, linux-rockchip@lists.infradead.org, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Adam.Thomson@diasemi.com, sugar.zhang@rock-chips.com, Xu Jianqun <jay.xu@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 18, 2016 at 4:46 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Apr 18, 2016 at 06:20:00PM +0800, Xing Zheng wrote:
>> On 2016=E5=B9=B404=E6=9C=8818=E6=97=A5 18:03, Xing Zheng wrote:
>
>> sound {
>>         ......
>>         simple-audio-card,dai-link@0 {
>>             format =3D "i2s";
>>             cpu {
>>                 sound-dai =3D <&i2s0>;
>>             };
>>
>>             codec {
>>                 sound-dai =3D <&codec>;
>>
>>                 simple-audio-card,codec-jack =3D
>>                     "JACK_HEADSET",
>>                     "JACK_BTN_0",
>>                     "JACK_BTN_1",
>>                     "JACK_BTN_2",
>>                     "JACK_BTN_3";
>>             };
>>         };
>
> This seems like it's only half the job and worryingly close to Linux
> internals.  In particular the fact that the binding is specific to
> simple-card and the fact that it's being placed on the CODEC (rather
> than a separate object that the CODEC references) so that we can't
> combine multiple devices are both a concern.
>
> Dylan Reid did have an earlier go at defining a binding for this:
>
>   http://thread.gmane.org/gmane.linux.alsa.devel/138906
>
> which went through a couple more iterations but the work on that seem=
ed
> to die off a bit.

Thanks for forwarding this.  I did intend to get back to that.  But,
almost a year later, obviously I haven't.

Xing if you want to pick this up it would be great.  Lars had some
good points on that original discussion, which I think we can
integrate into a single solution.
