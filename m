From: Christian Esken <esken@kde.org>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Wed, 5 Aug 2009 23:21:53 +0200
Message-ID: <200908052321.53363.esken@kde.org>
References: <200907121607.49565.esken@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49]) by alsa0.perex.cz (Postfix) with ESMTP id C7F2A24630
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 23:21:54 +0200 (CEST)
Received: from mail-in-19-z2.arcor-online.net (mail-in-19-z2.arcor-online.net
	[151.189.8.36]) by mx.arcor.de (Postfix) with ESMTP id 3954F1AF2BA
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 23:21:54 +0200 (CEST)
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	by mail-in-19-z2.arcor-online.net (Postfix) with ESMTP id 095FF6BFAF
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 23:21:54 +0200 (CEST)
Received: from firefly.localnet (dslb-084-062-082-119.pools.arcor-ip.net
	[84.62.82.119])
	by mail-in-06.arcor-online.net (Postfix) with ESMTPS id AF31139A5F6
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Aug 2009 23:21:53 +0200 (CEST)
In-Reply-To: <200907121607.49565.esken@kde.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am Sonntag 12 Juli 2009 16:07:49 schrieb Christian Esken:
> Am Sonntag 12 Juli 2009 10:24:35 schrieb Christian Esken:
> > Am Montag 06 Juli 2009 08:26:11 schrieb Takashi Iwai:
> > > At Sun, 5 Jul 2009 13:29:48 +0200,
> > >
> > > Christian Esken wrote:
> > > > Am Sonntag 05 Juli 2009 09:44:33 schrieb Takashi Iwai:
> > > > > At Sun, 5 Jul 2009 00:19:55 +0200,
> > > > >
> > > > > Christian Esken wrote:
> > > > > > Am Samstag 27 Juni 2009 14:05:45 schrieb Christian Esken:
> > > > > > > Hello,
> > > > > > >
> > > > > > > unfortunately I cannot playback anything (PCM) with the new SB
> > > > > > > X-Fi driver. Driver:
> > > > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/als
> > > > > > >a- driver-snapshot.tar.bz2
> > > > > > >   Distribution: openSuSE 11.1
> > > > > > >   Kernel: 2.6.27.23-0.1-xen
> > > > > > >
> > > > > > > My card is a "X-Fi Titanium" (PCI device code: 1102:000b). The
> > > > > > > card is recognized by the driver, and any mixer (alsamixer,
> > > > > > > kmix) also recognizes the card.
> > > > > > >
> > > > > > > But playing back isn't possible. I tried speaker-test,
> > > > > > > audacity, amarok and aplay. Most applications  hang, some also
> > > > > > > produce an error in the /var/log/messages (see
> > > > > > > below).
> > > > > > >
> > > > > > > I then used "./configure --with-debug=full --with-cards=ctxfi"
> > > > > > > due to the possible hd-audio conflict, but it didn't make a
> > > > > > > difference.
> > > > > > >
> > > > > > > Is there anything else I could try?
> > > > > >
> > > > > > I tested the same openSuSE version with a non-Xen 64 bit kernel,
> > > > > > and it doesn't work either.
> > > > > >
> > > > > > And I tried with this:
> > > > > >   Driver: alsa-driver-20090704.tar.bz2
> > > > > >   Distribution: Kubuntu Karmic Alpha-2
> > > > > >   Kernel: 2.6.30  (32 Bit)
> > > > > >
> > > > > > Under the latter setup the X-Fi Titanium works (Simple 2 channel
> > > > > > test with speaker-test, audacity, amarok). :-))
> > > > >
> > > > > How many RAM do you have?
> > > > > Could you boot with the limited memory size?
> > > >
> > > > It is just 2GB. So I am not limited by the 32 bit barrier.
> > > >
> > > > So booting with "limited" memory size doesn't make sense, right?
> > >
> > > Supposedly.  Is it emu20k1 or emu20k2?
> >
> > I checked it again: It is a 20k2 chip.
> >
> > /var/log/boot.msg says:
> > <7>ALSA /home/chris/Desktop/alsa-driver/pci/ctxfi/ctatc.c:1268: ctxfi:
> > chip 20K2 model SB0880 (1102:0041) is found
> >
> >
> > http://pci-ids.ucw.cz/mods/PC/1102/000b shows 1102:0041 as "X-Fi Titanium
> > series [EMU20k2]".
>
> I did now test it with a different 64 Bit Linux distribution, and it works
> correctly:
> Driver: alsa-driver-20090712.tar.bz2
> Distribution: Kubuntu Karmic Alpha-2
> Kernel: 2.6.30  (64 Bit)
>
> All in all, I can produce a working environment with recent 32 and 64 bit
> kernels. This is good news.  :-)
>
> Below is the summary on the tested distributions.
>
>   Christian
>
>
> So we got this:
> Kubuntu Karmic Alpha-2 32 Bit, 2.0.30 (works)
> Kubuntu Karmic Alpha-2 64 Bit, 2.0.30 (works)
> SuSE 11.1 64 Bit,  2.0.27 (does not work)
> SuSE 11.1 64 Bit,  2.0.27 XEN (does not work)
> SuSE 11.2 Milestone3  64Bit, 2.0.30 (test canceled, due to unrelated
> problems) => I'll see whether I can redo the SuSE11.2 tests, after doing a
> bugreport at openSuSE.

OK, that SuSE11.2 Milestone3  bug has been fixed, but Milestone4 has ALSA (at 
least soundcore)  built in the Kernel - I think I'll just give up further 
testing until that gets "fixed".

Well, in any case this is a postive report: It works with both 32 and 64 bit 
2.0.30 kernels (using Kubuntu Karmic-Alpha-2). 

  Christian
