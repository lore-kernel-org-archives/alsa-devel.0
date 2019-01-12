From: Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Date: Sat, 12 Jan 2019 11:37:06 +0530
Message-ID: <5C39840A.7040005@codeaurora.org>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 248CD266914
 for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2019 07:07:21 +0100 (CET)
In-Reply-To: <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, broonie@kernel.org, srinivas.kandagatla@linaro.org, asishb@codeaurora.org, Ajit Pandey <ajitp@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On 1/12/2019 3:19 AM, Pierre-Louis Bossart wrote:
>
>> Thanks for the overnight fix. This update fixes the issue on my 
>> Skylake XPS13 test device (blind testing since I don't understand 
>> what the code does).
>>
>> Tested-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>
> I need to take this back, this set of changes (initial+fix) causes an 
> error with our HDMI support
>
> [   17.437684] sof-audio sof-audio: created machine bxt-pcm512x
> [   17.585279] bxt-pcm512x bxt-pcm512x: ASoC: failed to init link iDisp1
> [   17.585639] bxt-pcm512x bxt-pcm512x: snd_soc_register_card failed -517
>
> Removing your changes restores the functionality
>
Looks like we should revert generic implementation for defering probe 
and move to call from machine driver as done in v1.
https://lore.kernel.org/patchwork/patch/1027560/
https://lore.kernel.org/patchwork/patch/1027561/

@Mark, Do you have suggestion to refine current patch?
> Adding some traces I can see that the the platform name we use doesn't 
> seem compatible with your logic. All the Intel boards used a constant 
> platform name matching the PCI ID, see e.g. [1], which IIRC is used to 
> bind components. Liam, do you recall in more details if this is really 
> required?
>
> [1] 
> https://elixir.bootlin.com/linux/latest/source/sound/soc/intel/boards/bxt_da7219_max98357a.c#L475
I think if it does not set platform name as 0000:00:0e.0, it should take 
snd-soc-dummy as platform name
and that might fix the issue.
snd-soc-dummy does have component associated with it.
https://elixir.bootlin.com/linux/latest/source/sound/soc/soc-utils.c#L281
>
> [   18.205812] plb: platform name sof-audio
> [   18.206059] plb: cpu_name (null)
> [   18.206234] plb: platform name 0000:00:0e.0
> [   18.206459] plb: returning -EPROBE_DEFER 1
> [   18.206686] bxt-pcm512x bxt-pcm512x: ASoC: failed to init link iDisp1
> [   18.207054] bxt-pcm512x bxt-pcm512x: snd_soc_register_card failed -517
>
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index cbafbdd02483..ae731212f82b 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1133,11 +1133,15 @@ static int soc_init_dai_link(struct 
> snd_soc_card *card,
>          * Defer card registration if platform dai component is not 
> added to
>          * component list.
>          */
> +       pr_err("plb: platform name %s\n", link->platform->name);
>         if (link->platform->of_node || link->platform->name)
>                 if (!soc_find_component(link->platform->of_node,
> link->platform->name))
> -                       return -EPROBE_DEFER;
> +                 {
> +                         pr_err("plb: returning -EPROBE_DEFER 1\n");
> +                         return -EPROBE_DEFER;
>
> +                 }
>         /*
>          * CPU device may be specified by either name or OF node, but
>          * can be left unspecified, and will be matched based on DAI
> @@ -1154,9 +1158,14 @@ static int soc_init_dai_link(struct 
> snd_soc_card *card,
>          * Defer card registration if cpu dai component is not added to
>          * component list.
>          */
> +       pr_err("plb: cpu_name %s\n", link->cpu_name);
>         if (link->cpu_of_node || link->cpu_name)
>                 if (!soc_find_component(link->cpu_of_node, 
> link->cpu_name))
> -                       return -EPROBE_DEFER;
> +                 {
> +                         pr_err("plb: returning -EPROBE_DEFER 2\n");
> +                         return -EPROBE_DEFER;
> +
> +                 }
>
>         /*
>          * At least one of CPU DAI name or CPU device name/node must be
>

Thanks,
Rohit
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
