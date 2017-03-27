From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 00/11] ASoC: Intel: Skylake: More driver
 updates
Date: Mon, 27 Mar 2017 16:01:46 +0530
Message-ID: <20170327103145.GN9308@localhost>
References: <1490377234-30257-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id EB2BB26583C
 for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2017 12:30:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1490377234-30257-1-git-send-email-jeeja.kp@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jeeja.kp@intel.com
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 24, 2017 at 11:10:23PM +0530, jeeja.kp@intel.com wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
> 
> This patch series provides updates on the following:
>  o Fix LLCH register read.
>  o Add 16-bit constraint to FE bxt_rt298 machine.
>  o Fix DMA position reporting for capture stream.
>  o Use the sig_bits to define dai bps caps.
>  o Update sig_bits based on converter capability.
>  o Rearrangement of code to cleanup SKL SST library.
>  o Add support for deferred DSP module bind.
> 
> Changes in v2:
> 	- Addressed Pierre's comments for "Fix DMA position reporting
> 	  for capture stream" patch.
> 
> B, Jayachandran (1):
>   ALSA: hda: Fix LLCH register read
> 
> G Kranthi (1):
>   ASoC: Intel: Skylake: Add 16-bit constraint to FE bxt_rt298 machine
> 
> Hardik T Shah (1):
>   ASoC: Intel: Skylake: Fix DMA position reporting for capture stream
> 
> Jeeja KP (5):
>   ASoC: Intel: Skylake: Use the sig_bits to define dai bps capability
>   ASoC: hdac_hdmi: Update sig_bits based on converter capability
>   ASoC: Intel: Skylake: Rearrangement of code to cleanup SKL SST library
>   ASoC: Intel: Skylake: Fix module state after unbind and delete
>   ASoC: Intel: Skylake: Add support for deferred DSP module bind

All these:

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
