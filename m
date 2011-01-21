From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Staticise twl6040_hs_jack_report()
Date: Fri, 21 Jan 2011 16:46:38 +0000
Message-ID: <1295628398.3348.305.camel@odin>
References: <1295559824-3837-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A07D3103AF7
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 17:46:43 +0100 (CET)
Received: by eyg24 with SMTP id 24so949410eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 08:46:43 -0800 (PST)
In-Reply-To: <1295559824-3837-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Margarita Olaya Cabrera <magi.olaya@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>, patches@opensource.wolfsonmicro.com, Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-01-20 at 21:43 +0000, Mark Brown wrote:
> It's an internal function so shouldn't be exported (as sparse points
> out).
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/twl6040.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
> index 4bbf1b1..482fcdb 100644
> --- a/sound/soc/codecs/twl6040.c
> +++ b/sound/soc/codecs/twl6040.c
> @@ -724,8 +724,8 @@ static int twl6040_power_mode_event(struct snd_soc_dapm_widget *w,
>  	return 0;
>  }
>  
> -void twl6040_hs_jack_report(struct snd_soc_codec *codec,
> -				struct snd_soc_jack *jack, int report)
> +static void twl6040_hs_jack_report(struct snd_soc_codec *codec,
> +				   struct snd_soc_jack *jack, int report)
>  {
>  	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
>  	int status;

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
