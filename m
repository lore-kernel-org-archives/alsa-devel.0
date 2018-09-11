From: Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH 2/3] sound: enable interrupt after dma buffer
 initialization
Date: Tue, 11 Sep 2018 14:58:25 -0600
Message-ID: <20180911205825.GB18086@google.com>
References: <20180910211718.200802-1-yuzhao@google.com>
 <20180910212150.202655-1-yuzhao@google.com>
 <s5hbm9436va.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hbm9436va.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vkoul@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 11, 2018 at 08:06:49AM +0200, Takashi Iwai wrote:
> On Mon, 10 Sep 2018 23:21:50 +0200,
> Yu Zhao wrote:
> > 
> > In snd_hdac_bus_init_chip(), we enable interrupt before
> > snd_hdac_bus_init_cmd_io() initializing dma buffers. If irq has
> > been acquired and irq handler uses the dma buffer, kernel may crash
> > when interrupt comes in.
> > 
> > Fix the problem by postponing enabling irq after dma buffer
> > initialization. And warn once on null dma buffer pointer during the
> > initialization.
> > 
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> 
> Looks good to me.
> 
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> 
> 
> BTW, the reason why this hasn't been hit on the legacy HD-audio driver
> is that we allocate usually with MSI, so the irq is isolated.
> 
> Any reason that Intel SKL driver doesn't use MST?

This I'm not sure. Vinod might have answer to it, according to
https://patchwork.kernel.org/patch/6375831/#13796611
