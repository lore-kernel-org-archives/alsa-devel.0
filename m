From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 5/5] ASoC: Intel: add BYTCR machine
 driver with RT5640
Date: Tue, 04 Nov 2014 11:19:10 +0200
Message-ID: <54589A0E.5040301@linux.intel.com>
References: <1415079068-4979-1-git-send-email-vinod.koul@intel.com>
 <1415079068-4979-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A0C8B2605F2
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 10:19:14 +0100 (CET)
In-Reply-To: <1415079068-4979-6-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 11/04/2014 07:31 AM, Vinod Koul wrote:
> From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
>
> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>   sound/soc/intel/Kconfig             |   12 ++
>   sound/soc/intel/Makefile            |    2 +
>   sound/soc/intel/bytcr_dpcm_rt5640.c |  258 +++++++++++++++++++++++++++++++++++
>   3 files changed, 272 insertions(+), 0 deletions(-)
>   create mode 100644 sound/soc/intel/bytcr_dpcm_rt5640.c
>
...
> +static const struct snd_kcontrol_new byt_mc_controls[] = {
> +	SOC_DAPM_PIN_SWITCH("Headphone"),
> +	SOC_DAPM_PIN_SWITCH("Headset Mic"),
> +	SOC_DAPM_PIN_SWITCH("Int Mic"),
> +	SOC_DAPM_PIN_SWITCH("Ext Spk"),
> +};
...
> +static struct snd_soc_dai_link byt_dailink[] = {
> +	[MERR_DPCM_AUDIO] = {
> +		.name = "Baytrail Audio Port",
> +		.stream_name = "Baytrail Audio",
>
...
> +/* SoC card */
> +static struct snd_soc_card snd_soc_card_byt = {
> +	.name = "baytrailcraudio",
>
I think it's worth to have same kcontrol and card names than byt-rt5640 
in case this is going to replace byt-rt5640.c since then users can 
continue to use the same asound.state file. E.g. speakers won't mute 
because of "Speaker" changes to "Ext Spk".

-- 
Jarkko
