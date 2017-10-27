From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH RESEND 0/2] Enable TDM slot and fix SSP
 params for kabylake machine driver
Date: Fri, 27 Oct 2017 09:43:23 +0530
Message-ID: <20171027041323.GY936@localhost>
References: <1509043443-28143-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1AC2D266AF8
 for <alsa-devel@alsa-project.org>; Fri, 27 Oct 2017 06:09:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1509043443-28143-1-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Harsha Priya <harshapriya.n@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 26, 2017 at 11:44:01AM -0700, Harsha Priya wrote:
> Hi Mark,
> 
> These are resend of an already acked patch series.
> I posted it a few weeks ago but there has been update on the base branch. 
> I want to resend these. Kindly review and merge.
> 
> This patch series includes 2 patches for kabylake machine driver using
> max98927 and rt5663 codecs. The changes are:
> 
> 1. Enable 4 tdm slots for IV feedback and 2 tdm slots for playback on max98927
> 
> 2. Fix setting of SSP parameters to be based on FE and BE dai links.

Acked-By: Vinod Koul <vinod.koul@intel.com>

> Harsha Priya (2):
>   ASoC: Intel: Enable tdm slots for max98927
>   ASoC: Intel: Fix setting of SSP parameters in Kabylake machine driver
> 
>  sound/soc/intel/boards/kbl_rt5663_max98927.c | 67 +++++++++++++++++++++++++---
>  1 file changed, 60 insertions(+), 7 deletions(-)
> 
> -- 
> 1.9.1
> 

-- 
~Vinod
