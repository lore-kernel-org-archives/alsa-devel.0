From: rmgls@free.fr
Subject: rme multiface I=>pccard error -12
Date: Fri, 30 Nov 2007 15:11:08 +0100
Message-ID: <20071130141109.2FB95322822@smtp7-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp7-g19.free.fr (smtp7-g19.free.fr [212.27.42.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EA231037F0
	for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2007 15:11:10 +0100 (CET)
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 62F6A32285A
	for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2007 15:11:09 +0100 (CET)
Received: from free.fr (evr27-1-88-172-40-194.fbx.proxad.net [88.172.40.194])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 2FB95322822
	for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2007 15:11:09 +0100 (CET)
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

on a laptop the old multiface I with a pccard (1) doesn't attach.
acore returns error -12.

      details:
dmesg:
pccard: CardBus card inserted into slot 0
ALSA /root/alsa-driver-hg20071129/acore/init.c:174: cannot find the slot for index 0 (range 0-0), error: -16
RME Hammerfall DSP: probe of 0000:07:00.0 failed with error -12
    	       config:
machine: sony vaio s5
kernel 2-6-24-rc3
all alsa-*-hg as you seen.
sound box: multiface I and pccard (I), the old one.

Socket 0 Bridge:   	[yenta_cardbus] 	(bus ID: 0000:06:05.0)

lspcmcia:
Configuration:	state: on	ready: yes
Voltage: 3.3V Vcc: 3.3V Vpp: 3.3V

lspci -v
06:05.0 CardBus bridge: Texas Instruments PCI7420 CardBus Controller
	Subsystem: Sony Corporation Unknown device 818f
	Flags: bus master, medium devsel, latency 168, IRQ 17
	Memory at b0008000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=06, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: 50000000-53fff000 (prefetchable)
	Memory window 1: 54000000-57fff000
	I/O window 0: 00002400-000024ff
	I/O window 1: 00002800-000028ff
	16-bit legacy interface ports at 0001
07:00.0 Multimedia audio controller: Xilinx Corporation RME Hammerfall DSP (rev 10)
	Flags: medium devsel, IRQ 17
	Memory at 54000000 (32-bit, non-prefetchable) [disabled] [size=64K]

cat /dev/sndstat:
...
0: alc-260

any help would be appreciated.
thanks.

best regards
raoul
rmgls@free.fr
