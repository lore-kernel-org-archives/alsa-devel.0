From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH v3 2/2] ASoC: soc-compress: split
 soc-compress to a module
Date: Tue, 13 Oct 2015 11:49:56 +0000
Message-ID: <1444736994.2926.9.camel@intel.com>
References: <1444727464-10385-1-git-send-email-yang.jie@intel.com>
 <1444727464-10385-3-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A70972617C1
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 13:50:02 +0200 (CEST)
In-Reply-To: <1444727464-10385-3-git-send-email-yang.jie@intel.com>
Content-Language: en-US
Content-ID: <E9B37DD7D6860C499D756349BC32B88F@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jie, Yang" <yang.jie@intel.com>, "broonie@kernel.org" <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-10-13 at 17:11 +0800, Jie Yang wrote:
> +/* Module information */
> +MODULE_AUTHOR("Namarta Kohli <namartax.kohli@intel.com>");
> +MODULE_AUTHOR("Ramesh Babu K V <ramesh.babu@linux.intel.com>");
> +MODULE_AUTHOR("Vinod Koul <vinod.koul@linux.intel.com>");

Vinod Koul <vinod.koul@intel.com> please

I need to move other instances too :(


> +MODULE_DESCRIPTION("ALSA SoC Compress");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:soc-compress");
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index ff8bda4..9e32151 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -3896,6 +3896,7 @@ void snd_soc_dapm_stream_event(struct snd_soc_pcm_runtime
> *rtd, int stream,
>  	soc_dapm_stream_event(rtd, stream, event);
>  	mutex_unlock(&card->dapm_mutex);
>  }
> +EXPORT_SYMBOL_GPL(snd_soc_dapm_stream_event);

These exports should be a new patch

And as we agreed this should have Documentation if not already done :)

-- 
~Vinod
