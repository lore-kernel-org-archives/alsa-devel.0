From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH] ASoC: rk3399_gru_sound: Support 32, 44.1 and 88.2 kHz
 sample rates
Date: Thu, 20 Jun 2019 18:08:14 +0200
Message-ID: <CAFqH_50RN0xXfzMDNRjQpk8egCEcxH7NEXr8KVYsh04mSLQEiQ@mail.gmail.com>
References: <20190620134708.28311-1-enric.balletbo@collabora.com> <20190620154150.GE5316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190620154150.GE5316@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, Xing Zheng <zhengxing@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Collabora Kernel ML <kernel@collabora.com>, Benson Leung <bleung@chromium.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

Missatge de Mark Brown <broonie@kernel.org> del dia dj., 20 de juny
2019 a les 17:42:
>
> On Thu, Jun 20, 2019 at 03:47:08PM +0200, Enric Balletbo i Serra wrote:
> > According to the datasheet the max98357a also supports 32, 44.1 and
> > 88.2 kHz sample rate. This support was also introduced recently by
> > commit fdf34366d324 ("ASoC: max98357a: add missing supported rates").
> > This patch adds support for these rates also for the machine driver so
> > we get rid of the errors like the below and we are able to play files
> > using these sample rates.
>
> Does the machine actually need to validate this at all?  The component
> drivers can all apply whatever constraints are needed and do their own
> validation, the machine driver is just getting in the way here.

I think you have reason, I'll test by removing these validation and
respin the patch.

Thanks,
~ Enric

> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
