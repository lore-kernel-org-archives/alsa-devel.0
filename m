From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: mm snapshot broken-out-2007-03-05-02-22.tar.gz
	uploaded
Date: Thu, 8 Mar 2007 18:05:05 +0100
Message-ID: <6bffcb0e0703080905n7395efb0xed62455659fd088d@mail.gmail.com>
References: <200703051024.l25AOIF3015951@shell0.pdx.osdl.net>
	<6bffcb0e0703071141j42309702w793e4a76b1b23bfa@mail.gmail.com>
	<20070307115024.756c848f.akpm@linux-foundation.org>
	<s5hvehcrdod.wl%tiwai@suse.de> <45EF3B2C.9060801@googlemail.com>
	<s5hfy8gbrmj.wl%tiwai@suse.de> <45F02EE2.6040606@googlemail.com>
	<s5h8xe7ognj.wl%tiwai@suse.de>
	<6bffcb0e0703080852l4a06c0f9qeb51044a7a1a68a@mail.gmail.com>
	<s5hwt1rn0aj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by alsa0.perex.cz (Postfix) with ESMTP id B989924397
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2007 18:05:16 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id j3so970591ugf
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2007 09:05:07 -0800 (PST)
In-Reply-To: <s5hwt1rn0aj.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@linux-foundation.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On 08/03/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 8 Mar 2007 17:52:43 +0100,
> Michal Piotrowski wrote:
> >
> > On 08/03/07, Takashi Iwai <tiwai@suse.de> wrote:
> > > At Thu, 08 Mar 2007 16:42:26 +0100,
> > > Michal Piotrowski wrote:
> > > >
> > > > > Also, it'd be helpful if you compare
> > > > > /proc/asound/card0/codec97#0/ac97#0-0+regs file before and after the
> > > > > patch.  This reveals which register bits differ actually.
> > > >
> > > > a2.txt is form 2.6.21-rc3 witchout 831466f4ad2b5fe23dff77edbe6a7c244435e973
> > > >
> > > > diff -uprN a2.txt /proc/asound/card0/codec97#0/ac97#0-0+regs
> > > > --- a2.txt      2007-03-08 16:36:47.000000000 +0100
> > > > +++ /proc/asound/card0/codec97#0/ac97#0-0+regs  2007-03-08 16:36:49.447083597 +0100
> > > > @@ -56,8 +56,8 @@
> > > >  0:6e = 0000
> > > >  0:70 = 0000
> > > >  0:72 = 0004
> > > > -0:74 = 1001
> > > > -0:76 = 64a4
> > > > +0:74 = 1201
> > > > +0:76 = 7ca4
> > > >  0:78 = 000c
> > > >  0:7a = 0000
> > > >  0:7c = 4144
> > >
> > > OK, some wrong bits there.  Could you try the patch below?
> >
> > Problem fixed. Thanks!
> >
> > (speaker-test -c6 -Dplug:surround51 is still broken)
>
> Hm, how about turning off "Spread Front To..." control and run
> speaker-test?

Now I've got:
rear left as center
rear right as LFE

:)

>
>
> Takashi
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group (PL)
(http://www.stardust.webpages.pl/ltg/)
LTG - Linux Testers Group (EN)
(http://www.stardust.webpages.pl/linux_testers_group_en/)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
