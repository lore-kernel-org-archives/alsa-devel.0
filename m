From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 2/2] ASoC: dapm: harden use of lookup
 tables
Date: Mon, 4 Feb 2019 14:58:53 -0600
Message-ID: <96e3f1d6-0cbf-089a-5f8f-33686ec137d8@linux.intel.com>
References: <20190204202710.14547-1-pierre-louis.bossart@linux.intel.com>
 <20190204202710.14547-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id B466F267459
 for <alsa-devel@alsa-project.org>; Mon,  4 Feb 2019 21:58:56 +0100 (CET)
In-Reply-To: <20190204202710.14547-2-pierre-louis.bossart@linux.intel.com>
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
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org


On 2/4/19 2:27 PM, Pierre-Louis Bossart wrote:
> Add warnings when
> a) the table size isn't aligned with the enum list
> b) the values are not initialized. This requires an increase by one of all
> values to avoid the default 0.
>
> Suggested-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   include/sound/soc-dapm.h |   3 +
>   sound/soc/soc-dapm.c     | 163 +++++++++++++++++++++------------------
>   2 files changed, 90 insertions(+), 76 deletions(-)
>
> diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
> index 79b4ddfb8e9e..82de75b4de87 100644
> --- a/include/sound/soc-dapm.h
> +++ b/include/sound/soc-dapm.h
> @@ -523,6 +523,9 @@ enum snd_soc_dapm_type {
>   	snd_soc_dapm_asrc,		/* DSP/CODEC ASRC component */
>   	snd_soc_dapm_encoder,		/* FW/SW audio encoder component */
>   	snd_soc_dapm_decoder,		/* FW/SW audio decoder component */
> +
> +	/* Don't forget to change the following: */
> +	SND_SOC_DAPM_TYPE_LAST = snd_soc_dapm_decoder
>   };

And of course I sent the wrong version by forgetting to re-run git 
format-patch. This is just wrong with an off-by-one error. will send a 
correction, sorry for the noise.
