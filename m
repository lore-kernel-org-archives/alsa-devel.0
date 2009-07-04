From: Christian Esken <esken@kde.org>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Sun, 5 Jul 2009 00:19:55 +0200
Message-ID: <200907050019.56283.esken@kde.org>
References: <200906271405.45651.esken@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net
	[151.189.21.48]) by alsa0.perex.cz (Postfix) with ESMTP id 6429624BE5
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 00:20:00 +0200 (CEST)
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net
	[151.189.8.16]) by mx.arcor.de (Postfix) with ESMTP id 08FD62AED60
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 00:19:59 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id 01A94ADBAE
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 00:19:59 +0200 (CEST)
Received: from firefly.localnet (dslb-084-062-067-006.pools.arcor-ip.net
	[84.62.67.6])
	by mail-in-09.arcor-online.net (Postfix) with ESMTPS id 863E11AF86A
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jul 2009 00:19:58 +0200 (CEST)
In-Reply-To: <200906271405.45651.esken@kde.org>
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

Am Samstag 27 Juni 2009 14:05:45 schrieb Christian Esken:
> Hello,
>
> unfortunately I cannot playback anything (PCM) with the new SB X-Fi driver.
>   Driver: ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-
> driver-snapshot.tar.bz2
>   Distribution: openSuSE 11.1
>   Kernel: 2.6.27.23-0.1-xen
>
> My card is a "X-Fi Titanium" (PCI device code: 1102:000b). The card is
> recognized by the driver, and any mixer (alsamixer, kmix) also recognizes
> the card.
>
> But playing back isn't possible. I tried speaker-test, audacity, amarok and
> aplay. Most applications  hang, some also produce an error in the
> /var/log/messages (see
> below).
>
> I then used "./configure --with-debug=full --with-cards=ctxfi" due to the
> possible hd-audio conflict, but it didn't make a difference.
>
> Is there anything else I could try?

I tested the same openSuSE version with a non-Xen 64 bit kernel, and it 
doesn't work either.

And I tried with this:
  Driver: alsa-driver-20090704.tar.bz2
  Distribution: Kubuntu Karmic Alpha-2
  Kernel: 2.6.30  (32 Bit)

Under the latter setup the X-Fi Titanium works (Simple 2 channel test with 
speaker-test, audacity, amarok). :-))

What I now know/believe is this:
- Alsa driver : not responisible (it works)
- My Computer hardware : not responsible (it works)
 - Xen kernel: quite likely not responsible
 - Kernel < 2.6.30: Probably responsible
 - 64 Bit: Probably responsible
- Other less likely stuff like NVIDIA driver (nv vs nvidia): Could be checked

I will now check other combinations. Next will be Kernel 2.6.30 (64 bit), 
using openSUSE 11.2-Milestone3.

   Christian
