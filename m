From: "Adrian McMenamin" <adrianmcmenamin@gmail.com>
Subject: Re: [PATCH] ALSA sound driver for SEGA Dreamcast AICA
	(pcm)
Date: Tue, 15 May 2007 22:31:15 +0100
Message-ID: <92a12cdb0705151431r57cdd98cq9b77e218f5293214@mail.gmail.com>
References: <92a12cdb0705141514v4c928041i6030267fd322e87@mail.gmail.com>
	<20070515004751.GD10873@zakalwe.fi>
	<92a12cdb0705151430o66e11fc3m2ec0abd423dc4a6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F95E2441C
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2007 23:31:17 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id l8so296703nzf
	for <alsa-devel@alsa-project.org>; Tue, 15 May 2007 14:31:16 -0700 (PDT)
In-Reply-To: <92a12cdb0705151430o66e11fc3m2ec0abd423dc4a6e@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Heikki Orsila <shdl@zakalwe.fi>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linuxsh-dev@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 15/05/07, Adrian McMenamin <adrianmcmenamin@gmail.com> wrote:
> On 15/05/07, Heikki Orsila <shdl@zakalwe.fi> wrote:
> > I still noticed some type cleanups, and possibly a good debug message..
> >
> > On Mon, May 14, 2007 at 11:14:55PM +0100, Adrian McMenamin wrote:
> > > +/* spu_memload - write to SPU address space */
> > > +static void spu_memload(u32 toi, void __iomem * from, int length)
> > > +{
> > > +     u32 __iomem *froml = from;
> > > +     u32 __iomem *to = (u32 __iomem *) (SPU_MEMORY_BASE + toi);
> > > +     int i, val;
> >
> > You should use "void *from" because it's not IO memory. Also, use "u32 val"
> > since that is the native type of "u32 *from".
> >
> > > +     length = DIV_ROUND_UP(length, 4);
> > > +     spu_write_wait();
> > > +     for (i = 0; i < length; i++) {
> > > +             val = *froml;
> > > +             writel(val, to);
> > > +             froml++;
> > > +             to++;
> > > +             if (i && !(i % 8))
> > > +                     spu_write_wait();
> > > +     }
> > > +}
> >
> > It seems a small simplification is possible:
> >
> >         /* remove first spu_write_wait(); */
> >         for (i = 0; i < length; i++) {
> >                 if (!(i % 8))
> >                         spu_write_wait();
> >                 val = *froml;
> >                 ...
> >         }
> >
>
> No, that would be dangerous because we don't know what state the FIFO
> is in when this is called.
>


Sorry, should think before I post!
