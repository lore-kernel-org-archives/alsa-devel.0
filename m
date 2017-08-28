From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/2] ASoC: Intel: kbl: Machine driver
 modifications to support MST Audio
Date: Mon, 28 Aug 2017 16:01:49 +0530
Message-ID: <20170828103148.GY3053@localhost>
References: <1503700450-7964-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DC93D266884
 for <alsa-devel@alsa-project.org>; Mon, 28 Aug 2017 12:28:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1503700450-7964-1-git-send-email-naveen.m@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Naveen M <naveen.m@intel.com>
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 26, 2017 at 04:04:08AM +0530, Naveen M wrote:
> Patch modifies dapm routes to enable HDMI Audio and invokes
> machine pin widget for hdmi port to enable/disable pin, when monitor
> is connected/disconnected based on the pin status. 

Acked-By: Vinod Koul <vinod.koul@intel.com>

> Naveen M (2):
>   ASoC: Intel: kbl: Add MST route change to kbl machine drivers
>   ASoC: Intel: kbl: Add jack port initialize in kbl machine drivers
> 
>  sound/soc/intel/boards/kbl_rt5663_max98927.c        | 15 +++++++++------
>  sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 14 ++++++++------
>  2 files changed, 17 insertions(+), 12 deletions(-)
> 
> -- 
> 1.9.1
> 

-- 
~Vinod
