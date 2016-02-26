From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: rt5640: add master clock handling
 for rt5640
Date: Fri, 26 Feb 2016 09:43:15 -0600
Message-ID: <56D07293.902@linux.intel.com>
References: <1456190782-18865-1-git-send-email-sugar.zhang@rock-chips.com>
 <56CC719C.1090901@linux.intel.com> <2199435.lA9iTvxnKV@phil>
 <20160224033259.GL18327@sirena.org.uk> <56CDD5DD.6040006@linux.intel.com>
 <20160226010818.GZ18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id F176D2605BD
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2016 16:43:17 +0100 (CET)
In-Reply-To: <20160226010818.GZ18327@sirena.org.uk>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Sugar Zhang <sugar.zhang@rock-chips.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On 2/25/16 7:08 PM, Mark Brown wrote:
> On Wed, Feb 24, 2016 at 10:10:05AM -0600, Pierre-Louis Bossart wrote:
>> On 2/23/16 9:32 PM, Mark Brown wrote:
>
>>> That said we really do need x86 to transition to use the clock API
>>> in order to integrate with external devices, where the machine driver
>>> does manage clocks we want that to move to being done using the clock
>>> API rather than custom APIs.
>
>> For Baytrail audio we have a single platform clock that can be turned
>> on/off and set to 19.2 MHz or 25 MHz. No other controls are available,
>> no multipliers or complicated dependencies on other clocks, parents or
>> children and no other users for this clock but the audio subsystem.
>> I looked at the clock framework and couldn't figure out how it would simply
>> map the hardware so for now the use of the MCLK is only enabled with an
>> on/off or set-rate(19.2|25) custom API. I am not an expert here so if this
>> clock framework becomes a requirement to upstream code I would appreciate
>> any pointers to do the right thing. I really couldn't find a simple example
>> with 'Put your code here' comments to use this framework.
>
> There's a lot of helpers like -fixed, -gate and so on - this sounds like
> you could probably use those helpers (there should be lots of examples
> in the kernel) or just implement a simple provider (see clk-provider.h)
> depending on how the control is mapped in.  If it's that simple just
> open coding a provider ought to do the job.  Then set up the client
> linkage with clkdev in some way that makes sense for your platform.

Yes there are documentation and helpers I looked into, but to the best 
of my limited knowledge not for the gate + dual-rate case. Then you jump 
to complicated configurations combining multiple base clocks that don't 
really make sense here. After one frustrating day of trying to wrap 100 
lines of code into the clock framework I gave up and kept the simple 
custom driver. There is a single client for this clock so I don't quite 
see the benefits/ROI of mapping a simple piece of hardware with a 
complex model.
