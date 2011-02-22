From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: Fix WM8958 default microphone
 detection argument ordering
Date: Tue, 22 Feb 2011 09:42:35 +0000
Message-ID: <1298367755.3353.14.camel@odin>
References: <>
	<1298350326-15840-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 02C6C1038A3
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 10:42:38 +0100 (CET)
Received: by mail-wy0-f179.google.com with SMTP id 28so1936313wyb.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 01:42:38 -0800 (PST)
In-Reply-To: <1298350326-15840-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-02-22 at 04:52 +0000, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8994.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
> index 4df047e..5f16870 100644
> --- a/sound/soc/codecs/wm8994.c
> +++ b/sound/soc/codecs/wm8994.c
> @@ -3012,11 +3012,10 @@ static void wm8958_default_micdet(u16 status, void *data)
>  		report |= SND_JACK_BTN_5;
>  
>  done:
> -	snd_soc_jack_report(wm8994->micdet[0].jack,
> +	snd_soc_jack_report(wm8994->micdet[0].jack, report,
>  			    SND_JACK_BTN_0 | SND_JACK_BTN_1 | SND_JACK_BTN_2 |
>  			    SND_JACK_BTN_3 | SND_JACK_BTN_4 | SND_JACK_BTN_5 |
> -			    SND_JACK_MICROPHONE | SND_JACK_VIDEOOUT,
> -			    report);
> +			    SND_JACK_MICROPHONE | SND_JACK_VIDEOOUT);
>  }
>  
>  /**

both

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
