From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: fix sst firmware path
Date: Thu, 5 Feb 2015 11:26:13 -0800
Message-ID: <20150205192613.GA16547@intel.com>
References: <1423078507-30032-1-git-send-email-kevin.strasser@linux.intel.com>
 <20150205181458.GG21293@sirena.org.uk>
 <20150205184822.GE13647@H87M>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150205184822.GE13647@H87M>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Strasser <kevin.strasser@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Yang Fang <yang.a.fang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 05, 2015 at 10:48:22AM -0800, Kevin Strasser wrote:
> On Thu, Feb 05, 2015 at 06:14:58PM +0000, Mark Brown wrote:
> > On Wed, Feb 04, 2015 at 11:35:07AM -0800, Kevin Strasser wrote:
> > > All sst firmware is provided under the intel directory of the linux-firmware
> > > tree. By default this directory structure is kept when installing on a
> > > target system. Change the path to expect a default linux-firmware
> > > installation.
> > 
> > Applied, thanks.  It doesn't apply as a fix but that seems to be OK as the
> > only request_firmware() I spotted there appears to use intel/ prefixed
> > directories already.
> 
> I'm a little confused. Do you want me to submit a version that can be applied as
> a fix? It seems to me that we want this patch in 3.19.
This patch wont apply as is, Mark requires you need to provide a patch
which can be applied against 3.19

-- 
~Vinod
