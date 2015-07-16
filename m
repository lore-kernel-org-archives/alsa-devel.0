From: zhengxing <zhengxing@rock-chips.com>
Subject: Re: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090 codec
Date: Thu, 16 Jul 2015 19:59:07 +0800
Message-ID: <55A79C8B.7020402@rock-chips.com>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>   <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>  <1437033944.27428.11.camel@tiscali.nl> <55A79394.5090905@rock-chips.com> <1437047374.28351.8.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437047374.28351.8.camel@tiscali.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Paul,
     I mean that the use of MODALIAS() in this patch, and I refered to=20
tegra_max98090.c(have been upstreamed) that used it like this also. So =
I=20
didn't care the using.

Thanks.

On 2015=E5=B9=B407=E6=9C=8816=E6=97=A5 19:49, Paul Bolle wrote:
> Hi,
>
> On do, 2015-07-16 at 19:20 +0800, zhengxing wrote:
>>> Did I miss something? Or is there another way this alias is useful
>>> here?
>> Yes, I didn't care about this but I think it maybe correct.
> What is correct: my comment or the use of MODALIAS() in this patch?
>
> Thanks,
>
>
> Paul Bolle
>
>
>
