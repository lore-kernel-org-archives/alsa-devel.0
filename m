From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v2 2/2] ALSA: au88x0: pr_* replaced with
 dev_*
Date: Sat, 11 Oct 2014 14:39:03 +0530
Message-ID: <20141011090903.GC8231@sudip-PC>
References: <1412930199-24797-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1412930199-24797-2-git-send-email-sudipm.mukherjee@gmail.com>
 <CAN8ccibSw_85wdnxbNSKfjXQ-7Lg3C6_5fhKQJJi5xMi8pMabA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f179.google.com (mail-pd0-f179.google.com
 [209.85.192.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 259812605C2
 for <alsa-devel@alsa-project.org>; Sat, 11 Oct 2014 11:09:11 +0200 (CEST)
Received: by mail-pd0-f179.google.com with SMTP id r10so2974084pdi.10
 for <alsa-devel@alsa-project.org>; Sat, 11 Oct 2014 02:09:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAN8ccibSw_85wdnxbNSKfjXQ-7Lg3C6_5fhKQJJi5xMi8pMabA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 11, 2014 at 03:20:56PM +0800, Raymond Yau wrote:
> >
> > pr_* macros replaced with dev_* as they are more preffered over pr_*.
> > each file which had pr_* was reviewed manually and replaced with dev_*.
> > here we have actually used the reference of the vortex which was added
> > to some functions in the previous patch of this series.
> >
> > The prefix of the CARD_NAME and prefix of "vortex:" was also
> > removed as the dev_* will print the device name.
> >
> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > ---
> >
> 
> >  static int vortex_core_init(vortex_t *vortex)
> >  {
> >
> > -       pr_info( "Vortex: init.... ");
> > +       dev_info(vortex->card->dev, "init.... ");
> 
> Is it possible to add linefeed  since "done/n" won't appear in the same
> line with init nor shutdown?
> 
should we add linefeed ?
as of now it will print init.... then it will print done as the init is complete.
so dmesg will show us:

init....done.

same for shutdown.
but if we give linefeed , then it will become : 

init....
done.

the meaning will be lost. and many user might just wonder what is done ? 

thanks
sudip

> >         /* Hardware Init. */
> >         hwwrite(vortex->mmio, VORTEX_CTRL, 0xffffffff);
> >         msleep(5);
> > @@ -2729,7 +2735,7 @@ static int vortex_core_init(vortex_t *vortex)
> >         //vortex_enable_timer_int(vortex);
> >         //vortex_disable_timer_int(vortex);
> >
> > -       pr_info( "done.\n");
> > +       dev_info(vortex->card->dev, "done.\n");
> >         spin_lock_init(&vortex->lock);
> >
> >         return 0;
> > @@ -2738,7 +2744,7 @@ static int vortex_core_init(vortex_t *vortex)
> >  static int vortex_core_shutdown(vortex_t * vortex)
> >  {
> >
> > -       pr_info( "Vortex: shutdown...");
> > +       dev_info(vortex->card->dev, "shutdown...");
> >  #ifndef CHIP_AU8820
> >         vortex_eq_free(vortex);
> >         vortex_Vort3D_disable(vortex);
> > @@ -2760,7 +2766,7 @@ static int vortex_core_shutdown(vortex_t * vortex)
> >         msleep(5);
> >         hwwrite(vortex->mmio, VORTEX_IRQ_SOURCE, 0xffff);
> >
> > -       pr_info( "done.\n");
> > +       dev_info(vortex->card->dev, "done.\n");
> >         return 0;
> >  }
> >
