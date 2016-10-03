From: Hardik Shah <hardik.t.shah@intel.com>
Subject: Re: [PATCH 5/7] ALSA: hda: add default value for
	max_inflight_bytes
Date: Mon, 3 Oct 2016 14:18:18 +0530
Message-ID: <20161003084817.GC9636@intel.com>
References: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
 <1475239410-16548-6-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 21B142667F5
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 10:47:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1475239410-16548-6-git-send-email-subhransu.s.prusty@intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 30, 2016 at 06:13:28PM +0530, Subhransu S. Prusty wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> set value to 128 bytes for legacy HDAudio, can be overridden
> as needed (on a per-stream basis) for enhanced hardware with
> more buffering capabilities
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> ---
>  sound/pci/hda/hda_controller.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
> index 2ad3b44..922d7b9 100644
> --- a/sound/pci/hda/hda_controller.c
> +++ b/sound/pci/hda/hda_controller.c
> @@ -587,6 +587,7 @@ static struct snd_pcm_hardware azx_pcm_hw = {
>  	.periods_min =		2,
>  	.periods_max =		AZX_MAX_FRAG,
>  	.fifo_size =		0,
> +	.max_inflight_bytes = 128 /* default value for all legacy HDAudio controllers, override as needed */

This line is going beyond 100 chars

>  };
>  
>  static int azx_pcm_open(struct snd_pcm_substream *substream)
> -- 
> 1.9.1
> 

-- 
