From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v2 2/2] ALSA: au88x0: pr_* replaced with
 dev_*
Date: Sat, 11 Oct 2014 17:03:49 +0530
Message-ID: <20141011113349.GA9962@sudip-PC>
References: <1412930199-24797-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1412930199-24797-2-git-send-email-sudipm.mukherjee@gmail.com>
 <CAN8ccibSw_85wdnxbNSKfjXQ-7Lg3C6_5fhKQJJi5xMi8pMabA@mail.gmail.com>
 <20141011090903.GC8231@sudip-PC>
 <1413024491.16385.10.camel@joe-AO725>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F8532605C6
 for <alsa-devel@alsa-project.org>; Sat, 11 Oct 2014 13:34:04 +0200 (CEST)
Received: by mail-pd0-f178.google.com with SMTP id y10so3145521pdj.9
 for <alsa-devel@alsa-project.org>; Sat, 11 Oct 2014 04:34:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1413024491.16385.10.camel@joe-AO725>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>, h@sudip-PC.alsa-project.org
Cc: Raymond Yau <superquad.vortex2@gmail.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 11, 2014 at 03:48:11AM -0700, Joe Perches wrote:
> On Sat, 2014-10-11 at 14:39 +0530, Sudip Mukherjee wrote:
> > On Sat, Oct 11, 2014 at 03:20:56PM +0800, Raymond Yau wrote:
> > > >
<snip>
> > > > ---
> > > >
> > > 
> > > >  static int vortex_core_init(vortex_t *vortex)
> > > >  {
> > > >
> > > > -       pr_info( "Vortex: init.... ");
> > > > +       dev_info(vortex->card->dev, "init.... ");
> > > 
> > > Is it possible to add linefeed  since "done/n" won't appear in the same
> > > line with init nor shutdown?
> > > 
> > should we add linefeed ?
> > as of now it will print init.... then it will print done as the init is complete.
> > so dmesg will show us:
> > 
> > init....done.
> > 
> > same for shutdown.
> > but if we give linefeed , then it will become : 
> > 
> > init....
> > done.
> > 
> > the meaning will be lost. and many user might just wonder what is done ? 
> []
> > > > @@ -2738,7 +2744,7 @@ static int vortex_core_init(vortex_t *vortex)
> > > >  static int vortex_core_shutdown(vortex_t * vortex)
> > > >  {
> > > >
> > > > -       pr_info( "Vortex: shutdown...");
> > > > +       dev_info(vortex->card->dev, "shutdown...");
> > > >  #ifndef CHIP_AU8820
> > > >         vortex_eq_free(vortex);
> > > >         vortex_Vort3D_disable(vortex);
> > > > @@ -2760,7 +2766,7 @@ static int vortex_core_shutdown(vortex_t * vortex)
> > > >         msleep(5);
> > > >         hwwrite(vortex->mmio, VORTEX_IRQ_SOURCE, 0xffff);
> > > >
> > > > -       pr_info( "done.\n");
> > > > +       dev_info(vortex->card->dev, "done.\n");
> > > >         return 0;
> > > >  }
> 
> It's actually on 2 lines before your patch.
> 
> 	pr_info("a");
> 	pr_info("b\n");
> 
> already emits 2 separate lines.
> 
> 	pr_info("a");
> 	pr_cont("b\n");
> 
> emits a single line "ab"
> (unless some other thread emits something in-between)
> 
> pr_cont or a bare printk can be used after a dev_info
> without a newline to avoid unwanted newlines.

i think i was not thinking while writing the previous mail.
pr_info("a");
pr_info("b\n");
should print as "ab" , considering no other threads prints in between.
but after converting it to dev_info it will become :
"dev: adev: b".
and for our "init.... done" , it will become 
"au88x0: init.... au88x0: done."  ( i have ommited the driver name)

can't we do some thing like :
dev_info(vortex->card->dev, "init.... started\n");
dev_info(vortex->card->dev, "init....done\n");
then even if some other thread prints , then we will not loose the reference.

thanks
sudip
