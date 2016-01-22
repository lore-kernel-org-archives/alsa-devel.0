From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] amixer: add support for TLV byte control
	read
Date: Fri, 22 Jan 2016 15:27:46 +0530
Message-ID: <20160122095745.GE11130@localhost>
References: <1453441612-29902-1-git-send-email-vinod.koul@intel.com>
 <s5hoace5e75.wl-tiwai@suse.de> <20160122074623.GC11130@localhost>
 <s5hfuxq593q.wl-tiwai@suse.de> <s5hbn8e58aq.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C3AC3260511
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 10:54:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hbn8e58aq.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 22, 2016 at 09:26:37AM +0100, Takashi Iwai wrote:
> > > so we ensure we give right size buffer here
> > 
> > Actually we should have an API function that returns the size of TLV.
> > Then amixer can adjust the allocation size.
> 
> .... thinking of this again, it might be easier to fix amixer locally
> at first.

Sure, so what is approach that you would like me to take

-- 
~Vinod
