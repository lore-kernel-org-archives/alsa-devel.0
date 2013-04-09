From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/3] ALSA: compress_core: Split copy into
 seperate read and write callbacks
Date: Tue, 9 Apr 2013 16:45:07 +0530
Message-ID: <20130409111507.GF31193@intel.com>
References: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1364991209-24653-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <515DC015.7040704@linux.intel.com>
 <20130405082344.GA20026@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 58BC0265DF1
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2013 13:43:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130405082344.GA20026@opensource.wolfsonmicro.com>
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

On Fri, Apr 05, 2013 at 09:23:45AM +0100, Charles Keepax wrote:
> On Thu, Apr 04, 2013 at 01:01:57PM -0500, Pierre-Louis Bossart wrote:
> > Why not remove the const to make this consistent with the PCM interface?
> 
> I had been trying to avoid loosing the const from the write file
> operation, however I am happy to just loose this through casting
> instead. It is certainly a simpler change I will respin these to
> do so.
Keeping const of write seems to be a better idea... Ah i cant decide :(
I will asker wiser folks... Takashi, Mark?

--
~Vinod
