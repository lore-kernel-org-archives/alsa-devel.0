From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: 2 speakers are assigned to the same DAC,
 this can't support 4.0/2.1 channles
Date: Fri, 12 Jun 2015 12:42:17 +0800
Message-ID: <CAN8ccibG1xtVdtV8c7f3mtooCYkpsaeySh4RkXbY1Gic6ZcfAg@mail.gmail.com>
References: <5576B419.5010505@canonical.com> <s5h1thlqeus.wl-tiwai@suse.de>
 <5576E994.2080300@canonical.com> <5577BAEE.50506@canonical.com>
 <s5h1thjoo14.wl-tiwai@suse.de> <s5hoakmjn6i.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 by alsa0.perex.cz (Postfix) with ESMTP id BC5D6266640
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 06:42:18 +0200 (CEST)
Received: by obbqz1 with SMTP id qz1so16243319obb.3
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 21:42:17 -0700 (PDT)
In-Reply-To: <s5hoakmjn6i.wl-tiwai@suse.de>
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
Cc: hwang4 <hui.wang@canonical.com>, alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> >
> > > >> A cleaner way would be to prepare a different badness table for the
> > > >> speaker, and increase the value for shared_surr.  An untested
patch is
> > > >> below.
> > > > Got it, I will test it soon. Thanks.
> > > >
> > > Hi Takashi,
> > >
> > > Your patch can fix the problem, it works very well.
> >
> > OK, good to know.  I'd like to test a bit more via hda-emu whether
> > this gives any ill effects.  So far, this seems fixing a few other
> > machines, too, so it's a good thing to have in general.
>
> This change alone results in regressions on machines that are capable
> of 4.0/5.1 surrounds.  For avoiding it, the badness for multi-io has
> to be increased as well.  It's damn sensitive.
>
> But, now I wonder now whether blindly applying this is good.  Suppose
> a machine with 2.1 speaker and one headphone, but the codec has only
> two DACs.  With this setup, now the headphone and the speaker share
> the same DAC, as the cost of having individual 2.1 speaker volume.
> Is this more useful than having individual volumes for speaker and
> headphone?

Some realtek codec e.g. alc262

Supports MONO line output with independent volume control

http://www.realtek.com.tw/products/productsView.aspx?Langid=1&PFid=27&Level=5&Conn=4&ProdID=40

Badness table cannot be applied to all realtek codecs
