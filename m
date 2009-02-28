From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [PATCH] cs4270: add support for slave
	mode	configurations
Date: Sat, 28 Feb 2009 13:13:43 +0100
Message-ID: <20090228121343.GA18336@buzzloop.caiaq.de>
References: <1235569041-856-1-git-send-email-daniel@caiaq.de>
	<ed82fe3e0902271351nc170b16v71b81754f8aeadd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E6B51037F1
	for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2009 13:13:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ed82fe3e0902271351nc170b16v71b81754f8aeadd3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 27, 2009 at 03:51:58PM -0600, Timur Tabi wrote:
> > +       /* set master/slave audio interface */
> > +       switch (format & SND_SOC_DAIFMT_MASTER_MASK) {
> > +       case SND_SOC_DAIFMT_CBS_CFS:
> > +               cs4270->slave_mode = 1;
> > +               break;
> > +       case SND_SOC_DAIFMT_CBM_CFM:
> > +               cs4270->slave_mode = 0;
> > +               break;
> > +       case SND_SOC_DAIFMT_CBM_CFS:
> > +               /* unsupported - cs4270 can eigther be slave or master to
> 
> Typo.  However, I suggest you get rid of the "case
> SND_SOC_DAIFMT_CBM_CFS" and in the "default:", just have this:
> 
> > +       default:
>                    /* all other modes are unsupported by the hardware */
> > +               ret = -EINVAL;
> > +       }
> > +

Ok, I'll post a patch for this.

> >        reg = snd_soc_read(codec, CS4270_MODE);
> >        reg &= ~(CS4270_MODE_SPEED_MASK | CS4270_MODE_DIV_MASK);
> > -       reg |= cs4270_mode_ratios[i].speed_mode | cs4270_mode_ratios[i].mclk;
> > +       reg |= cs4270_mode_ratios[i].mclk;
> > +
> > +       if (cs4270->slave_mode)
> > +               reg |= CS4270_MODE_SLAVE;
> > +       else
> > +               reg |= cs4270_mode_ratios[i].speed_mode;
> 
> Are you sure that the mclk bits are still correct in slave mode?  I'm
> looking at table 5 in the CS4270 manual, and it lists settings for
> 1x,2x,4x speed even though the register is set to slave mode instead.

Hmm - mclk bits are set with 'reg |= cs4270_mode_ratios[i].mclk;'
unconditionally, and both speed flags are used when in slave mode. Don't
see where you suspect a flaw here?

Daniel
