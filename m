From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [Alsa-user] Re: [linux-audio-dev] E-MU 1212m
	Linux drivers
Date: Mon, 02 May 2005 23:31:35 -0400
Message-ID: <1115091095.27819.9.camel@mindpipe>
References: <200505010231.19540.beppe.miletto@tiscali.it>
	 <1114908114.5626.3.camel@mindpipe>
	 <200505020124.16569.beppe.miletto@tiscali.it>
	 <1114990231.23959.2.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1114990231.23959.2.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, 2005-05-01 at 19:30 -0400, Lee Revell wrote:
> On Mon, 2005-05-02 at 01:24 +0200, Giuseppe Miletto wrote:
> James, here's the entry for the 1212m:
> 
> 0000:02:0a.0 Class 0401: 1102:0004 (rev 03)
>         Subsystem: 1102:4001
>         Flags: bus master, medium devsel, latency 32, IRQ 5
>         I/O ports at 9000
>         Capabilities: [dc] Power Management version 2
> 

Here's a corrected patch to cause the emu10k1 driver to claim this device.

I have no idea what will happen, it could work, or lock up your machine.
But we have at least one Linux user with access to the hardware, so we
might as well try...

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

Lee

Index: alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
retrieving revision 1.55
diff -u -r1.55 emu10k1_main.c
--- alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c	10 Apr 2005 14:43:35 -0000	1.55
+++ alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c	2 May 2005 00:06:38 -0000
@@ -700,6 +700,10 @@
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
 	 .ac97_chip = 1} ,
+	{.vendor = 0x1102, .device = 0x0004, .subsystem = 0x40011102,
+	 .driver = "Audigy", .name = "E-mu 1212m [4001]", 
+	 .id = "1212m",
+	 .emu10k2_chip = 1} ,
 	{.vendor = 0x1102, .device = 0x0004,
 	 .driver = "Audigy", .name = "Audigy 1 [Unknown]", 
 	 .id = "Audigy",




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
