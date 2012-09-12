From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: core: Mark regmap CODEC register
 maps as dirty when suspending
Date: Wed, 12 Sep 2012 17:36:41 +0100
Message-ID: <1347467801.5312.0.camel@odin>
References: <1347423794-8606-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog108.obsmtp.com (na3sys009aog108.obsmtp.com
 [74.125.149.199])
 by alsa0.perex.cz (Postfix) with ESMTP id 63047261722
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 18:36:46 +0200 (CEST)
Received: by weyx10 with SMTP id x10so1021544wey.38
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 09:36:43 -0700 (PDT)
In-Reply-To: <1347423794-8606-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-09-12 at 12:23 +0800, Mark Brown wrote:
> The core has for a long time had support for marking the register maps of
> devices dirty when suspending so that they are resynced on resume. Also
> implement this feature for CODECs using regmap.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-core.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 0c7e477..b94ce32 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -635,6 +635,8 @@ int snd_soc_suspend(struct device *dev)
>  				codec->driver->suspend(codec);
>  				codec->suspended = 1;
>  				codec->cache_sync = 1;
> +				if (codec->using_regmap)
> +					regcache_mark_dirty(codec->control_data);
>  				break;
>  			default:
>  				dev_dbg(codec->dev, "CODEC is on over suspend\n");

Acked-by: Liam Girdwood <lrg@ti.com>
