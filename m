From: "Ted T. Logan" <tedtheologian@gmail.com>
Subject: Re: snd-ctxfi oops
Date: Wed, 17 Jun 2009 19:17:41 -0500
Message-ID: <1245284261.3419.0.camel@localhost.localdomain>
References: <4A31D0F6.5080901@gmail.com>	<s5hr5xpvry1.wl%tiwai@suse.de>
	<4A329D02.8070202@gmail.com>	<4A334194.6030704@gmail.com>
	<s5hk53glfoq.wl%tiwai@suse.de>	<s5hzlc9ejvc.wl%tiwai@suse.de>
	<4A3645C9.40804@gmail.com>	<s5hvdmxejos.wl%tiwai@suse.de>
	<s5htz2hejmx.wl%tiwai@suse.de>  <4A38EAF5.8030808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BF391037ED
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Jun 2009 02:17:34 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 4so298869ywq.2
	for <alsa-devel@alsa-project.org>; Wed, 17 Jun 2009 17:17:33 -0700 (PDT)
In-Reply-To: <4A38EAF5.8030808@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: The Source <thesourcehim@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I upgraded to this new snapshot and have the same click every 1.5
seconds on every single application with my x-fi.

I'm just confused as to why this didn't occur at all with the old
driver, as in, was something strange introduced?

On Wed, 2009-06-17 at 17:09 +0400, The Source wrote:

> On 15.06.2009 17:01, Takashi Iwai wrote:
> > At Mon, 15 Jun 2009 15:00:03 +0200,
> > I wrote:
> >    
> >> At Mon, 15 Jun 2009 16:59:53 +0400,
> >> The Source wrote:
> >>      
> >>> On 15.06.2009 16:56, Takashi Iwai wrote:
> >>>        
> >>>> At Sat, 13 Jun 2009 10:07:49 +0200,
> >>>> I wrote:
> >>>>
> >>>>          
> >>>>>
> >>>>>            
> >>>>>> Tested the patch more. Really no oopses. Instead of them I get rare
> >>>>>> system lockups.
> >>>>>>
> >>>>>>              
> >>>>> In which situation, exactly?
> >>>>> Could you check whether it happens with use_system_timer=1 module
> >>>>> option, too?
> >>>>>
> >>>>>            
> >>>> Or try the very latest alsa-driver-snapshot (not daily tarball).
> >>>> I fixed a deadlock issue in cttimer.c now.
> >>>>
> >>>>
> >>>> thanks,
> >>>>
> >>>> Takashi
> >>>>
> >>>>
> >>>>          
> >>> Should I apply that patch to this snapshot?
> >>>        
> >> Which patch do you mean?
> >> Just grab the latest alsa-driver-snapshot.tar.gz from
> >>      ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/
> >>      
> > Also, check alsa-driver/alsa-kernel/HEAD whether the commit
> >     8dca419721d188bfee5f19fad45275856c619a5c
> >       ALSA: ctxfi - Fix deadlock with xfi-timer
> > is included.
> >
> >
> > Takashi
> >
> >    
> Tested the driver and it's fine so far. No craches with any application 
> including Doom 3, which caused system lockups often with earlier 
> versions of the driver.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
