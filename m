From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: fix swapped order of function
 arguments dir and pin_index
Date: Fri, 22 Sep 2017 15:43:52 +0530
Message-ID: <20170922101352.GT30097@localhost>
References: <20170920130125.12984-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170920130125.12984-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Ramesh Babu <ramesh.babu@intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 20, 2017 at 02:01:25PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The call to slk_tplg_fill_res_tkn is passing dir and pin_index in the
> wrong order, they need to be in pin_index, dir order to match the function
> slk_tplg_fill_res_tkn  correctly.
> 
> Detected by CoveritScan, CID#1454992 ("Arguments in wrong order")

thanks for this.


Acked-By: Vinod Koul <vinod.koul@intel.com>
Tested-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>

-- 
~Vinod
