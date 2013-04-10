From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/3] ALSA: compress_core: Update calc_avail
 to use cumulative values
Date: Tue, 09 Apr 2013 20:59:48 -0700
Message-ID: <5164E3B4.5050900@linux.intel.com>
References: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <515DC4E3.7040005@linux.intel.com>
 <20130405083604.GB20026@opensource.wolfsonmicro.com>
 <515EE4DC.6050005@linux.intel.com>
 <20130405151845.GC20026@opensource.wolfsonmicro.com>
 <20130409105505.GD31193@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D123B265E92
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2013 05:59:54 +0200 (CEST)
In-Reply-To: <20130409105505.GD31193@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.jf.intel.com>, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


> we can normally use offsets to work and do all the calculation in the core. But
> this check fails when app_ptr = hw_ptr. Here we dont know if the buffer is full
> or empty :) So we need to look at cummulative values for those checks, hence the
> core maintains both of these and IIRC looks at cummulative values when
> calucating avail only when we hit the above condition or probably in case when
> we wrap over the ring buffer.
>
> In both memory mapped and non mapped these cases are true so I dont see why this
> caluclation is specfic for memory maped DSPs. There is nothing in this case
> which relies. We only use the values reported by DSP and internal counters...

the question was whether we need these offsets at all. Can't we just use 
cumulative values everywhere?
-Pierre
