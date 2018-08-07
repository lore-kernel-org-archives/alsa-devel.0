From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: rt5677: Fix initialization of
 rt5677_of_match.data
Date: Tue, 07 Aug 2018 22:13:47 +0300
Message-ID: <87753f10135e5f0791a6bfecb37ddecf7fd5b977.camel@linux.intel.com>
References: <20180807171940.150507-1-mka@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180807171940.150507-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>, Nicolas Boichat <drinkcat@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2018-08-07 at 10:19 -0700, Matthias Kaehlcke wrote:
> The driver expects to find the device id in rt5677_of_match.data,
> however
> it is currently assigned to rt5677_of_match.type. Fix this.
> 
> The problem was found with the help of clang:
>   sound/soc/codecs/rt5677.c:5010:36: warning: expression which
> evaluates to
>   zero treated as a null pointer constant of type 'const void *'
>   [-Wnon-literal-null-conversion]
>     { .compatible = "realtek,rt5677", RT5677 },
>                                       ^~~~~~
> 
> Fixes: ddc9e69b9dc2 ("ASoC: rt5677: Hide platform data in the module
> sources")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

While this is correct fix, it seems it was never used.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 
>  static const struct of_device_id rt5677_of_match[] = {
> -	{ .compatible = "realtek,rt5677", RT5677 },
> +	{ .compatible = "realtek,rt5677", .data = (const void *)RT5677
> },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, rt5677_of_match);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
