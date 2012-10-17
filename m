From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2 0/2] Convert davinci ASoC to genalloc SRAM
Date: Wed, 17 Oct 2012 16:06:29 +0200
Message-ID: <507EBB65.2090100@gmail.com>
References: <1349991229-32107-1-git-send-email-mporter@ti.com> <20121017135116.GU14199@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121017135116.GU14199@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Matt Porter <mporter@ti.com>, gururaja.hebbar@ti.com, Sekhar Nori <nsekhar@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alsa Devel List <alsa-devel@alsa-project.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Ben Gardiner <bengardiner@nanometrics.ca>
List-Id: alsa-devel@alsa-project.org

On 17.10.2012 15:51, Mark Brown wrote:
> On Thu, Oct 11, 2012 at 05:33:47PM -0400, Matt Porter wrote:
> 
>> This series converts davinci ASoC to use genalloc and enables
>> that support on DA850. It applies to mainline on top of the
>> uio_pruss/genalloc series [1] which allows DaVinci to provide
>> a gen_pool via pdata for driver use.
> 
> I tried to apply these patches but patch 2 doesn't apply against
> v3.7-rc1 I guess due to the series you mention.  What's the plan for
> merging that series?  It'd also be good to get Daniel's patch squashed
> in.

I'll resend the rebased patches from my 3.7-rc1 development branch with
my patch squashed into 1/2. Matt, hope you're ok with that?


Thanks,
Daniel
