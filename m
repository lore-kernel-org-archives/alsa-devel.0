From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: da732x: Mark DC offset control
	registers volatile
Date: Mon, 24 Feb 2014 11:31:25 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03376BAD3FC8@SW-EX-MBX01.diasemi.com>
References: <1393210853-32246-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.117])
 by alsa0.perex.cz (Postfix) with ESMTP id 40902265312
 for <alsa-devel@alsa-project.org>; Mon, 24 Feb 2014 12:31:27 +0100 (CET)
In-Reply-To: <1393210853-32246-1-git-send-email-broonie@kernel.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 24 Feb 2014 03:01:37 +0000, Mark Brown wrote:

> From: Mark Brown <broonie@linaro.org>
> 
> The driver reads from the DC offset control registers during callibration
> but since the registers are marked as volatile and there is a register
> cache the values will not be read from the hardware after the first reading
> rendering the callibration ineffective.
 
Guessing that should read 'not marked as volatile'.

> It appears that the driver was originally written for the ASoC level
> register I/O code but converted to regmap prior to merge and this issue
> was missed during the conversion as the framework level volatile register
> functionality was not being used.

Yes you're correct here, unfortunately. A good spot.

> +static bool da732x_volatile(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case DA732X_REG_HPL_DAC_OFF_CNTL:
> +	case DA732X_REG_HPR_DAC_OFF_CNTL:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +

Having looked over the driver again, can you include the following
registers as well: 

DA732X_REG_HPL
DA732X_REG_HPR

Also, if we're doing this then you can move to using snd_soc_read()
instead of hw_read(), I guess.
