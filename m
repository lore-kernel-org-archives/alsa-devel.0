From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 02/14] soundwire: Add SoundWire bus type
Date: Sat, 21 Oct 2017 16:59:09 +0530
Message-ID: <20171021112909.GE30097@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-3-git-send-email-vinod.koul@intel.com>
 <20171021090348.3wjl6nwoiklgdbrp@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 534C3267781
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 13:24:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20171021090348.3wjl6nwoiklgdbrp@sirena.org.uk>
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

On Sat, Oct 21, 2017 at 10:03:48AM +0100, Mark Brown wrote:
> On Thu, Oct 19, 2017 at 08:33:18AM +0530, Vinod Koul wrote:
> 
> > +	ret = dev_pm_domain_attach(dev, false);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to attach PM domain: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = drv->probe(slave, id);
> > +	if (ret) {
> > +		dev_err(dev, "Probe of %s failed: %d\n", drv->name, ret);
> > +		return ret;
> > +	}
> 
> We don't detach the power domain if the probe fails.

we should, thanks for spotting

-- 
~Vinod
