From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/5] sound: soc: skylake: no need to check
 return value of debugfs_create functions
Date: Thu, 27 Jun 2019 08:23:29 +0800
Message-ID: <20190627002329.GA3540@kroah.com>
References: <20190614094756.2965-1-gregkh@linuxfoundation.org>
 <20190614094756.2965-2-gregkh@linuxfoundation.org>
 <f85fe797-f843-bf71-549a-00a169d527dd@intel.com>
 <s5h4l4hwe1c.wl-tiwai@suse.de>
 <20190624105334.GJ5316@sirena.org.uk>
 <s5htvcfxgy9.wl-tiwai@suse.de>
 <20190624133336.GN5316@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2C527F8071F
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 02:23:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190624133336.GN5316@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Takashi Iwai <tiwai@suse.de>, Jie Yang <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 24, 2019 at 02:33:36PM +0100, Mark Brown wrote:
> On Mon, Jun 24, 2019 at 03:15:26PM +0200, Takashi Iwai wrote:
> > Mark Brown wrote:
> 
> > > Currently debugfs doesn't report any errors other than via the return
> > > codes (at least in the common creation stuff) so it's up to the callers
> > > to do that.
> 
> > So this should be changed to follow a la sysfs creation error, IMO.
> > At least, the name conflicts etc should be reported more obviously.
> 
> Indeed, that'd mitigate the problems with just making everything
> silently fail a lot - so long as we say there's a problem people are a
> lot less likely to be mislead if anything goes wrong.

Ok, let me work on doing this in the debugfs core and will cc: you all
on the resulting patches to see if it will satisfy your objections here.

sorry for the delay, am on the road all this week with limited
internet...

greg k-h
