From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3] ASoC: Intel: kbl: Modify map for
 Headset Playback to fix pop-noise
Date: Tue, 7 Nov 2017 09:24:14 +0530
Message-ID: <20171107035414.GQ3187@localhost>
References: <1509716702-27145-1-git-send-email-naveen.m@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id E005E266DF5
 for <alsa-devel@alsa-project.org>; Tue,  7 Nov 2017 04:51:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1509716702-27145-1-git-send-email-naveen.m@intel.com>
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
Cc: Sathya Prakash M R <sathya.prakash.m.r@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, subhransu.s.prusty@intel.com, pierre-louis.bossart@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 03, 2017 at 07:15:02PM +0530, Naveen Manohar wrote:
> Patch fixes wrong path in commit 0b06122fc8d0 ("ASoC: Intel: kbl: Add
> map for new DAIs for Multi-Playback & Echo Ref") which resulted in pop
> noise.
> Current topology for Headset results in unwanted pop noise, while
> switching from spk->hs at the start of Headset Playback.
> Hence re-introduced mixin-mixout dsp module in topology for headset
> playback pipe to fix the regression.
> And the corresponding modification for headset route is updated here.
> 
> Fixes: 0b06122fc8d0 ("ASoC: Intel: kbl: Add map for new DAIs for
> Multi-Playback & Echo Ref")
> Signed-off-by: Naveen Manohar <naveen.m@intel.com>
> Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
