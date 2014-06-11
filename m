From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: wm_adsp: Move DVFS control into
	codec driver
Date: Wed, 11 Jun 2014 11:54:25 +0100
Message-ID: <20140611105425.GA12074@opensource.wolfsonmicro.com>
References: <20140609150013.GA5229@opensource.wolfsonmicro.com>
 <20140609150314.GC5229@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BC3BA265278
 for <alsa-devel@alsa-project.org>; Wed, 11 Jun 2014 12:54:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140609150314.GC5229@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, tiwai@suse.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, broonie@kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 09, 2014 at 04:03:14PM +0100, Richard Fitzgerald wrote:
>  
> -#define WM_ADSP2(wname, num) \
> +#define WM_ADSP2_E(wname, num, event_fn) \
>  {	.id = snd_soc_dapm_dai_link, .name = wname " Preloader", \
> -	.reg = SND_SOC_NOPM, .shift = num, .event = wm_adsp2_early_event, \
> +	.reg = SND_SOC_NOPM, .shift = num, .event = event_fn, \
>  	.event_flags = SND_SOC_DAPM_PRE_PMU }, \

You need to add a SND_SOC_DAPM_PRE_PMD in here otherwise your
wm5102_sysclk_ev won't get called on power down.

Thanks,
Charles
