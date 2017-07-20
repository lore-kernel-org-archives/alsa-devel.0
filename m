From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/3]ASoC: Intel: Skylake: Enable hdmi
	for GLK
Date: Thu, 20 Jul 2017 13:56:36 +0530
Message-ID: <20170720082634.GI3053@localhost>
References: <1500531057-4286-1-git-send-email-pradeep.d.tewani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E939266C85
 for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2017 10:23:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1500531057-4286-1-git-send-email-pradeep.d.tewani@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pradeep Tewani <pradeep.d.tewani@intel.com>, \
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 20, 2017 at 11:40:54AM +0530, Pradeep Tewani wrote:
> GLK vendor nid is different from rest of the skylake platforms. Add vendor
> nid as part of driver data and use it. Also enable support for GLK
> platform.
> 
> Add the patch to remove the .owner initialization in bxt driver as well

Thanks Pradeep for fixing these

Acked-By: Vinod Koul <vinod.koul@intel.com>

> 
> Changes in v2:
> 	Removed the .owner field in driver
> 	Replaced the strcmp with strncmp for bxt_rt298 probe
> 
> Pradeep Tewani (3):
>   ASoC: Intel: board: Remove .owner initialization in bxt_rt298 driver
>   ASoC: hdac_hdmi: Add the vendor nid for Geminilake HDMI
>   ASoC: Intel: board: Add Geminilake platform support
> 
>  sound/soc/codecs/hdac_hdmi.c       | 39 ++++++++++++++---
>  sound/soc/intel/boards/bxt_rt298.c | 85 ++++++++++++++++++++++++++++++++++++--
>  2 files changed, 115 insertions(+), 9 deletions(-)
> 
> -- 
> 2.7.4
> 

-- 
~Vinod
