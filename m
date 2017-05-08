From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 2/2] ASoC: Intel: Skylake: Fix typo for
	token d0i3 caps
Date: Mon, 8 May 2017 10:32:09 +0530
Message-ID: <20170508050209.GP6263@localhost>
References: <1493887151-508-1-git-send-email-subhransu.s.prusty@intel.com>
 <1493887151-508-2-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 086C7266483
 for <alsa-devel@alsa-project.org>; Mon,  8 May 2017 07:00:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1493887151-508-2-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, May 04, 2017 at 02:09:11PM +0530, Subhransu S. Prusty wrote:
> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>

Acked-by: Vinod Koul <vinod.koul@intel.com>

> ---
> v1->v2
>    - Fixed as suggested by Takashi Sakamoto
> 
>  include/uapi/sound/snd_sst_tokens.h    | 5 +++--
>  sound/soc/intel/skylake/skl-topology.c | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/sound/snd_sst_tokens.h b/include/uapi/sound/snd_sst_tokens.h
> index 93392bedcc58..89b82f6256ad 100644
> --- a/include/uapi/sound/snd_sst_tokens.h
> +++ b/include/uapi/sound/snd_sst_tokens.h
> @@ -213,8 +213,9 @@ enum SKL_TKNS {
>  	SKL_TKN_U32_LIB_COUNT,
>  	SKL_TKN_STR_LIB_NAME,
>  	SKL_TKN_U32_PMODE,
> -	SKL_TKL_U32_D0I3_CAPS,
> -	SKL_TKN_MAX = SKL_TKL_U32_D0I3_CAPS,
> +	SKL_TKL_U32_D0I3_CAPS, /* Typo added at v4.10 */
> +	SKL_TKN_U32_D0I3_CAPS = SKL_TKL_U32_D0I3_CAPS,
> +	SKL_TKN_MAX = SKL_TKN_U32_D0I3_CAPS,
>  };
>  
>  #endif
> diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
> index 3a99712e44a8..b28199a5348c 100644
> --- a/sound/soc/intel/skylake/skl-topology.c
> +++ b/sound/soc/intel/skylake/skl-topology.c
> @@ -1995,7 +1995,7 @@ static int skl_tplg_get_token(struct device *dev,
>  		mconfig->converter = tkn_elem->value;
>  		break;
>  
> -	case SKL_TKL_U32_D0I3_CAPS:
> +	case SKL_TKN_U32_D0I3_CAPS:
>  		mconfig->d0i3_caps = tkn_elem->value;
>  		break;
>  
> -- 
> 1.9.1
> 

-- 
~Vinod
