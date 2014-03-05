From: Chris M <cmanougian@yahoo.com>
Subject: Re: Update patch for codecs alias name for Dell
Date: Wed, 5 Mar 2014 07:16:43 +0000 (UTC)
Message-ID: <loom.20140305T080332-615@post.gmane.org>
References: <8837DB3485424EB4ADE016301C6D7DF6@realtek.com.tw>
 <s5hhaay6rsk.wl%tiwai@suse.de>
 <13CB35BE00B34161858F09AF4314495C@realtek.com.tw>
 <s5heh604wws.wl%tiwai@suse.de> <loom.20140202T011505-437@post.gmane.org>
 <loom.20140218T221659-931@post.gmane.org> <s5h1tywv7n1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 1280A265026
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 08:17:10 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1WL64j-0000h1-3M
 for alsa-devel@alsa-project.org; Wed, 05 Mar 2014 08:17:09 +0100
Received: from pool-173-79-166-34.washdc.fios.verizon.net ([173.79.166.34])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 05 Mar 2014 08:17:09 +0100
Received: from cmanougian by pool-173-79-166-34.washdc.fios.verizon.net with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Wed, 05 Mar 2014 08:17:09 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai <at> suse.de> writes:

> 
> At Tue, 18 Feb 2014 21:31:07 +0000 (UTC),
> Chris M wrote:
> > 
> > Chris M <cmanougian <at> yahoo.com> writes:
> > 
> > > 
> > > Takashi Iwai <tiwai <at> suse.de> writes:
> > > 
> > > > 
> > > > At Thu, 28 Nov 2013 15:30:56 +0800,
> > > > Kailang wrote:
> > > > > 
> > > > > Hi Takashi,
> > > > > 
> > > > > I remodified the code as belowing.
> > > > > 
> > > > > >From 888b51395ebab411660401f856e3af7988d9240b Mon Sep 17 00:00:00
2001
> > > > > From: Kailang Yang <kailang <at> realtek.com>
> > > > > Date: Thu, 28 Nov 2013 15:23:20 +0800
> > > > > Subject: [PATCH] ALSA: hda/realtek - Add more codecs alias name
for Dell
> > > > > 
> > > > > Dell assigned alias name for more codecs.
> > > > > ALC3220 ALC3221 ALC3223 ALC3226 ALC3234 ALC3661.
> > > > > 
> > > > > Signed-off-by: Kailang Yang <kailang <at> realtek.com>
> > > > 
> > > > Thanks, applied now, but it's targeted for 3.14 kernel, as this is no
> > > > urgent fixes.  You can find it in for-next branch of sound git tree.
> > > > 
> > > > Takashi
> > > > 
> > > 
> > > Sorry for asking this on a developer forum, but I'm pretty sure I finally
> > > found the answer here. I had considered the need to wait it out for a
kernel
> > > upgrade (beyond 3.12 in Debian Testing/Jessie). I have no sound right now.
> > > How do I apply this patch? When I installed Debian Testing, I installed a
> > > targeted initrd, and I was considering retrying with a generic initrd -
> > > although I think this thread just saved me from that. Will an established
> > > initrd come into play? Will I have to recompile the 3.12 kernel?
> > > 
> > > The Dell codec alias name is ALC3223.
> > > 
> > > Thanks
> > 
> > This is a follow up question for anyone.
> > 
> > This boils down to a general question about new kernel compilation.
> > 
> > To try and solve my no sound issue, I waited until 3.14-rc3 kernel went
live.
> > 
> > In the 3.14-rc3 kernel source folder, this patch is located at:
> > sound/pci/hda/patch_realtek.c
> > 
> > I thought that simply compiling the latest kernel, and then installing it,
> > would apply all relevant patches (more than the realtek patch may be in
> > play), but now I'm not so sure.
> > 
> > The question is this: Does a 3.14-rc3 compiled kernel already include the
> > above patch? Or, because it is labeled as a "patch" within the source, do I
> > have to actually patch the source before compiling?
> 
> Yes, it's already included in 3.14-rc3.
> 
> But I doubt it'll help anything for your "audio" problem.  The patch
> merely changes the codec name string, nothing else.  You're chasing a
> wrong fish.
> 
> Takashi

Takashi, yes, the new codec did show up in alsamixer. I'm pretty sure it's
hardware recognition.  My card in debian testing with the latest RC5 kernel is:

chris@inspiron:~$ inxi -A
Audio: Card-1: Intel Lynx Point-LP HD Audio Controller driver: snd_hda_intel
Sound: ALSA ver: k3.14.0-rc3
Card-2: Intel Haswell-ULT HD Audio Controller driver: snd_hda_intel


If I boot up in Xubuntu, the codec is "wrong", but the listed hardware makes
more sense given that Dell's Inspiron 7000 audio driver is a realtek driver.
alsamixer shows:

HDA Intel MID
Intel Haswell HDMA

HDA Intel PHC
Realtek ALC283


Can this be solely addressed in /etc/modprobe.d/alsa-base.conf file? The
addition of "option snd-hda-intel model=*something*" is the focus right now. 

Any suggestions?

> 
> > IOW, does the patch get compiled, or does anything labeled as a patch within
> > the source still have to be manually patched against the kernel?
> > 
> > Thanks to anyone who can answer this.  I complied and installed the 3.14-rc3
> > kernel without a problem. It was the default kernel in grub. But I'm still
> > dealing with the exact same no sound issue as if booting into 3.12.
> > 
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel <at> alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > 
> 
