From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: sst-bxt-da7219_max98357a: fix obsoleted
 initializer for array
Date: Tue, 18 Oct 2016 19:26:39 +0530
Message-ID: <20161018135639.GW2467@localhost>
References: <20161017220256.32008-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161017220256.32008-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Yong Zhi <yong.zhi@intel.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 17, 2016 at 11:02:56PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Smatch reports below warnings:
> 
>     bxt_da7219_max98357a.c:352:9: warning: obsolete array initializer,
>     use C99 syntax
> 
> An earlier commit cleaned up similar warnings, however, a recent
> commit 43c02ede76a60de ("ASoC: Intel: Add DMIC channel constraint for
> bxt machine") re-introduced the older initializer style. So fix
> this warning to make the code consistent.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
