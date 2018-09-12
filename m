From: Vinod <vkoul@kernel.org>
Subject: Re: [PATCH 2/3] sound: enable interrupt after dma buffer
 initialization
Date: Wed, 12 Sep 2018 09:34:56 +0530
Message-ID: <20180912040456.GD2766@vkoul-mobl>
References: <20180910211718.200802-1-yuzhao@google.com>
 <20180910212150.202655-1-yuzhao@google.com>
 <s5hbm9436va.wl-tiwai@suse.de>
 <20180911205825.GB18086@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180911205825.GB18086@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yu Zhao <yuzhao@google.com>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 11-09-18, 14:58, Yu Zhao wrote:
> On Tue, Sep 11, 2018 at 08:06:49AM +0200, Takashi Iwai wrote:
> > On Mon, 10 Sep 2018 23:21:50 +0200,
> > Yu Zhao wrote:
> > > 
> > > In snd_hdac_bus_init_chip(), we enable interrupt before
> > > snd_hdac_bus_init_cmd_io() initializing dma buffers. If irq has
> > > been acquired and irq handler uses the dma buffer, kernel may crash
> > > when interrupt comes in.
> > > 
> > > Fix the problem by postponing enabling irq after dma buffer
> > > initialization. And warn once on null dma buffer pointer during the
> > > initialization.
> > > 
> > > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > 
> > Looks good to me.
> > 
> > Reviewed-by: Takashi Iwai <tiwai@suse.de>
> > 
> > 
> > BTW, the reason why this hasn't been hit on the legacy HD-audio driver
> > is that we allocate usually with MSI, so the irq is isolated.
> > 
> > Any reason that Intel SKL driver doesn't use MST?
> 
> This I'm not sure. Vinod might have answer to it, according to
> https://patchwork.kernel.org/patch/6375831/#13796611

IIRC (seemed quite some time back) we faced issues with using MSI on SKL
and didnt try afterwards. If Intel folks can try it and check. Pierre is
out, maybe Liam can help..?

-- 
~Vinod
