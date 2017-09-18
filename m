From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/7] ASoC: Intel: cht_bsw_max98090: add
 support for Baytrail
Date: Mon, 18 Sep 2017 10:17:33 +0300
Message-ID: <1505719053.25945.269.camel@linux.intel.com>
References: <20170908051309.19028-1-pierre-louis.bossart@linux.intel.com>
 <20170908051309.19028-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id AF4012668F0
 for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2017 09:17:38 +0200 (CEST)
In-Reply-To: <20170908051309.19028-4-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, broonie@kernel.org, jarkko.nikula@linux.intel.com, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2017-09-08 at 00:13 -0500, Pierre-Louis Bossart wrote:
> Distributions such as Fedora, Ubuntu and Gallium don't currently
> have a means to support Baytrail Chromebooks and other platforms
> with the same build [1][2] due to incompatible platform drivers.
> 
> Add MCLK management to reuse this machine driver for Baytrail
> platforms and solve this coexistence problem at last. UCM files are
> provided at [3] and will eventually be submitted to the new repo.
> 
> The legacy byt-max98090 machine driver is still maintained but can
> only be used when the other Atom/DPCM driver is not compiled in, or
> when users don't want to configure extra mixers required by the
> Atom/sst driver.
> 
> Tested on Lenovo 100s Baytrail Chromebook w/ Mr. Chromebox BOOT_STUB
> firmware and Acer R11 Cherrytrail Chromebook
> 
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=1335196
> [2] http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/
> 111641.html
> [3] https://github.com/plbossart/UCM/tree/master/byt-max98090
> 
> 

>  
> +static inline struct snd_soc_dai *cht_get_codec_dai(struct
> snd_soc_card *card)
> +{
> +	struct snd_soc_pcm_runtime *rtd;
> +
> +	list_for_each_entry(rtd, &card->rtd_list, list) {
> +		if (!strncmp(rtd->codec_dai->name, CHT_CODEC_DAI,
> +			     strlen(CHT_CODEC_DAI)))

Same comments as per another patch series wrt str_n_cmp() use.

> +			return rtd->codec_dai;
> +	}
> +	return NULL;


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
