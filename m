From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 2.6.27?] ASoC: Correct inverted Mic PGA
 Switch control in wm8510 driver
Date: Fri, 03 Oct 2008 10:20:53 -0700
Message-ID: <48E65475.3040203@boundarydevices.com>
References: <1223041684-4449-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth02.csee.onr.siteprotect.com
	(smtpauth02.csee.onr.siteprotect.com [64.26.60.136])
	by alsa0.perex.cz (Postfix) with ESMTP id 3596C243A7
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Oct 2008 19:21:02 +0200 (CEST)
In-Reply-To: <1223041684-4449-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> Mic PGA Switch should be inverted in the WM8510 driver but isn't.
> 
> Reported-by: ext-jukka.hynninen@vaisala.com
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> This bugfix applies to 2.6.27 but the issue is not very severe - it'd be
> good to get it in but it's not critical.
> 
>  sound/soc/codecs/wm8510.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8510.c b/sound/soc/codecs/wm8510.c
> index 75ed041..f644da6 100644
> --- a/sound/soc/codecs/wm8510.c
> +++ b/sound/soc/codecs/wm8510.c
> @@ -199,7 +199,7 @@ SOC_DAPM_SINGLE("PCM Playback Switch", WM8510_MONOMIX, 0, 1, 0),
>  };
>  
>  static const struct snd_kcontrol_new wm8510_boost_controls[] = {
> -SOC_DAPM_SINGLE("Mic PGA Switch", WM8510_INPPGA,  6, 1, 0),
> +SOC_DAPM_SINGLE("Mic PGA Switch", WM8509_INPPGA,  6, 1, 1),
>  SOC_DAPM_SINGLE("Aux Volume", WM8510_ADCBOOST, 0, 7, 0),
>  SOC_DAPM_SINGLE("Mic Volume", WM8510_ADCBOOST, 4, 7, 0),
>  };

Why the WM509 prefix instead of WM8510?
