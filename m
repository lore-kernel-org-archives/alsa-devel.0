From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 07/13] soundwire: Add stream
	configuration APIs
Date: Thu, 26 Apr 2018 10:53:25 +0530
Message-ID: <20180426052324.GS6014@localhost>
References: <1524649163-12088-1-git-send-email-vkoul@kernel.org>
 <1524649163-12088-8-git-send-email-vkoul@kernel.org>
 <20180426040016.GA15388@buildpc-HP-Z230>
 <20180426042856.GR6014@localhost>
 <20180426043813.GB15388@buildpc-HP-Z230>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id DC5192677B2
 for <alsa-devel@alsa-project.org>; Thu, 26 Apr 2018 07:18:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20180426043813.GB15388@buildpc-HP-Z230>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Vinod Koul <vkoul@kernel.org>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 26, 2018 at 10:08:13AM +0530, Sanyog Kale wrote:
> On Thu, Apr 26, 2018 at 09:58:56AM +0530, Vinod Koul wrote:

> > > We should have kept zero bandwidth check here because there is no need
> > > to perform sdw_program_params when no stream is running on bus.
> > 
> > Looking at it I think it helps to program the calculated values, we may get
> > a new stream even before we get a chance to suspend. And frankly at bus, we
> > should not make any assumptions about suspend behaviour they may change with
> > platforms and archs :)
> 
> Whats the use of computing & programming values when there is
> no stream running? The computing and programming of values for new stream
> will be done in new stream setup flow ie. in prepare, nothing needs to be
> done here.
> 
> I agree we should not make any suspend behaviour assumption here.

That is why programming this is required :)

> In case of zero bandwidth, we should just change the stream state to
> DEPREPARE and return.

Yes agreed and have fixed it, perhaps you missed below:
> > > 
> > > Change the state to DEPREPARE and then return.
> > 
> > good spot will fix

-- 
~Vinod
