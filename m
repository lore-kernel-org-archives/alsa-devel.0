From: Jeeja KP <jeeja.kp@intel.com>
Subject: Re: [PATCH 02/10] ASoC: Intel: Skylake: Set the pipe
 state to paused when paused
Date: Wed, 8 Jun 2016 15:09:16 +0530
Message-ID: <20160608093916.GA21387@kpjeeja-desk>
References: <1464958783-19344-1-git-send-email-jeeja.kp@intel.com>
 <1464958783-19344-3-git-send-email-jeeja.kp@intel.com>
 <20160607125621.GW7510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F27D260701
 for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2016 11:32:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160607125621.GW7510@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 07, 2016 at 01:56:21PM +0100, Mark Brown wrote:
> On Fri, Jun 03, 2016 at 06:29:35PM +0530, jeeja.kp@intel.com wrote:
> > From: Jeeja KP <jeeja.kp@intel.com>
> > 
> > When pipe is stopped/Paused, set the pipe state to paused instead
> > of created.
> 
> because...

after creation of pipe, pipe can be started and stopped mutiple times.
So valid state in this case is PAUSED instead of created.

-- 
