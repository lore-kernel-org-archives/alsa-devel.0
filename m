From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: core: Support suspend to disk
Date: Tue, 31 Jan 2012 15:40:50 +0000
Message-ID: <1328024450.4978.0.camel@odin>
References: <1328023854-10981-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog121.obsmtp.com (na3sys009aog121.obsmtp.com
	[74.125.149.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A05B103AD4
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 16:40:56 +0100 (CET)
Received: by mail-we0-f169.google.com with SMTP id a13so163397wer.0
	for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2012 07:40:54 -0800 (PST)
In-Reply-To: <1328023854-10981-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Tue, 2012-01-31 at 15:30 +0000, Mark Brown wrote:
> Use the same pm_ops for all system suspend and resume paths. This isn't
> ideal for suspend to disk with older CODECs as we'll suspend and then
> resume the CODEC before powering off all of which takes a long time due
> to VMID ramps but it's very simple to implement and for modern CODECs the
> overhead should be minimal.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-core.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index e25d69c..53fd9d2 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1663,8 +1663,7 @@ int snd_soc_poweroff(struct device *dev)
>  EXPORT_SYMBOL_GPL(snd_soc_poweroff);
>  
>  const struct dev_pm_ops snd_soc_pm_ops = {
> -	.suspend = snd_soc_suspend,
> -	.resume = snd_soc_resume,
> +	SET_SYSTEM_SLEEP_PM_OPS(snd_soc_suspend, snd_soc_resume)
>  	.poweroff = snd_soc_poweroff,
>  };
>  EXPORT_SYMBOL_GPL(snd_soc_pm_ops);

Acked-by: Liam Girdwood <lrg@ti.com>
