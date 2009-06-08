From: Gernot Kohlhaas <gernot.kohlhaas@googlemail.com>
Subject: Re: SB X-Fi driver fixes (Re: Testers wanted: New SB
 X-Fi	driver)
Date: Mon, 08 Jun 2009 20:21:59 +0200
Message-ID: <4A2D56C7.2090505@googlemail.com>
References: <1244140942.4550.2.camel@polo-desktop>	<s5hbpp1zpt9.wl%tiwai@suse.de>	<1244376026.6985.5.camel@polo-desktop>	<s5hk53oowhz.wl%tiwai@suse.de>
	<s5hbpoz3pbj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f218.google.com (mail-fx0-f218.google.com
	[209.85.220.218])
	by alsa0.perex.cz (Postfix) with ESMTP id ACF5E2453B
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 20:22:01 +0200 (CEST)
Received: by fxm18 with SMTP id 18so3357657fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 08 Jun 2009 11:22:01 -0700 (PDT)
In-Reply-To: <s5hbpoz3pbj.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

Works like a charme, except for some crashes I had...
Three crashes two days ago (in audacious) and two in xmms.
Sound keeps looping (a few ms) and my whole system is totally frozen.
After that I can't find any usable output in my log-files (no output
from the crash at all).

I'll play around a bit and see if I can crash it again.

Anything I should try/look for?

BTW: Is there any way to achive Low Pass Filtering with "on-board"
ALSA-Tools/Methods?
ATM I am using a ladspa plugin that I specified in my .asoundrc.

Kernel: 2.6.29-gentoo-r5 x86_64
gcc-4.3.3
glibc-2.8_p20080602-r1

lspci -vv
05:00.0 Multimedia audio controller: Creative Labs SB X-Fi
        Subsystem: Creative Labs X-Fi XtremeGamer FATAL1TY PRO
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 64 (1000ns min, 1250ns max), Cache Line Size: 32 bytes
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at ec00 [size=32]
        Region 1: Memory at fea00000 (64-bit, non-prefetchable) [size=2M]
        Region 3: Memory at f8000000 (64-bit, non-prefetchable) [size=64M]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
Count=1/1 Enable-
                Address: 0000000000000000  Data: 0000
        Kernel driver in use: SB-XFi
        Kernel modules: snd-ctxfi

dmesg:
SB-XFi 0000:05:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
-- 
http://www.gnupp.de/verschluesselung/warum.html
Key ID: 0x4C0B2250
Key: http://home.arcor.de/mr_maniac/ANDERES/public.gpg
