From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: topology: Fix bclk and fsync
 inversion in set_link_hw_format()
Date: Tue, 27 Mar 2018 13:16:35 -0500
Message-ID: <9c70c5fa-e210-373c-f840-3e82799864df@linux.intel.com>
References: <20180301064556.5387-1-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 7B918267063
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 20:16:38 +0200 (CEST)
In-Reply-To: <20180301064556.5387-1-k.marinushkin@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kirill Marinushkin <k.marinushkin@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Pan Xiuli <xiuli.pan@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



On 03/01/2018 12:45 AM, Kirill Marinushkin wrote:
> The values of bclk and fsync are inverted WRT the codec. But the existing
> solution already works for Broadwell, see the alsa-lib config:
>
> `alsa-lib/src/conf/topology/broadwell/broadwell.conf`
>
> This commit provides the backwards-compatible solution to fix this misuse.
> This commit goes in pair with the corresponding patch for alsa-lib.

kernel/ASoC patch:
Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>
> Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Pan Xiuli <xiuli.pan@linux.intel.com>
> Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> ---
>   include/uapi/sound/asoc.h | 16 ++++++++++++++--
>   sound/soc/soc-topology.c  | 12 +++++++-----
>   2 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
> index 69c37ecbff7e..f0e5e21efa54 100644
> --- a/include/uapi/sound/asoc.h
> +++ b/include/uapi/sound/asoc.h
> @@ -160,6 +160,18 @@
>   #define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 2)
>   #define SND_SOC_TPLG_LNK_FLGBIT_VOICE_WAKEUP            (1 << 3)
>   
> +/* DAI topology BCLK parameter
> + * For the backwards capability, by default codec is bclk master
> + */
> +#define SND_SOC_TPLG_BCLK_CM         0 /* codec is bclk master */
> +#define SND_SOC_TPLG_BCLK_CS         1 /* codec is bclk slave */
> +
> +/* DAI topology FSYNC parameter
> + * For the backwards capability, by default codec is fsync master
> + */
> +#define SND_SOC_TPLG_FSYNC_CM         0 /* codec is fsync master */
> +#define SND_SOC_TPLG_FSYNC_CS         1 /* codec is fsync slave */
> +
>   /*
>    * Block Header.
>    * This header precedes all object and object arrays below.
> @@ -315,8 +327,8 @@ struct snd_soc_tplg_hw_config {
>   	__u8 clock_gated;	/* 1 if clock can be gated to save power */
>   	__u8 invert_bclk;	/* 1 for inverted BCLK, 0 for normal */
>   	__u8 invert_fsync;	/* 1 for inverted frame clock, 0 for normal */
> -	__u8 bclk_master;	/* 1 for master of BCLK, 0 for slave */
> -	__u8 fsync_master;	/* 1 for master of FSYNC, 0 for slave */
> +	__u8 bclk_master;	/* SND_SOC_TPLG_BCLK_ value */
> +	__u8 fsync_master;	/* SND_SOC_TPLG_FSYNC_ value */
>   	__u8 mclk_direction;    /* 0 for input, 1 for output */
>   	__le16 reserved;	/* for 32bit alignment */
>   	__le32 mclk_rate;	/* MCLK or SYSCLK freqency in Hz */
> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
> index 01a50413c66f..c5bdc673b195 100644
> --- a/sound/soc/soc-topology.c
> +++ b/sound/soc/soc-topology.c
> @@ -1994,13 +1994,15 @@ static void set_link_hw_format(struct snd_soc_dai_link *link,
>   			link->dai_fmt |= SND_SOC_DAIFMT_IB_IF;
>   
>   		/* clock masters */
> -		bclk_master = hw_config->bclk_master;
> -		fsync_master = hw_config->fsync_master;
> -		if (!bclk_master && !fsync_master)
> +		bclk_master = (hw_config->bclk_master ==
> +			       SND_SOC_TPLG_BCLK_CM);
> +		fsync_master = (hw_config->fsync_master ==
> +				SND_SOC_TPLG_FSYNC_CM);
> +		if (bclk_master && fsync_master)
>   			link->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
> -		else if (bclk_master && !fsync_master)
> -			link->dai_fmt |= SND_SOC_DAIFMT_CBS_CFM;
>   		else if (!bclk_master && fsync_master)
> +			link->dai_fmt |= SND_SOC_DAIFMT_CBS_CFM;
> +		else if (bclk_master && !fsync_master)
>   			link->dai_fmt |= SND_SOC_DAIFMT_CBM_CFS;
>   		else
>   			link->dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
