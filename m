From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ALSA: compress_core: Update	calc_avail
	to use cumulative values
Date: Fri, 5 Apr 2013 09:36:04 +0100
Message-ID: <20130405083604.GB20026@opensource.wolfsonmicro.com>
References: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <515DC4E3.7040005@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9A2FF261704
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 10:36:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <515DC4E3.7040005@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 04, 2013 at 01:22:27PM -0500, Pierre-Louis Bossart wrote:
> This isn't very elegant. In your implementation you bypass app_ptr and  
> hw_ptr to use cumulative values, for 'memory-mapped' DSPs we use app_ptr  
> and hw_ptr everywhere else. This patch seems to make things more  
> confused when they could be simpler without all these redundant fields?  
> I am probably partly responsible for the introduction of these  
> cumulative values, now I think the time has come to simplify things.

I am not sure I agree this is less elegant it greatly simplifies
the calculation of the available data for one, also half of the
avail function was using them anyway. The cumulative values make
less assumptions about the underlying representation (although
admittedly it is rather unlikely this will be anything other than
a ring buffer) and contain more information (ie. how much data
has been transferred so far).

You say we use app_ptr and hw_ptr everywhere else but only in
places relating to situations where compress_offload is managing
the buffer (ie. memory mapped DSPs). They feel more like internal
buffer state, where the cumulative values surely reflect the
stream state better.

If anything if we were looking to simplify I would be inclined to
keep the cumulative values?
