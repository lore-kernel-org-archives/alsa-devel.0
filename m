From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: [PATCH] snd/hda: fix use-after-free after module
	unload
Date: Mon, 11 Jul 2016 19:32:05 +0200
Message-ID: <20160711173205.GA4475@al>
References: <20160709143857.12044-1-peter@lekensteyn.nl>
 <s5h37ngv4ks.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lekensteyn.nl (lekensteyn.nl [178.21.112.251])
 by alsa0.perex.cz (Postfix) with ESMTP id B052F26573C
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 19:32:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h37ngv4ks.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 11, 2016 at 12:42:27PM +0200, Takashi Iwai wrote:
> On Sat, 09 Jul 2016 16:38:57 +0200,
> Peter Wu wrote:
> > 
> > register_vga_switcheroo() sets the PM ops from the hda structure which
> > is freed later in azx_free. Make sure that these ops are cleared.
> > 
> > Caught by KASAN.
> > 
> > Fixes: 246efa4a072f ("snd/hda: add runtime suspend/resume on optimus support (v4)")
> > Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> > ---
> >  sound/pci/hda/hda_intel.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index 94089fc..a339066 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -1219,6 +1219,7 @@ static int azx_free(struct azx *chip)
> >  			snd_hda_unlock_devices(&chip->bus);
> >  		if (hda->vga_switcheroo_registered)
> >  			vga_switcheroo_unregister_client(chip->pci);
> > +        vga_switcheroo_fini_domain_pm_ops(chip->card->dev);
> 
> The domain pm ops is set only when hda->vga_switcheroo_registered flag
> is set.  So the call should be in the previous if block.

Yes that would be cleaner, will do that.

> Also, the indentation looks wrong.  Please use the correct
> indentation.

Noticed too late that the editor config was wrong on the testing
machine.

> Could you resubmit with these fixes?

I will, thanks for the feedback!
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
