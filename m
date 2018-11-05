From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] vga_switcheroo: Fix missing gpu_bound call
 at audio client registration
Date: Mon, 5 Nov 2018 13:59:37 +0100
Message-ID: <20181105125937.nwbh6qjxkzo7rwap@wunner.de>
References: <20181105110253.8655-1-tiwai@suse.de>
 <20181105115517.56bclhhq2ctaps7u@wunner.de>
 <s5hzhun3cxg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net
 [83.223.95.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 613EF267692
 for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2018 13:59:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hzhun3cxg.wl-tiwai@suse.de>
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

On Mon, Nov 05, 2018 at 01:51:23PM +0100, Takashi Iwai wrote:
> On Mon, 05 Nov 2018 12:55:17 +0100, Lukas Wunner wrote:
> > On Mon, Nov 05, 2018 at 12:02:53PM +0100, Takashi Iwai wrote:
> > > diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
> > > index cf2a18571d48..a132c37d7334 100644
> > > --- a/drivers/gpu/vga/vga_switcheroo.c
> > > +++ b/drivers/gpu/vga/vga_switcheroo.c
> > > @@ -380,6 +380,9 @@ int vga_switcheroo_register_audio_client(struct pci_dev *pdev,
> > >  			mutex_unlock(&vgasr_mutex);
> > >  			return -EINVAL;
> > >  		}
> > > +		/* notify if GPU has been already bound */
> > > +		if (ops->gpu_bound)
> > > +			ops->gpu_bound(pdev, id);
> > >  	}
> > >  	mutex_unlock(&vgasr_mutex);
> > 
> > If the audio client registers before vga_switcheroo becomes enabled,
> > ->gpu_bound will be executed twice.
> 
> Is it?  The addition is in the if-block of vgasr_priv.active, so this
> is executed only when vga_switcheroo_enable() was already called
> beforehand.

Ugh, you're absolutely right, sorry for the noise.

Lukas
