From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: ep93xx-ac97: remove extra empty line
Date: Fri, 04 Feb 2011 13:18:17 +0000
Message-ID: <1296825497.3360.69.camel@odin>
References: <1296814975-15121-1-git-send-email-mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F470103B0C
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2011 14:18:20 +0100 (CET)
Received: by mail-wy0-f179.google.com with SMTP id 11so2202098wyi.38
	for <alsa-devel@alsa-project.org>; Fri, 04 Feb 2011 05:18:20 -0800 (PST)
In-Reply-To: <1296814975-15121-1-git-send-email-mika.westerberg@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-02-04 at 12:22 +0200, Mika Westerberg wrote:
> Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> ---
>  sound/soc/ep93xx/ep93xx-ac97.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/ep93xx/ep93xx-ac97.c b/sound/soc/ep93xx/ep93xx-ac97.c
> index 68a0bae..104e95c 100644
> --- a/sound/soc/ep93xx/ep93xx-ac97.c
> +++ b/sound/soc/ep93xx/ep93xx-ac97.c
> @@ -253,7 +253,6 @@ static int ep93xx_ac97_trigger(struct snd_pcm_substream *substream,
>  	struct ep93xx_ac97_info *info = snd_soc_dai_get_drvdata(dai);
>  	unsigned v = 0;
>  
> -
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_START:
>  	case SNDRV_PCM_TRIGGER_RESUME:


Acked-by: liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
