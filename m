From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 0/9] Add SKL ipc handling code
Date: Wed, 22 Apr 2015 21:23:08 +0530
Message-ID: <20150422155308.GJ2738@intel.com>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <20150420214441.GW14892@sirena.org.uk>
 <20150422040046.GF2738@intel.com> <1429701598.2695.14.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id AEA2C2605AA
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 17:55:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1429701598.2695.14.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 22, 2015 at 12:19:58PM +0100, Liam Girdwood wrote:
> On Wed, 2015-04-22 at 09:30 +0530, Vinod Koul wrote:
> > On Mon, Apr 20, 2015 at 10:44:41PM +0100, Mark Brown wrote:
> > > On Fri, Apr 17, 2015 at 06:45:58PM +0530, Vinod Koul wrote:
> > > > This series adds support for managing DSP and posting IPC and processing IPC
> > > > replies.
> > > 
> > > Any dependencies on the generic HDA stuff you've been posting?
> > Yes.
> > 
> > So first we need to merge the SKL PCM driver series. Can you please review
> > that [1] one as well. Then this series.
> > Lastly the SKL aDSP support series [2] which uses the IPC code in this series.
> > 
> > One more would be when toplogy is merged, for supporting the dsp toplogy
> > 
> 
> We also need to port the SKL IPC code to use the converged mailbox code
> that's now used by BDW and BYT before upstreaming.
Yes that wil be done for next patch series. If you guys could give comments
on the other tow series, I will spin them and resubmit as well

-- 
~Vinod
