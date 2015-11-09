From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH] topology: Include <linux/types.h> in API
	header file
Date: Mon, 9 Nov 2015 19:34:29 +0530
Message-ID: <20151109140425.GA5572@subhransu-desktop>
References: <1446813576-29295-1-git-send-email-mengdong.lin@linux.intel.com>
 <s5hoaf7z3k2.wl-tiwai@suse.de> <20151106133118.GA18120@localhost>
 <s5hfv0jz200.wl-tiwai@suse.de> <1446820647.2776.19.camel@loki>
 <s5h4mgzyyve.wl-tiwai@suse.de> <1446821837.2776.27.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C090260527
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 09:32:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1446821837.2776.27.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com, Takashi Iwai <tiwai@suse.de>, mengdong.lin@intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 06, 2015 at 02:57:17PM +0000, Liam Girdwood wrote:
> On Fri, 2015-11-06 at 15:40 +0100, Takashi Iwai wrote:
> > On Fri, 06 Nov 2015 15:37:27 +0100,
> > Liam Girdwood wrote:
> > > 
> > > 
> > > >From 568f769269122e90fceee605a98a1a526db2b3d4 Mon Sep 17 00:00:00 2001
> > > From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> > > Date: Fri, 6 Nov 2015 14:30:36 +0000
> > > Subject: [PATCH] topology: remove little endian type from userspace header.
> > > 
> > > Use a generic unsigned long long for formats instead of an ABI endian
> > > specific __le64 type.
> > 
> > Or use uint64_t instead.  This is the standard definition of 64bit
> > integer.  I thought we already include stdint.h somewhere, but you can
> > included it there again to be sure, too.
> > 
> 
> I didn't see stdint.h so used unsigned long long on the first patch. The
> patch below fixes this though :-
> 
> From 52d3023e482ac856692bf27819d97d9a037a055b Mon Sep 17 00:00:00 2001
> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Date: Fri, 6 Nov 2015 14:30:36 +0000
> Subject: [PATCH] topology: remove little endian type from userspace header.
> 
> Use a generic uint64_t for formats instead of an ABI endian specific
> __le64 type.

Tested and it works fine.

> 
> Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> ---
>  include/topology.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/topology.h b/include/topology.h
> index b631871..993537c 100644
> --- a/include/topology.h
> +++ b/include/topology.h
> @@ -21,6 +21,8 @@
>  #ifndef __ALSA_TOPOLOGY_H
>  #define __ALSA_TOPOLOGY_H
>  
> +#include <stdint.h>
> +
>  #ifdef __cplusplus
>  extern "C" {
>  #endif
> @@ -665,7 +667,7 @@ struct snd_tplg_stream_template {
>   */
>  struct snd_tplg_stream_caps_template {
>  	const char *name;	/*!< name of the stream caps */
> -	__le64 formats;	/*!< supported formats SNDRV_PCM_FMTBIT_* */
> +	uint64_t formats;	/*!< supported formats SNDRV_PCM_FMTBIT_* */
>  	unsigned int rates;	/*!< supported rates SNDRV_PCM_RATE_* */
>  	unsigned int rate_min;	/*!< min rate */
>  	unsigned int rate_max;	/*!< max rate */
> -- 
> 2.5.0
> 
> 

-- 
