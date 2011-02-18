From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Remove export of
 snd_soc_dapm_stream_event()
Date: Fri, 18 Feb 2011 09:17:46 +0000
Message-ID: <1298020666.9630.1.camel@odin>
References: <1297914601-19863-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 8CA68243FA
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 10:17:51 +0100 (CET)
Received: by wyi11 with SMTP id 11so3388764wyi.38
	for <alsa-devel@alsa-project.org>; Fri, 18 Feb 2011 01:17:50 -0800 (PST)
In-Reply-To: <1297914601-19863-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Wed, 2011-02-16 at 19:50 -0800, Mark Brown wrote:
> The only thing that should ever be calling this is soc-core and that is
> built as part of the same module so doesn't need the export.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-dapm.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 1bd24d5..3bee4b2 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -2263,7 +2263,6 @@ int snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime *rtd,
>  	mutex_unlock(&codec->mutex);
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(snd_soc_dapm_stream_event);
>  
>  /**
>   * snd_soc_dapm_enable_pin - enable pin.

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
