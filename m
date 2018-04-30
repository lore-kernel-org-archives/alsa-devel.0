From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v3 3/3] ASoC: Add Multi CPU DAI support in
 DAPM
Date: Mon, 30 Apr 2018 17:24:56 +0100
Message-ID: <20180430162456.34232lvulubgp5ky@localhost.localdomain>
References: <1524131359-24387-1-git-send-email-vinod.koul@intel.com>
 <1524131359-24387-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id B01EC26732A
 for <alsa-devel@alsa-project.org>; Mon, 30 Apr 2018 18:25:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1524131359-24387-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 19, 2018 at 03:19:19PM +0530, Vinod Koul wrote:
> From: Shreyas NC <shreyas.nc@intel.com>
> 
> Extend the multi CPU support in DAPM functions to check for
> valid widgets and connected widgets.
> 
> Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
> +static void dapm_add_valid_dai_widget(struct snd_soc_card *card,
> +					struct snd_soc_pcm_runtime *rtd,
> +					struct snd_soc_dai *codec_dai,
> +					struct snd_soc_dai *cpu_dai)

This function name still feels a little funny since the function
doesn't add any widgets. It adds paths if there are valid
widgets. Perhaps dapm_add_valid_dai_path?

But I don't feel super strongly about it, so:

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
