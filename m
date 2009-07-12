From: Christian Esken <esken@kde.org>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Sun, 12 Jul 2009 10:24:35 +0200
Message-ID: <200907121024.36002.esken@kde.org>
References: <200906271405.45651.esken@kde.org>
	<200907051329.48117.esken@kde.org> <s5hvdm6e398.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43]) by alsa0.perex.cz (Postfix) with ESMTP id 6DEEE24790
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Jul 2009 10:24:33 +0200 (CEST)
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net
	[151.189.8.31]) by mx.arcor.de (Postfix) with ESMTP id 5192B2C2D1B
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Jul 2009 10:24:32 +0200 (CEST)
Received: from mail-in-17.arcor-online.net (mail-in-17.arcor-online.net
	[151.189.21.57])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 388BF10111
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Jul 2009 10:24:32 +0200 (CEST)
Received: from firefly.localnet (dslb-084-062-075-152.pools.arcor-ip.net
	[84.62.75.152])
	by mail-in-17.arcor-online.net (Postfix) with ESMTPS id C2EEA3B2592
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Jul 2009 10:24:31 +0200 (CEST)
In-Reply-To: <s5hvdm6e398.wl%tiwai@suse.de>
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

Am Montag 06 Juli 2009 08:26:11 schrieb Takashi Iwai:
> At Sun, 5 Jul 2009 13:29:48 +0200,
>
> Christian Esken wrote:
> > Am Sonntag 05 Juli 2009 09:44:33 schrieb Takashi Iwai:
> > > At Sun, 5 Jul 2009 00:19:55 +0200,
> > >
> > > Christian Esken wrote:
> > > > Am Samstag 27 Juni 2009 14:05:45 schrieb Christian Esken:
> > > > > Hello,
> > > > >
> > > > > unfortunately I cannot playback anything (PCM) with the new SB X-Fi
> > > > > driver. Driver:
> > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-
> > > > > driver-snapshot.tar.bz2
> > > > >   Distribution: openSuSE 11.1
> > > > >   Kernel: 2.6.27.23-0.1-xen
> > > > >
> > > > > My card is a "X-Fi Titanium" (PCI device code: 1102:000b). The card
> > > > > is recognized by the driver, and any mixer (alsamixer, kmix) also
> > > > > recognizes the card.
> > > > >
> > > > > But playing back isn't possible. I tried speaker-test, audacity,
> > > > > amarok and aplay. Most applications  hang, some also produce an
> > > > > error in the /var/log/messages (see
> > > > > below).
> > > > >
> > > > > I then used "./configure --with-debug=full --with-cards=ctxfi" due
> > > > > to the possible hd-audio conflict, but it didn't make a difference.
> > > > >
> > > > > Is there anything else I could try?
> > > >
> > > > I tested the same openSuSE version with a non-Xen 64 bit kernel, and
> > > > it doesn't work either.
> > > >
> > > > And I tried with this:
> > > >   Driver: alsa-driver-20090704.tar.bz2
> > > >   Distribution: Kubuntu Karmic Alpha-2
> > > >   Kernel: 2.6.30  (32 Bit)
> > > >
> > > > Under the latter setup the X-Fi Titanium works (Simple 2 channel test
> > > > with speaker-test, audacity, amarok). :-))
> > >
> > > How many RAM do you have?
> > > Could you boot with the limited memory size?
> >
> > It is just 2GB. So I am not limited by the 32 bit barrier.
> >
> > So booting with "limited" memory size doesn't make sense, right?
>
> Supposedly.  Is it emu20k1 or emu20k2?

I checked it again: It is a 20k2 chip. 

/var/log/boot.msg says:
<7>ALSA /home/chris/Desktop/alsa-driver/pci/ctxfi/ctatc.c:1268: ctxfi: chip 
20K2 model SB0880 (1102:0041) is found


http://pci-ids.ucw.cz/mods/PC/1102/000b shows 1102:0041 as "X-Fi Titanium 
series [EMU20k2]".

  Christian
