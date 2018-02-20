From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: topology: Add missing clock
 gating parameter when parsing hw_configs
Date: Tue, 20 Feb 2018 18:07:20 +0100
Message-ID: <1266ac89-cedc-24d9-3899-0aca4e0e05fa@gmail.com>
References: <20180219060531.17276-1-k.marinushkin@gmail.com>
 <20180219060531.17276-2-k.marinushkin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
 [209.85.128.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C0D1266F0D
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 18:07:08 +0100 (CET)
Received: by mail-wr0-f194.google.com with SMTP id p104so15106272wrc.12
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 09:07:08 -0800 (PST)
In-Reply-To: <20180219060531.17276-2-k.marinushkin@gmail.com>
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
To: linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/19/18 07:05, Kirill Marinushkin wrote:
> Clock gating parameter is a part of `dai_fmt`. It is supported by
> `alsa-lib` when creating a topology binary file, but ignored by kernel
> when loading this topology file.
>
> After applying this commit, the clock gating parameter is not ignored any
> more. The old behaviour is not broken, as by default the parameter value
> is 0.
>
> For example, the following config, based on
> alsa-lib/src/conf/topology/broadwell/broadwell.conf, is now supported:
>
> ~~~~
> SectionHWConfig."CodecHWConfig" {
>         id "1"
>         format "I2S"            # physical audio format.
>         bclk   "master"         # Platform is master of bit clock
>         fsync  "master"         # platform is master of fsync
>         pm_cont_clock "true"    # clock is continuous, and can not be gated
> }
>
> SectionLink."Codec" {
>
>         # used for binding to the physical link
>         id "0"
>
>         hw_configs [
>                 "CodecHWConfig"
>         ]
>
>         default_hw_conf_id "1"
> }
> ~~~~
>
> Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: alsa-devel@alsa-project.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  sound/soc/soc-topology.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
> index 01a50413c66f..21bd4f96348d 100644
> --- a/sound/soc/soc-topology.c
> +++ b/sound/soc/soc-topology.c
> @@ -1981,6 +1981,12 @@ static void set_link_hw_format(struct snd_soc_dai_link *link,
>  
>  		link->dai_fmt = hw_config->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
>  
> +		/* clock gating */
> +		if (hw_config->clock_cont)
> +			link->dai_fmt |= SND_SOC_DAIFMT_CONT;
> +		else
> +			link->dai_fmt |= SND_SOC_DAIFMT_GATED;
> +
>  		/* clock signal polarity */
>  		invert_bclk = hw_config->invert_bclk;
>  		invert_fsync = hw_config->invert_fsync;

This patch is outdated. Patch v2 is sent in a different thread to replace it.

Best Regards,
Kirill
