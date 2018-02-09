From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: Skylake: make function
 skl_clk_round_rate static
Date: Fri, 9 Feb 2018 10:46:48 +0530
Message-ID: <20180209051647.GA3666@localhost>
References: <20180208143530.11450-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180208143530.11450-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Sriram Periyasamy <sriramx.periyasamy@intel.com>, Stephen Boyd <sboyd@codeaurora.org>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 08, 2018 at 02:35:30PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The function skl_clk_round_rate is local to the source and does not
> need to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> sound/soc/intel/skylake/skl-ssp-clk.c:250:6: warning: symbol
> 'skl_clk_round_rate' was not declared. Should it be static?

Acked-By: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
