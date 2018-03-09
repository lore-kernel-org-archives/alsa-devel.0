From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 3/3] ASoC: Add Multi CPU DAI support in DAPM
Date: Fri, 9 Mar 2018 16:31:24 +0000
Message-ID: <20180309163124.5vxiponvnubxnez2@localhost.localdomain>
References: <1520334030-8018-1-git-send-email-shreyas.nc@intel.com>
 <1520334030-8018-4-git-send-email-shreyas.nc@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 94E8E267442
 for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2018 17:31:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1520334030-8018-4-git-send-email-shreyas.nc@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shreyas NC <shreyas.nc@intel.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, kuninori.morimoto.gx@renesas.com, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 06, 2018 at 04:30:30PM +0530, Shreyas NC wrote:
> Extend the multi CPU support in DAPM functions to check for
> valid widgets and connected widgets.
> 
> Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> ---
>  sound/soc/soc-dapm.c | 71 ++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 46 insertions(+), 25 deletions(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 2f34590..6c7b0f4 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -4066,38 +4066,57 @@ int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card)
>  	return 0;
>  }
>  
> -static void dapm_connect_dai_link_widgets(struct snd_soc_card *card,
> -					  struct snd_soc_pcm_runtime *rtd)
> +static void dapm_check_dai_valid_widget(struct snd_soc_card *card,
> +					struct snd_soc_pcm_runtime *rtd,
> +					struct snd_soc_dai *codec_dai,
> +					struct snd_soc_dai *cpu_dai)

Not sure about the name here dapm_check_dai_valid_widget doesn't
sound like it should be adding paths, otherwise I think this one
looks ok.

Thanks,
Charles
