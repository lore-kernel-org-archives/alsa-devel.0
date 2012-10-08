From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Kernel panic with SB Live (snd_emu10k1) when sharing
	interrupts
Date: Mon, 08 Oct 2012 11:17:14 +0200
Message-ID: <50729A1A.7030306@physik.fu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de
 [130.133.4.66]) by alsa0.perex.cz (Postfix) with ESMTP id 376FD262614
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2012 11:17:15 +0200 (CEST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
 by outpost1.zedat.fu-berlin.de (Exim 4.69)
 for alsa-devel@alsa-project.org with esmtp
 (envelope-from <glaubitz@physik.fu-berlin.de>)
 id <1TL9Sc-001H1V-UY>; Mon, 08 Oct 2012 11:17:14 +0200
Received: from seb08.physik.fu-berlin.de ([160.45.66.178])
 by inpost2.zedat.fu-berlin.de (Exim 4.69)
 for alsa-devel@alsa-project.org with esmtpsa
 (envelope-from <glaubitz@physik.fu-berlin.de>)
 id <1TL9Sc-001euy-T0>; Mon, 08 Oct 2012 11:17:14 +0200
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

Hello,

I have a Creative SoundBlaster Live! PCI (PCI-IDs:
1102:0002 and 1102:7002) which I recently ran into trouble with.

I used the SB Live! to replace my SB128 PCI which ran fine in the 
configuration (ASUS P8B-C/4L, see attached output from dmesg and lspci). 
Once I swapped the sound cards, I booted up the machine and immediately 
ran into a kernel panic [1] which seems to indicate that there is a 
problem with interrupt sharing.

I there removed the Firewire card which was placed adjacent to the SB 
Live and the machine ran stable again.

I assume that the snd_emu10k1 driver is sometimes not handling shared 
interrupts properly, isn't it?

I wanted to report this as a bug in the ALSA bug tracker [2], but alas 
the tracker is currently down.

I'm attaching the output of dmesg [3] as well as lspci [4]. Will provide 
more information if requested.

Cheers,

Adrian

 > [1] http://users.physik.fu-berlin.de/~glaubitz/emu10k1_panic.jpg
 > [2] https://bugtrack.alsa-project.org/alsa-bug/
 > [3] http://users.physik.fu-berlin.de/~glaubitz/dmesg_emu10k1.txt
 > [4] http://users.physik.fu-berlin.de/~glaubitz/lspci_emu10k1.txt
