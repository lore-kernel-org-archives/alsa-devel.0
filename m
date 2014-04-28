From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 1/2] fm801: introduce macros to access the
	hardware
Date: Mon, 28 Apr 2014 14:21:58 +0300
Message-ID: <CAHp75Ve6mt_ypHFBg6a+gHEv8+by6DBeT4PaH158aouqN18NbQ@mail.gmail.com>
References: <1398672030-29565-1-git-send-email-andy.shevchenko@gmail.com>
 <s5hy4ypbvrg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yk0-f174.google.com (mail-yk0-f174.google.com
 [209.85.160.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F883264F3D
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 13:21:59 +0200 (CEST)
Received: by mail-yk0-f174.google.com with SMTP id 20so5543438yks.33
 for <alsa-devel@alsa-project.org>; Mon, 28 Apr 2014 04:21:58 -0700 (PDT)
In-Reply-To: <s5hy4ypbvrg.wl%tiwai@suse.de>
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

On Mon, Apr 28, 2014 at 1:20 PM, Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 28 Apr 2014 11:00:29 +0300,
> Andy Shevchenko wrote:
> >
> > It will help to maintain HW accessors and, for example, switch from the
> > direct I/O to MMIO which is more convenient for PCI devices.
> >
> > Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> >  sound/pci/fm801.c | 131
> ++++++++++++++++++++++++++++--------------------------
> >  1 file changed, 68 insertions(+), 63 deletions(-)
> >
> > diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
> > index db18cca..8418484 100644
> > --- a/sound/pci/fm801.c
> > +++ b/sound/pci/fm801.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/init.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/io.h>
> >  #include <linux/pci.h>
> >  #include <linux/slab.h>
> >  #include <linux/module.h>
> > @@ -34,8 +35,6 @@
> >  #include <sound/opl3.h>
> >  #include <sound/initval.h>
> >
> > -#include <asm/io.h>
> > -
> >  #ifdef CONFIG_SND_FM801_TEA575X_BOOL
> >  #include <media/tea575x.h>
> >  #endif
> > @@ -80,7 +79,10 @@ MODULE_PARM_DESC(radio_nr, "Radio device numbers");
> >   *  Direct registers
> >   */
> >
> > -#define FM801_REG(chip, reg) (chip->port + FM801_##reg)
> > +#define fm801_writew(v,chip,reg)     outw((v), chip->port + FM801_##reg)
> > +#define fm801_readw(chip,reg)                inw(chip->port +
> FM801_##reg)
> > +
> > +#define fm801_writel(v,chip,reg)     outl((v), chip->port + FM801_##reg)
>
> IMO, it's better in a form like fm801_writel(chip, reg, value)


 Will change this in v2.


> thanks,
>
> Takashi
>



-- 
With Best Regards,
Andy Shevchenko
