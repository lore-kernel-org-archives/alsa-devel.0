From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ALSA: compress_core: Update	calc_avail
	to use cumulative values
Date: Fri, 5 Apr 2013 16:18:45 +0100
Message-ID: <20130405151845.GC20026@opensource.wolfsonmicro.com>
References: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <515DC4E3.7040005@linux.intel.com>
 <20130405083604.GB20026@opensource.wolfsonmicro.com>
 <515EE4DC.6050005@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 49A4A265FF0
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 17:18:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <515EE4DC.6050005@linux.intel.com>
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

On Fri, Apr 05, 2013 at 09:51:08AM -0500, Pierre-Louis Bossart wrote:
> On 4/5/13 3:36 AM, Charles Keepax wrote:
>> If anything if we were looking to simplify I would be inclined to
>> keep the cumulative values?
>
> That is my proposal as well, app_ptr and hw_ptr are defined as offsets  
> but can't really be used to make the difference between buffer full and  
> buffer empty and won't work for your implementation. I believe in the  
> pcm case only cumulative values are used in the core.
> Vinod, please chime in...

Ah ok, I misunderstood. I will start having a look at what this
would take but wait for Vinod to give some feedback before I
upstream a new version.

Thanks,
Charles
