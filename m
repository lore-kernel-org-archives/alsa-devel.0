From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/7] ASoC: wm_adsp: Put DSP into low power
 state between loading and running
Date: Wed, 21 Sep 2016 17:14:01 +0100
Message-ID: <20160921161401.GV21682@localhost.localdomain>
References: <1474375956-10443-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1474375956-10443-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 445B32666EB
 for <alsa-devel@alsa-project.org>; Wed, 21 Sep 2016 18:13:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1474375956-10443-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 20, 2016 at 01:52:34PM +0100, Charles Keepax wrote:
> Between when we load the DSP and when it actually starts running put the
> core into a lower power state where the memory is retained but nothing
> is clocked.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
> @@ -2344,6 +2355,11 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
>  		if (!dsp->booted)
>  			return -EIO;
>  
> +		ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
> +					 ADSP2_SYS_ENA, ADSP2_SYS_ENA);
> +		if (ret != 0)
> +			goto err;
> +

We actually need to wait for RAM_RDY again here, I will fire out
a new version of the patches in the next day or two.

Thanks,
Charles
