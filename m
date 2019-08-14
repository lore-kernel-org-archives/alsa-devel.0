From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [alsa-devel] [PATCH] soundwire: Don't build sound.o without
 CONFIG_ACPI
Date: Wed, 14 Aug 2019 11:16:04 +0530
Message-ID: <20190814054604.GW12733@vkoul-mobl.Dlink>
References: <20190813061014.45015-1-natechancellor@gmail.com>
 <445d16e1-6b00-6797-82df-42a49a5e79e3@linux.intel.com>
 <20190814035947.GS12733@vkoul-mobl.Dlink>
 <20190814042428.GA125416@archlinux-threadripper>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190814042428.GA125416@archlinux-threadripper>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, clang-built-linux@googlegroups.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 13-08-19, 21:24, Nathan Chancellor wrote:
> On Wed, Aug 14, 2019 at 09:29:47AM +0530, Vinod Koul wrote:
> > On 13-08-19, 09:22, Pierre-Louis Bossart wrote:
> > > On 8/13/19 1:10 AM, Nathan Chancellor wrote:
 
> > > I am fine with the change, but we might as well rename the file acpi_slave.c
> > > then?
> > 
> > Srini's change add support for DT for the same file, so It does not make
> > sense to rename. Yes this patch tries to fix a warn which is there due
> > to DT being not supported but with Srini's patches this warn should go
> > away as sdw_slave_add() will be invoked by the DT counterpart
> > 
> > Sorry Nathan, we would have to live with the warn for few more days till
> > I apply Srini's changes. So I am not taking this (or v2) patch
> > 
> 
> That is fine as I can apply this locally. Could you point me to these
> patches so that I can take a look at them?

Here you go:

https://lore.kernel.org/lkml/20190808144504.24823-3-srinivas.kandagatla@linaro.org/

-- 
~Vinod
