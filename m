From: Ronald Horn <Ronald.Horn@web.de>
Subject: ICH9 Sound
Date: Sat, 27 Sep 2008 14:38:35 +0200
Message-ID: <48DE294B.6020907@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate01.web.de (fmmailgate01.web.de [217.72.192.221])
	by alsa0.perex.cz (Postfix) with ESMTP id A145524375
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Sep 2008 14:38:37 +0200 (CEST)
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id DE090F20C980
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Sep 2008 14:38:36 +0200 (CEST)
Received: from [78.48.40.229] (helo=[192.168.178.29])
	by smtp06.web.de with asmtp (WEB.DE 4.109 #226) id 1KjZ4G-0002Z4-00
	for alsa-devel@alsa-project.org; Sat, 27 Sep 2008 14:38:36 +0200
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

Hello,

I'm using a HP Pavilion dv7-1045eg. The Problem is I have no sound,
because there is no driver witch works.
Here are some reports from my system:
/
lspci -nv/
00:1b.0 0403: 8086:293e (rev 03)
        Subsystem: 103c:30f4
        Flags: bus master, fast devsel, latency 0, IRQ 22
        Memory at df300000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: Mask- 64bit+
Queue=0/0 Enable+
        Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
        Capabilities: [100] Virtual Channel <?>
        Capabilities: [130] Root Complex Link <?>
        Kernel driver in use: HDA Intel
        Kernel modules: snd-hda-intel

/
cat /proc/asound/cards/
 0 [Intel      ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xdf300000 irq 22


/head -n 1 /proc/asound/card0/codec*/
==> /proc/asound/card0/codec#0 <==
Codec: IDT 92HD71B7X
==> /proc/asound/card0/codec#2 <==
Codec: Generic 10de ID 6


I'm using openSuse 11.0 with Kernel 2.6.25.16-0.1-pae.
Maybe your project could develop some drivers.

Greetings
Ronald
