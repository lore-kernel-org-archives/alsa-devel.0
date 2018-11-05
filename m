From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] vga_switcheroo: Fix missing gpu_bound call
 at audio client registration
Date: Mon, 5 Nov 2018 14:38:42 +0100
Message-ID: <20181105133842.mpdawjtcliqkjjsc@wunner.de>
References: <20181105110253.8655-1-tiwai@suse.de>
 <20181105115517.56bclhhq2ctaps7u@wunner.de>
 <s5hzhun3cxg.wl-tiwai@suse.de>
 <20181105125937.nwbh6qjxkzo7rwap@wunner.de>
 <s5htvkv3c0l.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net
 [176.9.242.62]) by alsa0.perex.cz (Postfix) with ESMTP id 2B9ED2678DA
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2018 14:38:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5htvkv3c0l.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, alsa-devel@alsa-project.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 05, 2018 at 02:11:06PM +0100, Takashi Iwai wrote:
> On Mon, 05 Nov 2018 13:59:37 +0100, Lukas Wunner wrote:
> > On Mon, Nov 05, 2018 at 01:51:23PM +0100, Takashi Iwai wrote:
> > > On Mon, 05 Nov 2018 12:55:17 +0100, Lukas Wunner wrote:
> > > > On Mon, Nov 05, 2018 at 12:02:53PM +0100, Takashi Iwai wrote:
> > > > > diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
> > > > > index cf2a18571d48..a132c37d7334 100644
> > > > > --- a/drivers/gpu/vga/vga_switcheroo.c
> > > > > +++ b/drivers/gpu/vga/vga_switcheroo.c
> > > > > @@ -380,6 +380,9 @@ int vga_switcheroo_register_audio_client(struct pci_dev *pdev,
> > > > >  			mutex_unlock(&vgasr_mutex);
> > > > >  			return -EINVAL;
> > > > >  		}
> > > > > +		/* notify if GPU has been already bound */
> > > > > +		if (ops->gpu_bound)
> > > > > +			ops->gpu_bound(pdev, id);
> > > > >  	}
> > > > >  	mutex_unlock(&vgasr_mutex);
> > > > 
> > > > If the audio client registers before vga_switcheroo becomes enabled,
> > > > ->gpu_bound will be executed twice.
> > > 
> > > Is it?  The addition is in the if-block of vgasr_priv.active, so this
> > > is executed only when vga_switcheroo_enable() was already called
> > > beforehand.
> > 
> > Ugh, you're absolutely right, sorry for the noise.
> 
> OK, then let's queue the fix.
> 
> Would you take it and go through drm merges, or shall I take it via
> sound git tree?  I don't mind either way.

It looks like commit 37a3a98ef601 (which this one is fixing) went in
through the sound tree, so I think it makes sense to use it for this
patch as well.

Thanks,

Lukas
