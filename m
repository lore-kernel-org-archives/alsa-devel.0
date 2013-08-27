From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 8/9] ALSA: compress: call pointer callback
 and updates under a lock
Date: Tue, 27 Aug 2013 15:18:59 +0530
Message-ID: <20130827094859.GW2748@intel.com>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
 <1377585639-29516-9-git-send-email-vinod.koul@intel.com>
 <s5hfvtvjugq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 053FB264F28
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 12:33:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hfvtvjugq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 27, 2013 at 12:31:33PM +0200, Takashi Iwai wrote:
> At Tue, 27 Aug 2013 12:10:38 +0530,
> Vinod Koul wrote:
> > 
> > to prevent racy claculations as multiple threads can invoke and update values
> 
> Why a new lock?  Can't it be the same lock?
Pointer query and updates IMO should be independent of the trigger ops. I dont
see a reason why we should blcok pointers while we are pausing...

~Vinod
