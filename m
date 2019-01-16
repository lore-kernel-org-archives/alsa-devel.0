From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/2] ASoC: soc-core: use
 snd_soc_dai_link_component for cpu
Date: Wed, 16 Jan 2019 09:08:19 -0600
Message-ID: <3b1f5c02-65e1-b43e-3556-129d48c2375d@linux.intel.com>
References: <87bm4hm30t.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 0003E266AA9
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2019 16:08:31 +0100 (CET)
In-Reply-To: <87bm4hm30t.wl-kuninori.morimoto.gx@renesas.com>
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
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On 1/16/19 2:26 AM, Kuninori Morimoto wrote:
> Hi Mark
>
> These add snd_soc_dai_link_component support for CPU.
> I know multi-CPU support patch was posted to ML,
> but I think it is not yet accepted (or rejected ?).
If you are referring to the Intel patches, they were really too 
intrusive and complicated. Quite frankly I don't think anyone at Intel 
(me included) understands what is "legacy" and what is "modern", so 
adding multiple cpu support in there was really guesswork and 
copy/replace of the multi-codec parts, likely to break and impossible to 
test.
>
> If these patches were accepted, we can finally switch to
> modern style dai_link, and remove legacy style dai_link.

it might be a better idea to remove the legacy first so that we have a 
clean slate to add multiple CPUs?

If you have a blurb or description of the end-goal and what evolutions 
are required for dai links, it'd be really nice. Following incremental 
patches over multiple kernel versions isn't straightforward and the 
impacts of your changes isn't clear to me, e.g. I'd really like to know 
if the current way Intel uses dailinks needs to be changed or if we are 
good.

Thanks

-Pierre

>
> Kuninori Morimoto (2):
>    ASoC: soc-core: add .num_platform for dai_link
>    ASoC: soc-core: use snd_soc_dai_link_component for cpu
>
> For switching to modern, I added "use modern style dai_link"
> and "remove legacy style dai_link" patches as sample.
> If these have no objection, I will post full patch to ML.
>
> Kuninori Morimoto (3):
>        ASoC: audio-graph/simple-card: use modern style dai_link for CPU
>        ASoC: atmel: atmel-classd: use modern style dai_link
>        ASoC: soc-core: remove regacy dai_link binding method
>
> ---
> Kuninori Morimoto
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
