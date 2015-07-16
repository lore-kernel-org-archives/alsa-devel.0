From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 1/2] ASoC: rockchip: Add machine driver for max98090
 codec
Date: Thu, 16 Jul 2015 16:19:43 +0200
Message-ID: <1437056383.28351.23.camel@tiscali.nl>
References: <1436930143-31361-1-git-send-email-zhengxing@rock-chips.com>
	   <1436930143-31361-2-git-send-email-zhengxing@rock-chips.com>
	  <1437033944.27428.11.camel@tiscali.nl> <55A79394.5090905@rock-chips.com>
	 <1437047374.28351.8.camel@tiscali.nl> <55A79C8B.7020402@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55A79C8B.7020402@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: zhengxing <zhengxing@rock-chips.com>
Cc: dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

On do, 2015-07-16 at 19:59 +0800, zhengxing wrote:
> I mean that the use of MODALIAS() in this patch, and I refered to
> tegra_max98090.c(have been upstreamed) that used it like this also. So
> I didn't care the using.

And I think the same problem with MODULE_ALIAS() can be found in that
driver. Ie, where does the platform device that has a "tegra-snd
-max98090" .name hide? (See the reply I just sent to mark for more
details.)

Thanks,


Paul Bolle
