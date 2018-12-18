From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Haswell/Broadwell: fix
 setting for .dynamic field
Date: Tue, 18 Dec 2018 08:03:04 -0600
Message-ID: <f5fa4780-9cd5-b913-8d8f-bfb5cf45b2b1@linux.intel.com>
References: <20181218082454.49373-1-rander.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B42BB2677C8
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 15:03:06 +0100 (CET)
In-Reply-To: <20181218082454.49373-1-rander.wang@linux.intel.com>
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
To: Rander Wang <rander.wang@linux.intel.com>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 12/18/18 2:24 AM, Rander Wang wrote:
> For some reason this field was set to zero when all other drivers use
> .dynamic = 1 for front-ends. This change was tested on Dell XPS13 and
> has no impact with the existing legacy driver. The SOF driver also works
> with this change which enables it to override the fixed topology.
>
> Signed-off-by: Rander Wang <rander.wang@linux.intel.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Note that this change is not needed for the bdw-rt5677 machine driver, 
the "Loopback" front-end is not exposed.

> ---
>   sound/soc/intel/boards/broadwell.c | 2 +-
>   sound/soc/intel/boards/haswell.c   | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
> index 68e6543e6cb0..99f2a0156ae8 100644
> --- a/sound/soc/intel/boards/broadwell.c
> +++ b/sound/soc/intel/boards/broadwell.c
> @@ -192,7 +192,7 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
>   		.stream_name = "Loopback",
>   		.cpu_dai_name = "Loopback Pin",
>   		.platform_name = "haswell-pcm-audio",
> -		.dynamic = 0,
> +		.dynamic = 1,
>   		.codec_name = "snd-soc-dummy",
>   		.codec_dai_name = "snd-soc-dummy-dai",
>   		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
> diff --git a/sound/soc/intel/boards/haswell.c b/sound/soc/intel/boards/haswell.c
> index eab1f439dd3f..a4022983a7ce 100644
> --- a/sound/soc/intel/boards/haswell.c
> +++ b/sound/soc/intel/boards/haswell.c
> @@ -146,7 +146,7 @@ static struct snd_soc_dai_link haswell_rt5640_dais[] = {
>   		.stream_name = "Loopback",
>   		.cpu_dai_name = "Loopback Pin",
>   		.platform_name = "haswell-pcm-audio",
> -		.dynamic = 0,
> +		.dynamic = 1,
>   		.codec_name = "snd-soc-dummy",
>   		.codec_dai_name = "snd-soc-dummy-dai",
>   		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
