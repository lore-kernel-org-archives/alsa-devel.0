From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v4 2/5] ALSA: ctxfi: initialized snd_card
Date: Tue, 23 Sep 2014 20:16:45 +0530
Message-ID: <20140923144644.GA19585@sudip-PC>
References: <1411470024-25244-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1411470024-25244-2-git-send-email-sudipm.mukherjee@gmail.com>
 <s5ha95q5szf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
 [209.85.192.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 86D3E26508D
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 16:46:56 +0200 (CEST)
Received: by mail-pd0-f179.google.com with SMTP id ft15so6558298pdb.24
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 07:46:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5ha95q5szf.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 23, 2014 at 04:09:08PM +0200, Takashi Iwai wrote:
> At Tue, 23 Sep 2014 16:30:21 +0530,
> Sudip Mukherjee wrote:
> > 
> > initialized the reference of snd_card which was added to the various
> > structures through the previous patch of the series.
> > these references of snd_card will be used in a later patch to convert
> > the pr_* macros to dev_*
> > 
> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > ---
> >  sound/pci/ctxfi/ctamixer.c | 2 ++
> >  sound/pci/ctxfi/ctatc.c    | 1 +
> >  sound/pci/ctxfi/ctdaio.c   | 1 +
> >  sound/pci/ctxfi/ctsrc.c    | 2 ++
> >  4 files changed, 6 insertions(+)
> > 
> > diff --git a/sound/pci/ctxfi/ctamixer.c b/sound/pci/ctxfi/ctamixer.c
> > index fed6e6a..dc89fad 100644
> > --- a/sound/pci/ctxfi/ctamixer.c
> > +++ b/sound/pci/ctxfi/ctamixer.c
> > @@ -314,6 +314,7 @@ int amixer_mgr_create(void *hw, struct amixer_mgr **ramixer_mgr)
> >  
> >  	amixer_mgr->get_amixer = get_amixer_rsc;
> >  	amixer_mgr->put_amixer = put_amixer_rsc;
> > +	amixer_mgr->card = ((struct hw *)hw)->card;
> 
> Overall the patches became obviously better now, but unfortunately
> we still see such rather stupid cast occasionally.  I guess you
> considered reducing these?
frankly speaking , i did not think to reduce that untill now that u mentioned it.
I was thinking it was there for a reason and will be used like the private_data,
but i was not able to think of any reason as everywhere it is struct hw.

thanks
sudip

> 
> Then start thinking from the scratch: why the cast is needed at all?
> It's because the driver uses the void pointer for hw objects.  Why?
> The driver author tried to separate the code abstraction, and thought
> to pass the arbitrary hw object.
> 
> Such abstraction would be good if really different objects are
> handled.  OTOH, in ctxfi case, we know that we deal with only a single
> hw type.  So, using void * for hw object is rather error-prone, and
> the code safety can be even improved by strict typing.
> 
> That said, replacing void * with struct hw * or such would make things
> not only easier but also safer.
> 
> BTW, the patch 5 is basically independent from the rest, and it's good
> enough, so I applied it now.  At the next respin, please drop that
> patch from your series.
> 
> 
> thanks,
> 
> Takashi
