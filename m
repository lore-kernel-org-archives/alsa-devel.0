From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH RESEND 0/2] ASoC: Intel: kbl: update dmic
	fixup params
Date: Fri, 17 Nov 2017 09:05:20 +0530
Message-ID: <20171117033519.GH3187@localhost>
References: <1510740463-21655-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id CBAE52677BD
 for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2017 04:32:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1510740463-21655-1-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Naveen Manohar <naveen.m@intel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, subhransu.s.prusty@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 15, 2017 at 03:37:41PM +0530, Naveen Manohar wrote:
> Hi Mark,
> 
> These are resend of an already acked patch series.
> I posted it a week ago but there has been update on the base branch.
> I want to resend these. Kindly review and merge.
> 
> Update dmic fixup params to always expose QUAD channel capture device,
> enabling User-space to control channel count.
> Assign min and max channel only based on input hw_params.
> And removes choosing the channel count based on pdata. 

Acked-By: Vinod Koul <vinod.koul@intel.com>

> Naveen Manohar (2):
>   ASoC: Intel: kbl: Remove option of choosing CH count based on pdata
>   ASoC: Intel: kbl: update dmic fixup params
> 
>  sound/soc/intel/boards/kbl_rt5663_max98927.c | 44 +++++++++-------------------
>  1 file changed, 14 insertions(+), 30 deletions(-)
> 
> -- 
> 1.9.1
> 

-- 
~Vinod
