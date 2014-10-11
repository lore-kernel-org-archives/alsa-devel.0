From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 2/2] ALSA: au88x0: pr_* replaced with
 dev_*
Date: Sat, 11 Oct 2014 03:48:11 -0700
Message-ID: <1413024491.16385.10.camel@joe-AO725>
References: <1412930199-24797-1-git-send-email-sudipm.mukherjee@gmail.com>
 <1412930199-24797-2-git-send-email-sudipm.mukherjee@gmail.com>
 <CAN8ccibSw_85wdnxbNSKfjXQ-7Lg3C6_5fhKQJJi5xMi8pMabA@mail.gmail.com>
 <20141011090903.GC8231@sudip-PC>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0228.hostedemail.com
 [216.40.44.228])
 by alsa0.perex.cz (Postfix) with ESMTP id 91553260586
 for <alsa-devel@alsa-project.org>; Sat, 11 Oct 2014 12:48:15 +0200 (CEST)
In-Reply-To: <20141011090903.GC8231@sudip-PC>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2014-10-11 at 14:39 +0530, Sudip Mukherjee wrote:
> On Sat, Oct 11, 2014 at 03:20:56PM +0800, Raymond Yau wrote:
> > >
> > > pr_* macros replaced with dev_* as they are more preffered over pr_*.
> > > each file which had pr_* was reviewed manually and replaced with dev_*.
> > > here we have actually used the reference of the vortex which was added
> > > to some functions in the previous patch of this series.
> > >
> > > The prefix of the CARD_NAME and prefix of "vortex:" was also
> > > removed as the dev_* will print the device name.
> > >
> > > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > > ---
> > >
> > 
> > >  static int vortex_core_init(vortex_t *vortex)
> > >  {
> > >
> > > -       pr_info( "Vortex: init.... ");
> > > +       dev_info(vortex->card->dev, "init.... ");
> > 
> > Is it possible to add linefeed  since "done/n" won't appear in the same
> > line with init nor shutdown?
> > 
> should we add linefeed ?
> as of now it will print init.... then it will print done as the init is complete.
> so dmesg will show us:
> 
> init....done.
> 
> same for shutdown.
> but if we give linefeed , then it will become : 
> 
> init....
> done.
> 
> the meaning will be lost. and many user might just wonder what is done ? 
[]
> > > @@ -2738,7 +2744,7 @@ static int vortex_core_init(vortex_t *vortex)
> > >  static int vortex_core_shutdown(vortex_t * vortex)
> > >  {
> > >
> > > -       pr_info( "Vortex: shutdown...");
> > > +       dev_info(vortex->card->dev, "shutdown...");
> > >  #ifndef CHIP_AU8820
> > >         vortex_eq_free(vortex);
> > >         vortex_Vort3D_disable(vortex);
> > > @@ -2760,7 +2766,7 @@ static int vortex_core_shutdown(vortex_t * vortex)
> > >         msleep(5);
> > >         hwwrite(vortex->mmio, VORTEX_IRQ_SOURCE, 0xffff);
> > >
> > > -       pr_info( "done.\n");
> > > +       dev_info(vortex->card->dev, "done.\n");
> > >         return 0;
> > >  }

It's actually on 2 lines before your patch.

	pr_info("a");
	pr_info("b\n");

already emits 2 separate lines.

	pr_info("a");
	pr_cont("b\n");

emits a single line "ab"
(unless some other thread emits something in-between)

pr_cont or a bare printk can be used after a dev_info
without a newline to avoid unwanted newlines.
