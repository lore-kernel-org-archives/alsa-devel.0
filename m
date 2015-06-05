From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH] ASoC: zx: fix platform_no_drv_owner.cocci warnings
Date: Fri, 5 Jun 2015 09:09:38 +0800
Message-ID: <20150605010938.GB9558@wfg-t540p.sh.intel.com>
References: <201506050116.40gO5c34%fengguang.wu@intel.com>
 <20150604171126.GA226227@ivytown2>
 <20150604171659.GO14071@sirena.org.uk>
 <20150604175300.GP14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150604175300.GP14071@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jun Nie <jun.nie@linaro.org>, kbuild-all@01.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 04, 2015 at 06:53:00PM +0100, Mark Brown wrote:
> On Thu, Jun 04, 2015 at 06:16:59PM +0100, Mark Brown wrote:
> > On Fri, Jun 05, 2015 at 01:11:27AM +0800, kbuild test robot wrote:
> > > sound/soc/zte/zx296702-i2s.c:428:3-8: No need to set .owner here. The core will do it.
> > > 
> > >  Remove .owner field if calls are used which set it automatically
> > 
> > Applied, thanks.
> 
> These mails are CCed to kbuild-all@01.org which is generating
> backscatter since it's subscribers only (not even moderated for
> non-subscribers) - you can you please disable the mails to
> non-subscribers or open the list up?

Sure, I'll open up the list to all email addresses that have 10+
commits in the recent 1 year's git log.

Thanks,
Fengguang
