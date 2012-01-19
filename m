From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Add external amplifier controls for
 Visstrim_M10.
Date: Thu, 19 Jan 2012 17:52:38 +0100
Message-ID: <4F184A56.3080007@metafoo.de>
References: <1326984807-10424-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-224.synserver.de (smtp-out-227.synserver.de
	[212.40.185.227]) by alsa0.perex.cz (Postfix) with SMTP id A52F124347
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2012 17:51:48 +0100 (CET)
In-Reply-To: <1326984807-10424-1-git-send-email-javier.martin@vista-silicon.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 01/19/2012 03:53 PM, Javier Martin wrote:
> Visstrim_M10 has an external class D amplifier.
> This patch provides support for controlling the 4
> possible gain levels and per channel muting.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> ---
>  sound/soc/imx/mx27vis-aic32x4.c |   72 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 72 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/imx/mx27vis-aic32x4.c b/sound/soc/imx/mx27vis-aic32x4.c
> index d37e23c..47a7bf9 100644
> --- a/sound/soc/imx/mx27vis-aic32x4.c
> +++ b/sound/soc/imx/mx27vis-aic32x4.c
> @@ -25,16 +25,36 @@
> [...]
> +
>  static const struct snd_kcontrol_new mx27vis_aic32x4_controls[] = {
>  	SOC_DAPM_PIN_SWITCH("External Mic"),
> +	SOC_SINGLE_EXT("LO Ext Boost", MX27VIS_AMP_GAIN, 0, 3, 0,
> +		       mx27vis_amp_get, mx27vis_amp_set),

Do you know the dB gain of the amplifier? If yes you should provide it using
SOC_SINGLE_EXT_TLV.

> [...]
>  };
>  
> [...]
