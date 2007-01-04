From: Paul Abrahams <abrahams@acm.org>
Subject: Re: PROBLEM: Probable kernel bug in VT8233 drivers
Date: Thu, 4 Jan 2007 18:23:47 -0500
Message-ID: <200701041823.48794.abrahams@acm.org>
References: <200701041332.46215.abrahams@acm.org>
	<200701041551.10094.abrahams@acm.org>
	<1167944791.4321.12.camel@localhost.localdomain>
Reply-To: abrahams@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from rwcrmhc14.comcast.net (rwcrmhc14.comcast.net [216.148.227.154])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 83E9524A
	for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2007 00:24:09 +0100 (MET)
In-Reply-To: <1167944791.4321.12.camel@localhost.localdomain>
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
To: Peter Zubaj <pzubaj@gaya.sk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 04 January 2007 4:06 pm, Peter Zubaj wrote:
> If card is in /proc/asound/cards then driver is loaded and working.
> Probably Yast will fail to load driver again, because it is already
> loaded.
>
> You have probably problem with dev files. Check if there are dev files
> in /dev/snd subdir (I think this is default).
>
> Something like this:
> crw-------  1 peter root 116, 13 Jan  4 17:03 controlC0
> crw-------  1 peter root 116, 20 Jan  4 17:03 controlC1

This is getting interesting.  I do not have a /dev/snd directory.  I tried 
reinstalling the devs rpm package, and that recreated /dev/snd, but after a 
reboot /dev/snd was gone again.  

Here's something else I tried.  If having the driver loaded is the problem, 
then the problem should go away if I remove it.  So I did

rmmod snd_via82xx

which succeeded and caused the entry to disappear, as verified by

lsmod | grep via82

I then retried the Yast installation and got the same error as before.  After 
that attempt, though, the previous command gave me

snd_via82xx            32920  0

indicating that the Yast installation restored the module.  So I would guess 
that the module is loaded but is not usable because of the problems indicated 
by the original error message (at the beginning of this thread).

I also tried alsaconf again and got this, as before:

Loading driver...
Starting sound driver:  via82xx                                       done
/usr/sbin/alsactl: load_state:1236: No soundcards found...

which suggests that even though the driver is loaded, it cannot access the car 
(actually part of the motherboard).

Paul






> crw-------  1 peter root 116,  4 Jan  4 17:03 hwC0D0
> crw-------  1 peter root 116, 14 Jan  4 17:03 hwC0D2
> crw-------  1 peter root 116,  6 Jan  4 17:03 midiC0D0
> crw-------  1 peter root 116,  5 Jan  4 17:03 midiC0D1
> crw-------  1 peter root 116, 15 Jan  4 17:03 midiC0D2
> crw-------  1 peter root 116, 16 Jan  4 17:03 midiC0D3
> crw-------  1 peter root 116, 12 Jan  4 17:03 pcmC0D0c
> crw-------  1 peter root 116, 11 Jan  4 17:03 pcmC0D0p
> crw-------  1 peter root 116, 10 Jan  4 17:03 pcmC0D1c
> crw-------  1 peter root 116,  9 Jan  4 17:03 pcmC0D2c
> crw-------  1 peter root 116,  8 Jan  4 17:03 pcmC0D2p
> crw-------  1 peter root 116,  7 Jan  4 17:03 pcmC0D3p
> crw-------  1 peter root 116, 19 Jan  4 17:03 pcmC1D0c
> crw-------  1 peter root 116, 18 Jan  4 17:03 pcmC1D0p
> crw-------  1 peter root 116, 17 Jan  4 17:03 pcmC1D1p
> crw-------  1 peter root 116,  3 Jan  4 17:03 seq
> crw-------  1 peter root 116,  2 Jan  4 17:03 timer
>
> Peter Zubaj
>
> On Thu, 2007-01-04 at 15:51 -0500, Paul Abrahams wrote:
> > On Thursday 04 January 2007 3:16 pm, Peter Zubaj wrote:
> > > Hi,
> > >
> > > Looks like alsa driver is loaded and it should work.
> > > Is your sound card working. Did you try play something ?
> >
> > The card is not working.  The Yast installer says that the kernel module
> > for sound support could not be loaded, and I cannot get any sound at all.
> >  Even the alsaconf program, which normally plays when nothing else does,
> > produces no sound.   Its output includes this:
> >
> > Starting sound driver:  via82xx                                      
> > done /usr/sbin/alsactl: load_state:1236: No soundcards found...
> >
> > Paul Abrahams

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
