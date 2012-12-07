From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: [FT C400, PATCH RFC,
	v4 00/10] M-Audio Fast Track C400
Date: Fri, 7 Dec 2012 16:03:12 +0100
Message-ID: <CAFz=ag41Bg4Ga2ObctxLysxSzMoAPoYh5Zx3XvenGndakJ0Mbw@mail.gmail.com>
References: <1354143341-1623-1-git-send-email-eldad@fogrefinery.com>
 <s5hlidkalpp.wl%tiwai@suse.de>
 <alpine.LNX.2.00.1211301453320.2669@xoschi>
 <s5hr4nbmb2t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E5B9265005
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2012 16:03:13 +0100 (CET)
Received: by mail-oa0-f51.google.com with SMTP id n12so446282oag.38
 for <alsa-devel@alsa-project.org>; Fri, 07 Dec 2012 07:03:12 -0800 (PST)
In-Reply-To: <s5hr4nbmb2t.wl%tiwai@suse.de>
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
Cc: Grant Diffey <gdiffey@gmail.com>, Chris Cavey <chris-alsa@rauros.net>, Eldad Zack <eldad@fogrefinery.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel <alsa-devel@alsa-project.org>, Daniel Mack <zonque@gmail.com>, George Willian Condomitti <georgecondomitti@gmail.com>
List-Id: alsa-devel@alsa-project.org

Sorry for being late on this. I've just tested Takashi's kernel with your
patches included. Everything seems fine for the FTU 8R.


Kind regards,
Felix


2012/11/30 Takashi Iwai <tiwai@suse.de>

> At Fri, 30 Nov 2012 15:06:00 +0100 (CET),
> Eldad Zack wrote:
> >
> >
> > Hi Takashi,
> >
> > On Thu, 29 Nov 2012, Takashi Iwai wrote:
> > > At Wed, 28 Nov 2012 23:55:31 +0100,
> > > Eldad Zack wrote:
> > > >
> > > > * Incoroprated the feedback from Clemens Ladisch <clemens@ladisch.de
> >:
> > > > Moved the quirks structure to the right place (also in other places,
> though
> > > > not strictly required) and removed the "set quirks" log messages.
> > > > Thanks, Clemens!
> > > >
> > > > * Added a patch to address the regression introduced by commit
> > > > 947d299686aa9cc8aecf749d54e8475c6e498956 , "ALSA: snd-usb: properly
> initialize
> > > > the sync endpoint". I believe there are no other devices that
> affected by this
> > > > issue. Opening only the playback stream without first opening the
> capture
> > > > stream now works with the C400.
> > >
> > > Thanks.  I applied all patches except for the new one (2/10 usb-audio:
> > > correct sync ep init).  This patch needs a bit more care, as it
> > > seems.
> > >
> > > I know it must be fixed for FT C400 but the fix itself is independent
> > > from others, so I merged others first to the rest work easier.
> >
> > Thanks! That's great, now I only need to concentrate on this one
> > issue. I went through your helpful comments and I'll try to work out a
> > better patch soon and send it for review.
> > Should I wait with it until the 3.8 merge window closes?
>
> Your other patches have been already merged, so better be quick, so
> that the last piece can be put in to 3.8, too :)
>
> > BTW - given that the code is old, isn't it time to slightly change
> > these? :)
> >
> > card.c: *   (Tentative) USB Audio Driver for ALSA
> > mixer.c: *   (Tentative) USB Audio Driver for ALSA
> > usbaudio.h: *   (Tentative) USB Audio Driver for ALSA
>
> Yes, clean up patches are welcome.  But these are in a lower priority,
> so will be queued for 3.9 later.
>
>
> thanks,
>
> Takashi
>
