From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH V2 00/10] ASoC: Intel: Skylake: Driver
	updates
Date: Tue, 14 Mar 2017 10:30:22 +0530
Message-ID: <20170314050022.GH2843@localhost>
References: <1489423292-19997-1-git-send-email-jeeja.kp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 45966266DD6
 for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2017 05:59:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1489423292-19997-1-git-send-email-jeeja.kp@intel.com>
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

On Mon, Mar 13, 2017 at 10:11:22PM +0530, jeeja.kp@intel.com wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
> 
> This patch series provides updates and fixes on the following:
>  Fix parameter overwrite for KPB DSP Module.
>  To handle module download with size > dma buffer size.
>  Fix to handle dsp pipes correctly.
>  Disable notification after dsp boot.
>  Remove get dsp_ops in cleanup routine.
>  Disable interrupt when DSP is in D3.
>  Update DSP core state in D0.
>  Reload the firmware in case of D3 failure.
> 
> Changes in v2:
> 	- fixed the typo's in commit message.
> 	- handle error in case when ipc fails in case of load module.

Thanks for updating these

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
