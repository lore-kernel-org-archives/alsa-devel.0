From: Shine Liu <shinel@foxmail.com>
Subject: Re: [PATCH] ASoC: UDA134X Codec: Fix mute/unmute code
 mistake and add ADC/DAC power control support
Date: Mon, 17 Aug 2009 19:53:15 +0800
Message-ID: <1250509995.1932.44.camel@shinel>
References: <1250498216.2764.1.camel@shinel>
	<20090817103248.GA4464@sirena.org.uk> <1250508154.1932.37.camel@shinel>
	<20090817112756.GA19898@rakim.wolfsonmicro.main>
Reply-To: shinel@foxmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg70.qq.com (smtpbg70.qq.com [119.147.10.229])
	by alsa0.perex.cz (Postfix) with SMTP id 0AABA24697
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 13:53:47 +0200 (CEST)
In-Reply-To: <20090817112756.GA19898@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2009-08-17 at 12:27 +0100, Mark Brown wrote:

> +	/* If there are no DAPM widgets then try to figure out power from the
> +	 * event type.
> +	 */
> +	if (list_empty(&codec->dapm_widgets)) {
> +		switch (event) {
> +		case SND_SOC_DAPM_STREAM_START:
> +		case SND_SOC_DAPM_STREAM_RESUME:
> +			sys_power = 1;
> +			break;
> +		case SND_SOC_DAPM_STREAM_NOP:
> +			sys_power == codec->bias_level != SND_SOC_BIAS_STANDBY;

Should be "sys_power = codec->bias_level != SND_SOC_BIAS_STANDBY;" ?

> +		default:
> +			break;
> +		}
> +	}
> +
>  	/* If we're changing to all on or all off then prepare */
>  	if ((sys_power && codec->bias_level == SND_SOC_BIAS_STANDBY) ||
>  	    (!sys_power && codec->bias_level == SND_SOC_BIAS_ON)) {
> 
> 
> 
