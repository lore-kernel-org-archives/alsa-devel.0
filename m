From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2] clk: x86: add "mclk" alias for
	Baytrail/Cherrytrail
Date: Wed, 19 Apr 2017 09:53:10 -0700
Message-ID: <20170419165310.GK7065@codeaurora.org>
References: <1487622236-16901-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.29.96])
 by alsa0.perex.cz (Postfix) with ESMTP id 18836266B23
 for <alsa-devel@alsa-project.org>; Wed, 19 Apr 2017 18:53:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1487622236-16901-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, Michael Turquette <mturquette@baylibre.com>, x86@kernel.org, Takashi Iwai <tiwai@suse.com>, platform-driver-x86@vger.kernel.org, Mark Brown <broonie@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 02/20, Pierre-Louis Bossart wrote:
> Due to timing requirements, TI and Conexant manage the audio
> reference clock from their ASoC codec drivers using the "mclk"
> string. This patch adds another lookup for the "pmc_plt_clk_3"
> clock to avoid Intel-specific tests in those codec drivers and
> use code as-is.
> 
> To avoid a leak, clk_add_alias() is not used in this patch.
> Instead the lookup is created manually as part of the .probe()
> step and dropped in the .remove() step.
> 
> "pmc_plt_clk_3" is used exclusively for audio on all known
> Baytrail/CherryTrail designs and is e.g. routed on the MCLK
> (pin 26) of the MinnowBoardMAX Turbot LSE connector.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
