From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/3] ASoC: Intel: kbl: Add Multi-endpoint
 Playback & Echo Ref support
Date: Thu, 3 Aug 2017 10:24:27 +0530
Message-ID: <20170803045426.GB3053@localhost>
References: <1501654415-24590-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 887122664EB
 for <alsa-devel@alsa-project.org>; Thu,  3 Aug 2017 06:51:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1501654415-24590-1-git-send-email-naveen.m@intel.com>
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

On Wed, Aug 02, 2017 at 11:43:32AM +0530, Naveen M wrote:
> 1. Add new FE capabilities to support:
>   a. Parallel playback on 2 ports simultaneously
>      Define new frontends to enable additional playback port.
>      This will be used when platform needs to support multi-playback
>      on different ports. Ex: Headset and Speaker simultaneously
>   b. Echo reference capture capability
>      Certain platforms need reference stream of playback to supplement
>      User-space post-processing algorithms. This pin enables platform
>      driver to provide such a FE.
> 2. Add DAI links for parallel playback and echo ref
> 3. Add map for new DAIs for parallel playback and echo ref

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
