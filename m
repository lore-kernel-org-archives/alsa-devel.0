From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 5/6] ASoC: arizona: Add gating for clock when used for
 direct MCLK
Date: Mon, 05 Sep 2016 10:11:25 +0200
Message-ID: <20dac5f4-0f67-0db0-24bc-4605ac7c9928@samsung.com>
References: <1472831568-466-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1472831568-466-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1472831568-466-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, lee.jones@linaro.org, broonie@kernel.org
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On 09/02/2016 05:52 PM, Charles Keepax wrote:
> Whilst ultimately we would like to move all the clocking over to the
> clock framework, as an intermediate step to get people going for now
> gating the source clocks for SYSCLK/ASYNCCLK when they are configured
> to come directly from an MCLK pin.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

I've tested this patch on TM2 board with WM5110 codec and I didn't
notice any issues.  The clock management looked good with this patch.

Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
