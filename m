From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 11/14] soundwire: cdns: Add cadence module
Date: Sat, 21 Oct 2017 17:24:54 +0530
Message-ID: <20171021115453.GK30097@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-12-git-send-email-vinod.koul@intel.com>
 <20171021095201.cxxmgvliyzzr4ydo@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id A2A9E267174
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 13:50:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20171021095201.cxxmgvliyzzr4ydo@sirena.org.uk>
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
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 21, 2017 at 10:52:01AM +0100, Mark Brown wrote:
> On Thu, Oct 19, 2017 at 08:33:27AM +0530, Vinod Koul wrote:
> 
> > Cadence IP implements SoundWire Master. Add base cadence module
> > initialization and interrupt handling
> 
> It's probably worth saying something about how this isn't a device
> driver but rather a library for device drivers.

Yes you are right, I will update this to clarify

> 
> > +	if (int_status & CDNS_MCP_INT_CTRL_CLASH) {
> > +
> > +		/* Slave is driving bit slot during control word */
> > +		dev_err_ratelimited(cdns->dev, "Bus clash for control word\n");
> > +		int_status |= CDNS_MCP_INT_CTRL_CLASH;
> > +	}
> 
> So with this (and the other error flags) we check to see if the bit is
> set, print an error and then set the bit we were looking for in the same
> variable we just checked?

no this doesnt look right, I will fix it up.

-- 
~Vinod
