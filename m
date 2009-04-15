From: Justin Mattock <justinmattock@gmail.com>
Subject: /proc/asound/* shows signs of life,
	but alsactl see's nothing
Date: Wed, 15 Apr 2009 16:03:07 -0700
Message-ID: <dd18b0c30904151603x226dfedaje9e443f7dc9eda38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 248791037F8
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 01:03:09 +0200 (CEST)
Received: by qyk1 with SMTP id 1so283158qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2009 16:03:08 -0700 (PDT)
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

This is confusing to me
(with or without the imac9,1 patch
for the imac)
there is still entries in /proc/asound

lrwxrwxrwx 1 root root 5 Apr 15 22:49 NVidia -> card0
dr-xr-xr-x 7 root root 0 Apr 15 22:49 card0
-r--r--r-- 1 root root 0 Apr 15 22:49 cards
-r--r--r-- 1 root root 0 Apr 15 22:49 devices
-r--r--r-- 1 root root 0 Apr 15 22:49 hwdep
-r--r--r-- 1 root root 0 Apr 15 22:49 pcm
-r--r--r-- 1 root root 0 Apr 15 22:49 timers
-r--r--r-- 1 root root 0 Apr 15 22:49 version

but when I do:
sudo /usr/sbin/alsactl store
/usr/sbin/alsactl: save_state:1502: No soundcards found...

I this a software issue, or is this because the kernel is missing
something important in patch_realtek.c ?

I've moved different things around in patch_realtek.c
but still no speaker sound or headphone, not even
the sound during boot when the module is being loaded.

Also what is the best way to find PCI SSID?
under codec#0:(I have)

Codec: Realtek ALC889A
Address: 0
Vendor Id: 0x10ec0885
Subsystem Id: 0x106b4900
Revision Id: 0x100103
No Modem Function Group found

but with lspci -nnv

00:08.0 0403: 10de:0ac0 (rev b1)
        Subsystem: 10de:cb79
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0 (500ns min, 1250ns max)
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at d3480000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: <access denied>
        Kernel driver in use: HDA Intel
        Kernel modules: snd-hda-intel

the subsystem is 10de:cb79
but is
Subsystem Id: 0x106b4900


regards,
-- 
Justin P. Mattock
