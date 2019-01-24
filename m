From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: intel: cht_bsw_max98090_ti: Enable
 codec clock once and keep it enabled
Date: Thu, 24 Jan 2019 09:02:36 -0600
Message-ID: <b99b6f2f-5563-8ea5-57d2-04b2c967502f@linux.intel.com>
References: <20190124103425.22214-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id E75B42674A9
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2019 16:02:39 +0100 (CET)
In-Reply-To: <20190124103425.22214-1-hdegoede@redhat.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Dean Wallace <duffydack73@gmail.com>, Mogens Jensen <mogens-jensen@protonmail.com>
List-Id: alsa-devel@alsa-project.org


On 1/24/19 4:34 AM, Hans de Goede wrote:
> Users have been seeing sound stability issues with max98090 codecs since:
> commit 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
>
> At first that commit broke sound for Chromebook Swanky and Clapper models,
> the problem was that the machine-driver has been controlling the wrong
> clock on those models since support for them was added. This was hidden by
> clk-pmc-atom.c keeping the actual clk on unconditionally.
>
> With the machine-driver controlling the proper clock, sound works again
> but we are seeing bug reports describing it as: low volume,
> "sounds like played at 10x speed" and instable.
>
> When these issues are hit the following message is seen in dmesg:
> "max98090 i2c-193C9890:00: PLL unlocked".
>
> Attempts have been made to fix this by inserting a delay between enabling
> the clk and enabling and checking the pll, but this has not helped.
>
> It seems that if we ever disable the clk, the pll looses its lock and
> then we get various issues.
>
> This commit fixes this by enabling the clock once at probe time,
> in essence restoring the old behavior of clk-pmc-atom.c always keeping
> the clk on, but then only on machines with a max98090 codec.
>
> Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
> Reported-and-tested-by: Mogens Jensen <mogens-jensen@protonmail.com>
> Reported-and-tested-by: Dean Wallace <duffydack73@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Sorry, I am not really convinced this patch can be applied as is.

1. All these clock changes were introduced to solve S0i1 issues, so now 
if we keep the clocks on isn't this going to impact suspend/resume 
usages? Has anyone looked into this? I am also wondering what the 
assumptions were on what the firmware does, and if the issues occur with 
the legacy firmware or Coreboot?

2. Also the fix is incorrect in that the clock needs to be set to 19.2 
MHz for Baytrail devices (Rambi and friends) which reuse this machine 
driver. Even if there was agreement on leaving the clocks on, the 
clk_set_rate() call needs to be added back (default is 25 MHz on Baytrail).
