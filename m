From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH 4/4] sound/soc/atmel: don't use devm_pinctrl_get_select_default()
 in probe
Date: Mon, 14 Oct 2013 13:28:37 +0800
Message-ID: <525B8105.6090303@atmel.com>
References: <1381681071-6021-1-git-send-email-wsa@the-dreams.de> <1381681071-6021-5-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1381681071-6021-5-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Wolfram Sang,

On 10/14/2013 00:17, Wolfram Sang wrote:
> Since commit ab78029 (drivers/pinctrl: grab default handles from device core),
> we can rely on device core for setting the default pins.
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org> (personally at LCE13)
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>   sound/soc/atmel/atmel_wm8904.c | 8 --------
>   1 file changed, 8 deletions(-)

Tested OK on at91sam9n12ek and sama5d3xek board.
Thanks.

Acked-by: Bo Shen <voice.shen@atmel.com>

Best Regards,
Bo Shen
