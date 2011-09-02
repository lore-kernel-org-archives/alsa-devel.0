From: Clemens Ladisch <clemens@ladisch.de>
Subject: Aureal issues on resume
Date: Fri, 02 Sep 2011 17:05:37 +0200
Message-ID: <4E60F0C1.5020008@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay04.ispgateway.de (smtprelay04.ispgateway.de
	[80.67.31.38]) by alsa0.perex.cz (Postfix) with ESMTP id 9BFC82446B
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Sep 2011 17:05:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anders Eriksson <aeriksson@fastmail.fm>, Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

(added recipients)

-------- Original Message --------
Subject: Aureal issues on resume
Date: Fri, 02 Sep 2011 13:41:42 +0200
From: Anders Eriksson <aeriksson@fastmail.fm>
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org


Hi, upon resuming from hibernation, I see this in my log:

Sep  2 11:15:20 tippex kernel: [72436.287020] vortex_adb_addroutes: unending route! 0x10
Sep  2 11:15:20 tippex kernel: [72436.287127] vortex_adb_addroutes: unending route! 0x838
Sep  2 11:15:20 tippex kernel: [72436.287277] vortex_adb_addroutes: unending route! 0x11
Sep  2 11:15:20 tippex kernel: [72436.287418] vortex_adb_addroutes: unending route! 0x8b9
Sep  2 11:15:20 tippex kernel: [72436.292037] Vortex: vortex_fifo_setadbctrl fail
Sep  2 11:15:55 tippex kernel: [72471.403490] vortex_adb_delroutes: route not found! 0x10
Sep  2 11:15:55 tippex kernel: [72471.403596] vortex_adb_delroutes: route not found! 0x838
Sep  2 11:15:55 tippex kernel: [72471.403710] vortex_adb_delroutes: route not found! 0x11
Sep  2 11:15:55 tippex kernel: [72471.403811] vortex_adb_delroutes: route not found! 0x8b9

And the sound is no more. I need to reboot to get it back.

If memory serves, it's been there since 2.6.30 or so. Any ideas what can be 
triggering it?

lspci says it's an 
00:04.0 Multimedia audio controller: Aureal Semiconductor Vortex 1 (rev 02)
        Subsystem: Diamond Multimedia Systems Sonic Impact A3D
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at 50000000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at 10b0 [size=8]
        I/O ports at 10b8 [size=8]
        Capabilities: [dc] Power Management version 1
        Kernel driver in use: snd_au8820
        Kernel modules: snd-au8820


-Anders
