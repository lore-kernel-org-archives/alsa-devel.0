From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: warnings with clk_disable_unprepare()
Date: Thu, 8 Dec 2016 13:18:31 -0800
Message-ID: <20161208211831.GL5423@codeaurora.org>
References: <d755ee65-937f-1581-ac74-347b9e4c8d51@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d755ee65-937f-1581-ac74-347b9e4c8d51@linux.intel.com>
Sender: linux-clk-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/05, Pierre-Louis Bossart wrote:
> Hi,
> In the modified cht-bsw_rt5645 machine driver for Asus X205TA and
> T100HA, I disable the audio mclk with a call to
> clk_disable_unprepare() when I see a SND_SOC_DAPM_EVENT_OFF event in
> the platform_clock_control hook.
> 
> For some reason I seem to get multiple SND_SOC_DAPM_EVENT_OFF events
> and the clock framework complains with dmesg warnings that the
> refcount is already zero (which has no functional side effect).
> 
> WARNING: CPU: 0 PID: 2002 at drivers/clk/clk.c:476 clk_unprepare+0x1a/0x21
> 
> WARNING: CPU: 2 PID: 2095 at drivers/clk/clk.c:594
> clk_core_disable_lock+0x12/0x1b
> 
> I could fix this in three different ways:
> - remove multiple SND_SOC_DAPM_EVENT_OFF events (not sure what the
> root cause is, maybe issues with jack detection?)

It would be good to know what the root cause is here before
thinking about doing anything else.

> - call a clk_is_enabled() or clk_refcount() function before calling
> clk_disable_unprepare() (but they don't seem to exist in
> include/linux/clk.h)
> - count the references myself (which does exactly the same as what
> the clk framework already does so it's not terribly elegant)
> 

Both of these sound like hacks around the problem of unbalanced
off event calls.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
