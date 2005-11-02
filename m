From: Corvus Corax <corvus-ml@cybertrench.com>
Subject: lo10K1 not working on x86_64 ?
Date: Wed, 2 Nov 2005 21:20:09 +0100
Message-ID: <20051102212009.6121d6c3@VikingPC.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.cybertrench.com (cybertrench.com [217.172.179.74])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 657F11BC
	for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2005 21:20:16 +0100 (MET)
Received: from VikingPC.home (dslb-084-056-177-168.pools.arcor-ip.net [84.56.177.168])
	by mail.cybertrench.com (Postfix) with ESMTP id 64EC91B0016
	for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2005 21:20:10 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi

It seems like lo10k1 is not working correctly on x86_64

the emu10k1 driver itself works ok, but loading anything (for example
with emu_init) results either in

- no change at all
- sound in front left speaker distorted
- no sound

just running emu_init results in distorted sound

i tried qlo10k1 and loaded several patches manually or unloaded them from the
default provided emu_init. all that changes are different heavy distortions

(distortion = sounds like extreme clipping doe to over amilification)

is the 64bit address stuff causing this, or could as10k1 eventually produce
incorrect DSP machine code? (compiled DSP assembler code on x86_64 seems
to have differed from code previously assembled on x86, but Im not sure if the
sources were 100% identical)

tested with an

0000:01:07.0 Class 0401: 1102:0002 (rev 0a)
        Subsystem: 1102:8065
        Flags: bus master, medium devsel, latency 32, IRQ 21
        I/O ports at a000 [size=32]
        Capabilities: [dc] Power Management version 1
(
0000:01:07.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
0a)        Subsystem: Creative Labs SBLive! 5.1 Digital Model SB0220
        Flags: bus master, medium devsel, latency 32, IRQ 21
        I/O ports at a000 [size=32]
        Capabilities: [dc] Power Management version 1
)
on an AMD64 X2 machine

custom patches previously worked flawlessly with the OSS emu10k1 driver under
x86, OSS dspmgr (both compiled for 32 and 64) segfaults when run with the 64bit
kernel compiled oss emu10k1 driver

I did not test alsa ld10k1 with the old system


regards

Corvus


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
