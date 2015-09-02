From: Lee Jones <lee@kernel.org>
Subject: Re: [PATCH] ASoC: bcm2835-i2s: Fix module autoload for OF platform
 drivers
Date: Wed, 2 Sep 2015 10:21:14 +0100
Message-ID: <20150902092114.GV4796@x1>
References: <20150827150401.GA32653@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150827150401.GA32653@goodgumbo.baconseed.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, alsa-devel@alsa-project.org, linux-rpi-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, 27 Aug 2015, Luis de Bethencourt wrote:

> These platform drivers have a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>
> ---
>  sound/soc/bcm/bcm2835-i2s.c | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Lee Jones <lee@kernel.org>

> diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
> index 03fa1cb..8c435be 100644
> --- a/sound/soc/bcm/bcm2835-i2s.c
> +++ b/sound/soc/bcm/bcm2835-i2s.c
> @@ -862,6 +862,8 @@ static const struct of_device_id bcm2835_i2s_of_match[] = {
>  	{},
>  };
>  
> +MODULE_DEVICE_TABLE(of, bcm2835_i2s_of_match);
> +
>  static struct platform_driver bcm2835_i2s_driver = {
>  	.probe		= bcm2835_i2s_probe,
>  	.driver		= {
