From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 10/14] soundwire: Add sysfs for SoundWire
	DisCo properties
Date: Sat, 21 Oct 2017 17:23:35 +0530
Message-ID: <20171021115335.GJ30097@localhost>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-11-git-send-email-vinod.koul@intel.com>
 <20171021094253.45qbp6wzyhifw5vc@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B423266B38
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 13:49:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20171021094253.45qbp6wzyhifw5vc@sirena.org.uk>
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

On Sat, Oct 21, 2017 at 10:42:53AM +0100, Mark Brown wrote:
> On Thu, Oct 19, 2017 at 08:33:26AM +0530, Vinod Koul wrote:
> 
> > +static ssize_t clock_frequencies_show(struct sdw_bus *bus,
> > +			struct sdw_prop_attribute *attr, char *buf)
> > +{
> > +	ssize_t size = 0;
> > +	int i;
> > +
> > +	for (i = 0; i < bus->prop.num_freq; i++)
> > +		size += sprintf(buf + size, "%8d\n", bus->prop.freq[i]);
> > +
> > +	return size;
> > +}
> 
> sysfs is supposed to be one value per file...

I though it needs to be human readable like:

$ cat /sys/bus/cpu/devices/cpu0/cpufreq/scaling_available_governors
performance powersave

In this case, if this is allowed it does help to have a single file with all
supported frequencies for a device

> 
> > +int sdw_sysfs_slave_init(struct sdw_slave *slave)
> > +{
> > +	/* TODO: Initialize dp0 and dpn kobject and attribute */
> > +	return 0;
> > +}
> > +
> > +void sdw_sysfs_slave_exit(struct sdw_slave *slave)
> > +{
> > +}
> 
> Seems like an important TODO?

Yes. For now I will remove the dummy code and add the patches for this after
this series is done.

Thanks
-- 
~Vinod
