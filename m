From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: topology: Reenable use from userspace
Date: Mon, 26 Oct 2015 03:54:32 +0000
Message-ID: <1445831672.5321.18.camel@intel.com>
References: <1445830900-1752-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CBFF0260471
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 04:55:38 +0100 (CET)
In-Reply-To: <1445830900-1752-1-git-send-email-broonie@kernel.org>
Content-Language: en-US
Content-ID: <4910A2F4FEBF9542A6B6586696A8A437@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2015-10-26 at 12:41 +0900, Mark Brown wrote:
> We had inserted a #error into the topology UAPI code to ensure that the
> ABI was not adopted by userspace while final review and testing was
> ongoing.  Since we are now comfortable that the ABI is suitable for
> production remove the #error, future changes will include provision for
> backwards compatibility.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Vinod Koul <vinod.koul@intel.com>

I don't have any local patches on topology core, so am okay with this.

Liam, Mengdong do we have any more patches looking to be merged? I do see we have the
series we required in topic/topology, but is anything left out?

-- 
~Vinod

> ---
> 
> Are we OK with this?  Looking for some acks and reviews...
> 
>  include/uapi/sound/asoc.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
> index 247c50b..51b8066 100644
> --- a/include/uapi/sound/asoc.h
> +++ b/include/uapi/sound/asoc.h
> @@ -18,12 +18,6 @@
>  #include <linux/types.h>
>  #include <sound/asound.h>
>  
> -#ifndef __KERNEL__
> -#error This API is an early revision and not enabled in the current
> -#error kernel release, it will be enabled in a future kernel version
> -#error with incompatible changes to what is here.
> -#endif
> -
>  /*
>   * Maximum number of channels topology kcontrol can represent.
>   */ 
