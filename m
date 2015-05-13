From: zhengxing <zhengxing@rock-chips.com>
Subject: Re: [PATCH 1/4] ASoC: rockchip: add rockchip machine driver
Date: Wed, 13 May 2015 21:23:01 +0800
Message-ID: <55535035.5070608@rock-chips.com>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com> <1431422797-31903-2-git-send-email-zhengxing@rock-chips.com> <20150512192215.GZ3066@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150512192215.GZ3066@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Xing Zheng <acgzxing@gmail.com>, dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 2015=E5=B9=B405=E6=9C=8813=E6=97=A5 03:22, Mark Brown wrote:
> On Tue, May 12, 2015 at 05:26:34PM +0800, Xing Zheng wrote:
>> From: zhengxing<zhengxing@rock-chips.com>
>>
>> In most cases, we maybe use simple-card as generic machine driver
>> on next kernel, but there are some issue that jack detection and
>> widgets extandable on simple-card.
>>
>> Own machine drvier can select one valid codec from supported codecs,
>> and add needful function from dts on rockchip platform.
> Is it not possible to extend simple card to handle your use cases?
> Given the very generic naming and the fact that things like jack
> detection and so on should depend on the CODEC and board usually rath=
er
> than on the SoC it doesn't sound like this is Rockchip specific.
>
> This also looks like you're reimplementing some device model enumerat=
ion
> stuff which probably shouldn't be happening but let's understand the
> problem you're trying to solve here before going too far into the cod=
e.
Dear Mark,
Thanks for your reply.

Because we are trying to bring rt5650 in the project, so we intend to=20
describe supported codecs with DTS via only a rockchip machine driver f=
ile,
others remain pre-implement(like max98090 / rt5645 that vendor machine=20
driver).
I communicated with Dylan, and he told me that the jack detection is an=
=20
issue in the simple-card, and suggested we are better to send them at=20
present.

Thanks.
