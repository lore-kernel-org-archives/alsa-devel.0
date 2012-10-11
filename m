From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] i2c: change the id to let the i2c-gpio work
Date: Thu, 11 Oct 2012 16:11:44 +0900
Message-ID: <20121011071140.GA11726@opensource.wolfsonmicro.com>
References: <1349923097-14115-1-git-send-email-voice.shen@atmel.com>
 <1349923097-14115-4-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1349923097-14115-4-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, nicolas.ferre@atmel.com, jm.lin@atmel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 11, 2012 at 10:38:17AM +0800, Bo Shen wrote:

>  static struct platform_device at91sam9260_twi_device = {
>  	.name			= "i2c-gpio",
> -	.id			= -1,
> +	.id			= 0,
>  	.dev.platform_data	= &pdata,
>  };

Why would this have any effect on the operation of the i2c-gpio driver?
This suggests i2c-gpio is buggy.
