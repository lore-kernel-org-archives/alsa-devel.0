From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Kernel panic with SB Live (snd_emu10k1) when
	sharing interrupts
Date: Fri, 19 Oct 2012 13:13:42 +0800
Message-ID: <CAN8cciZ7x5Z37YyEYXxCt1pZL7X7sRsEh_A6F70P57y99p8Tkw@mail.gmail.com>
References: <50729A1A.7030306@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id A844C2652E4
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 07:13:43 +0200 (CEST)
Received: by mail-qc0-f179.google.com with SMTP id b14so51275qcs.38
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2012 22:13:42 -0700 (PDT)
In-Reply-To: <50729A1A.7030306@physik.fu-berlin.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> I have a Creative SoundBlaster Live! PCI (PCI-IDs:
> 1102:0002 and 1102:7002) which I recently ran into trouble with.
>
> I used the SB Live! to replace my SB128 PCI which ran fine in the
configuration (ASUS P8B-C/4L, see attached output from dmesg and lspci).
Once I swapped the sound cards, I booted up the machine and immediately ran
into a kernel panic [1] which seems to indicate that there is a problem
with interrupt sharing.
>
> I there removed the Firewire card which was placed adjacent to the SB
Live and the machine ran stable again.
>
> I assume that the snd_emu10k1 driver is sometimes not handling shared
interrupts properly, isn't it?
>
> I wanted to report this as a bug in the ALSA bug tracker [2], but alas
the tracker is currently down.
>
> I'm attaching the output of dmesg [3] as well as lspci [4]. Will provide
more information if requested.

on some of the asus motherboard, usually there is only one pci slot which
don't share int with other on board devices

>
> > [1] http://users.physik.fu-berlin.de/~glaubitz/emu10k1_panic.jpg
> > [2] https://bugtrack.alsa-project.org/alsa-bug/
> > [3] http://users.physik.fu-berlin.de/~glaubitz/dmesg_emu10k1.txt
> > [4] http://users.physik.fu-berlin.de/~glaubitz/lspci_emu10k1.txt
>
