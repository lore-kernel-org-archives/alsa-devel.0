From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/7] ASoC: wm8903: generalize GPIO control register bits
Date: Tue, 2 Jun 2015 10:19:43 +0100
Message-ID: <20150602091943.GE3449@opensource.wolfsonmicro.com>
References: <1433200031-6748-1-git-send-email-vz@mleia.com> <1433200158-6890-3-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433200158-6890-3-git-send-email-vz@mleia.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 02, 2015 at 02:09:14AM +0300, Vladimir Zapolskiy wrote:
> All GPIO1/2/3/4/5 control registers have the same bit map, but in
> implementation of gpiolib callbacks WM8903_GPn_*, WM8903_GP1_* and
> WM8903_GP2_* macro are mixed up. Replace particular GPIOn control
> register bit definitions with generic ones and save ~150 LoCs.
> 
> No functional change.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Axel Lin <axel.lin@ingics.com>
> Cc: patches@opensource.wolfsonmicro.com
> ---

If Mark's ok with this I think I am. Generally those register
files tend to list all the bits on the chip, but certainly in
this case nothing is really added by listing all the GPIO
registers seperately.

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
