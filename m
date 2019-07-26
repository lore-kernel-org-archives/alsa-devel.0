From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [alsa-devel] [RFC PATCH 04/40] soundwire: intel: add debugfs
 register dump
Date: Fri, 26 Jul 2019 16:11:24 +0200
Message-ID: <20190726141124.GA4253@kroah.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-5-pierre-louis.bossart@linux.intel.com>
 <9d5bc940-eadd-4f82-0bac-6a731369436d@intel.com>
 <d231f6b0-555a-8c45-1a9a-215c73171923@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d231f6b0-555a-8c45-1a9a-215c73171923@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 26, 2019 at 09:00:28AM -0500, Pierre-Louis Bossart wrote:
> 
> 
> On 7/26/19 4:35 AM, Cezary Rojewski wrote:
> > On 2019-07-26 01:39, Pierre-Louis Bossart wrote:
> > > +static void intel_debugfs_init(struct sdw_intel *sdw)
> > > +{
> > > +    struct dentry *root = sdw->cdns.bus.debugfs;
> > > +
> > > +    if (!root)
> > > +        return;
> > > +
> > > +    sdw->fs = debugfs_create_dir("intel-sdw", root);
> > > +    if (IS_ERR_OR_NULL(sdw->fs)) {
> > > +        dev_err(sdw->cdns.dev, "debugfs root creation failed\n");
> > > +        sdw->fs = NULL;
> > > +        return;
> > > +    }
> > > +
> > > +    debugfs_create_file("intel-registers", 0400, sdw->fs, sdw,
> > > +                &intel_reg_fops);
> > > +
> > > +    sdw_cdns_debugfs_init(&sdw->cdns, sdw->fs);
> > > +}
> > 
> > I believe there should be dummy equivalent of _init and _exit if debugfs
> > is not enabled (if these are defined already and I've missed it, please
> > ignore).
> 
> I think the direction is just to keep going if there is an error or debufs
> is not enabled.

You should not care either way :)
