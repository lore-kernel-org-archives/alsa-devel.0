From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/3] ALSA: hda - Improved position
 reporting on SKL+
Date: Mon, 3 Apr 2017 08:28:38 +0530
Message-ID: <20170403025838.GE2846@localhost>
References: <20170331084930.813-1-tiwai@suse.de>
 <20170331084930.813-4-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id A4CBA266AE1
 for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2017 04:57:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170331084930.813-4-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Rakesh A Ughreja <rakesh.a.ughreja@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 31, 2017 at 10:49:30AM +0200, Takashi Iwai wrote:
> Apply the same methods to obtain the current stream position as ASoC
> Intel SKL driver uses.  It reads the position from DPIB for a playback
> stream while it still reads from the position buffer for a capture
> stream.  For a capture stream, some ugly workaround is needed to
> settle down the inconsistent position.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/hda_intel.c | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index a48330f4a1a9..64db6698214c 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -77,6 +77,7 @@ enum {
>  	POS_FIX_POSBUF,
>  	POS_FIX_VIACOMBO,
>  	POS_FIX_COMBO,
> +	POS_FIX_SKL,
>  };
>  
>  /* Defines for ATI HD Audio support in SB450 south bridge */
> @@ -148,7 +149,7 @@ module_param_array(model, charp, NULL, 0444);
>  MODULE_PARM_DESC(model, "Use the given board model.");
>  module_param_array(position_fix, int, NULL, 0444);
>  MODULE_PARM_DESC(position_fix, "DMA pointer read method."
> -		 "(-1 = system default, 0 = auto, 1 = LPIB, 2 = POSBUF, 3 = VIACOMBO, 4 = COMBO).");
> +		 "(-1 = system default, 0 = auto, 1 = LPIB, 2 = POSBUF, 3 = VIACOMBO, 4 = COMBO, 5 = SKL+).");

do we have people use this module param, or is it find what works for
them...

-- 
~Vinod
