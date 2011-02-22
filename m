From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: omap: rx51: Add FM transmitter
	support
Date: Tue, 22 Feb 2011 08:59:11 +0200
Message-ID: <4D635EBF.3040409@nokia.com>
References: <1298293042-13801-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa01.nokia.com (smtp.nokia.com [147.243.1.47])
	by alsa0.perex.cz (Postfix) with ESMTP id 3744C103854
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 07:59:12 +0100 (CET)
In-Reply-To: <1298293042-13801-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 02/21/11 14:57, ext Jarkko Nikula wrote:
> Si4713 FM transmitter on Nokia RX-51/N900 is connected to same Line out
> signals of TLV320AIC34 than TPA6130 headphone amplifier.
> 
> This patch adds route to transmitter and "FM Transmitter" control to keep
> route active when needed.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

...

>  	{"DMic Rate 64", NULL, "Mic Bias 2V"},
>  	{"Mic Bias 2V", NULL, "DMic"},
> @@ -292,6 +295,7 @@ static const struct snd_kcontrol_new aic34_rx51_controls[] = {
>  		     rx51_get_input, rx51_set_input),
>  	SOC_ENUM_EXT("Jack Function", rx51_enum[2],
>  		     rx51_get_jack, rx51_set_jack),

Have you thought of converting the 'Jack Function' to DAPM_PIN_SWITCH as
well?

> +	SOC_DAPM_PIN_SWITCH("FM Transmitter"),
>  };
>  
>  static const struct snd_kcontrol_new aic34_rx51_controlsb[] = {

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
