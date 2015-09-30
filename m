From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 0/8] ASoC: topology: ABI - Add support for
 PCM, BE & CC link
Date: Wed, 30 Sep 2015 09:23:37 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F84A09BB5C@SHSMSX101.ccr.corp.intel.com>
References: <cover.1443602494.git.mengdong.lin@intel.com>
 <cover.1443602494.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 91DAF265A8C
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 11:23:42 +0200 (CEST)
In-Reply-To: <cover.1443602494.git.mengdong.lin@intel.com>
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>, "Patel, Vedang" <vedang.patel@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>, "Kp, Jeeja" <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

Sorry, please overlook this version and see v2.

I sent some v1 patches twice by mistake. This seems to broke the v1 thread. So I sent v2.

Regards
Mengdong

> -----Original Message-----
> From: Lin, Mengdong
> Sent: Wednesday, September 30, 2015 5:03 PM
> To: alsa-devel@alsa-project.org; broonie@kernel.org; tiwai@suse.de;
> Girdwood, Liam R; Patel, Vedang; Prusty, Subhransu S; Koul, Vinod; Kp, Jeeja
> Cc: Lin, Mengdong
> Subject: [PATCH 0/8] ASoC: topology: ABI - Add support for PCM, BE & CC
> link
> 
> From: Mengdong Lin <mengdong.lin@intel.com>
> 
> This series includes topology ABI update to support PCM (FE DAI/DAI links),
> BE and CC DAI links. Bump the ABI version to 4.
> 
> Mengdong Lin (2):
>   ASoC: topology: ABI - Change stream formats to a bitwise flag
>   ASoC: topology: ABI - Remove tdm_slot & dai_fmt from
>     snd_soc_tplg_stream
> 
> Vedang Patel (6):
>   ASoC: topology: ABI - Add PCM Support and bump ABI version to 4
>   ASoC: topology: ABI - Remove unused struct snd_soc_tplg_stream_config
>   ASoC: topology: ABI - Use __le32 instead of __u32 in
>     snd_soc_tplg_dapm_widget
>   ASoC: topology: ABI - Add name element to snd_soc_tplg_stream
>   ASoC: topology: ABI - Add the type for BE DAI link
>   ASoC: topology: ABI - Add configuration for BE & Codec-Codec DAI Links
> 
>  include/uapi/sound/asoc.h | 76
> +++++++++++++++++++++++++----------------------
>  sound/soc/soc-topology.c  |  4 +--
>  2 files changed, 43 insertions(+), 37 deletions(-)
> 
> --
> 1.9.1
