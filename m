From: "Piotr Zaryk" <pzaryk@gmail.com>
Subject: Re: Patch - ESI Maya44 driver
Date: Sat, 5 Apr 2008 10:07:51 +0200
Message-ID: <e5888dbe0804050107o54ca8e8dne8d6fdd766d9d843@mail.gmail.com>
References: <47E39BB5.70301@lightshed.de> <s5heja3158m.wl%tiwai@suse.de>
	<47ED5E29.4040400@lightshed.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DD2B24725
	for <Alsa-devel@alsa-project.org>;
	Sat,  5 Apr 2008 10:07:54 +0200 (CEST)
Received: by py-out-1112.google.com with SMTP id w49so1276781pyg.36
	for <Alsa-devel@alsa-project.org>; Sat, 05 Apr 2008 01:07:53 -0700 (PDT)
In-Reply-To: <47ED5E29.4040400@lightshed.de>
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
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Will be the patch finally included to alsa?

2008/3/28, Rainer Zimmermann <mail@lightshed.de>:
>
>
> Hi Takashi,
>
> sorry about this. here's the fixed patch, identical to the last except for
> the coding style fixes.
>
> -Rainer
>
>
> Takashi Iwai wrote:
>
> > At Fri, 21 Mar 2008 12:27:49 +0100,
> > Rainer Zimmermann wrote:
> >
> > > Hi Takashi,
> > >
> > > here's the maya44 patch.
> > >
> > > This is a patch against the current alsa-kernel tree.
> > >
> >
> > Thanks.  This looks better than the previous version.
> >
> >  I did add 2 definitions to ice1712.h (snd_ice1724_get_route_val and
> > > snd_ice1724_put_route_val), which allowed me to move some of the maya=
44
> > > specific code to maya44.c .
> > >
> >
> > We could do it in a bit cleaer way, but I think it's OK as is.
> >
> >  There are still a few maya44 special cases in ice1724.c, because maya44
> > > uses the "con" channel and routing switches differently. This is not =
really
> > > clean style I think, but I would suggest sorting this out later, as i=
t would
> > > again require larger changes to ice1724.c and testing with other hard=
ware.
> > >
> >
> > Agreed.  This kind of clean up can be done later.
> >
> >  Hope everything is ok with you, for now.
> > >
> > > This patch does *not* limit the sampling rate to 96kHz for capture, as
> > > discussed before.
> > >
> >
> > The patch looks apparently not compliant to the kernel coding style.
> > Could you fix at least the issues reported by checkpatch.pl (the
> > latest one)?
> >
> >
> > thanks,
> >
> > Takashi
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> >
>
> --
> Lightshed IT Services
> L=F6fflerstr. 27, 22765 Hamburg, Germany * mail@lightshed.de *
> www.lightshed.de
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
>


-- =

Regards,
Piotr Zaryk
