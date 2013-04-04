From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/3] ALSA: compress_core: Update calc_avail
 to use cumulative values
Date: Thu, 04 Apr 2013 13:22:27 -0500
Message-ID: <515DC4E3.7040005@linux.intel.com>
References: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id D7CD426164C
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2013 20:22:30 +0200 (CEST)
In-Reply-To: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

On 04/03/2013 07:13 AM, Charles Keepax wrote:
> The app_pointer is managed locally by the compress core for memory
> mapped DSPs but for DSPs that are not memory mapped this would have to
> be manually updated from within the DSP driver itself, which is hardly
> very idiomatic.
>
> This patch switches to using the cumulative values to calculate the
> available buffer space because these are already gracefully passed out
> of the DSP driver to the compress core and otherwise should be
> functionally equivalent.

This isn't very elegant. In your implementation you bypass app_ptr and 
hw_ptr to use cumulative values, for 'memory-mapped' DSPs we use app_ptr 
and hw_ptr everywhere else. This patch seems to make things more 
confused when they could be simpler without all these redundant fields? 
I am probably partly responsible for the introduction of these 
cumulative values, now I think the time has come to simplify things.
-Pierre
