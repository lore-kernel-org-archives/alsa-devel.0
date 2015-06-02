From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/7] ASoC: wm8996: remove bitwise operations involving
	GPIO level value
Date: Tue, 2 Jun 2015 09:43:48 +0100
Message-ID: <20150602084348.GD3449@opensource.wolfsonmicro.com>
References: <1433200031-6748-1-git-send-email-vz@mleia.com> <1433200158-6890-7-git-send-email-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433200158-6890-7-git-send-email-vz@mleia.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 02, 2015 at 02:09:18AM +0300, Vladimir Zapolskiy wrote:
> The main intention of the change is to remove bitwise operations on
> GPIO level value as a preceding change before updating gpiolib
> callbacks to utilize bool type to represent GPIO level.
> 
> No functional change.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Axel Lin <axel.lin@ingics.com>
> Cc: patches@opensource.wolfsonmicro.com
> ---

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
