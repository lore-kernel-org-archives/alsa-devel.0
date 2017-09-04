From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/2] Enable TDM slot and fix SSP params for
 kabylake machine driver
Date: Mon, 4 Sep 2017 09:32:43 +0530
Message-ID: <20170904040242.GH3053@localhost>
References: <1504291278-4482-1-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C7EF266F0E
 for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2017 05:59:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1504291278-4482-1-git-send-email-harshapriya.n@intel.com>
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

On Fri, Sep 01, 2017 at 11:41:16AM -0700, Harsha Priya wrote:
> This patch series includes 2 patches for kabylake machine driver using
> max98927 and rt5663 codecs. The changes are:
> 
> 1. Enable 4 tdm slots for IV feedback and 2 tdm slots for playback on max98927
> 
> 2. Fix setting of SSP parameters to be based on FE and BE dai links.

Acked-By: Vinod Koul <vinod.koul@intel.com>

> Naveen M (2):
>   ASoC: Intel: Enable tdm slots for max98927
>   ASoC: Intel: Fix setting of SSP parameters in Kabylake machine driver
> 
>  sound/soc/intel/boards/kbl_rt5663_max98927.c | 55 ++++++++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 3 deletions(-)
> 
> -- 
> 1.9.1
> 

-- 
~Vinod
