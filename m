From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] ALSA: compress_core: Update calc_avail
 to use cumulative values
Date: Tue, 9 Apr 2013 16:25:05 +0530
Message-ID: <20130409105505.GD31193@intel.com>
References: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <515DC4E3.7040005@linux.intel.com>
 <20130405083604.GB20026@opensource.wolfsonmicro.com>
 <515EE4DC.6050005@linux.intel.com>
 <20130405151845.GC20026@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id EBBC8265DF1
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2013 13:24:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130405151845.GC20026@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.jf.intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 05, 2013 at 04:18:45PM +0100, Charles Keepax wrote:
> On Fri, Apr 05, 2013 at 09:51:08AM -0500, Pierre-Louis Bossart wrote:
> > On 4/5/13 3:36 AM, Charles Keepax wrote:
> >> If anything if we were looking to simplify I would be inclined to
> >> keep the cumulative values?
> >
> > That is my proposal as well, app_ptr and hw_ptr are defined as offsets  
> > but can't really be used to make the difference between buffer full and  
> > buffer empty and won't work for your implementation. I believe in the  
> > pcm case only cumulative values are used in the core.
> > Vinod, please chime in...
> 
> Ah ok, I misunderstood. I will start having a look at what this
> would take but wait for Vinod to give some feedback before I
> upstream a new version.
Okay, historical note :)

we can normally use offsets to work and do all the calculation in the core. But
this check fails when app_ptr = hw_ptr. Here we dont know if the buffer is full
or empty :) So we need to look at cummulative values for those checks, hence the
core maintains both of these and IIRC looks at cummulative values when
calucating avail only when we hit the above condition or probably in case when
we wrap over the ring buffer.

In both memory mapped and non mapped these cases are true so I dont see why this
caluclation is specfic for memory maped DSPs. There is nothing in this case
which relies. We only use the values reported by DSP and internal counters...

--
~Vinod
