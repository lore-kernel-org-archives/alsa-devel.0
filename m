From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 02/14] soundwire: Add SoundWire bus type
Date: Thu, 26 Oct 2017 14:03:42 +0530
Message-ID: <20171026083342.GW936@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-3-git-send-email-vinod.koul@intel.com>
 <20171020104528.GC3210@kroah.com>
 <20171020160134.GT30097@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id B464B266A0C
 for <alsa-devel@alsa-project.org>; Thu, 26 Oct 2017 10:29:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20171020160134.GT30097@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Mark <broonie@kernel.org>, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 20, 2017 at 09:31:34PM +0530, Vinod Koul wrote:
> On Fri, Oct 20, 2017 at 12:45:28PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Oct 19, 2017 at 08:33:18AM +0530, Vinod Koul wrote:

> > > +struct bus_type sdw_bus_type = {
> > > +	.name = "soundwire",
> > > +	.match = sdw_bus_match,
> > > +	.uevent = sdw_uevent,
> > > +};
> > > +EXPORT_SYMBOL(sdw_bus_type);
> > 
> > No release callback?  Who frees the device?

Hmmm, bus_type doesn't seem to have a release callback. The sdw_device has
release and that is added in the next patch. So I am not changing anything
here. Let me know If I missed anything...

Thanks
-- 
~Vinod
