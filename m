From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Audigy2 Microphone capture: alsa-driver-1.0.9rc1
	works, alsa-driver-1.0.9rc2 doesn't
Date: Thu, 31 Mar 2005 16:28:40 -0500
Message-ID: <1112304520.2509.5.camel@mindpipe>
References: <20050330230127.47575.qmail@web52903.mail.yahoo.com>
	 <424C6145.20703@pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <424C6145.20703@pobox.sk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: Chris Rankin <rankincj@yahoo.com>, James Courtier-Dutton <James@superbug.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-03-31 at 22:44 +0200, Peter Zubaj wrote:
> Problem is, that your card was not detected correctly and ac97 mixer 
> initialization is was not run.
> Looks like card identification broke lot of cards and things.

Does this patch fix the problem?

Index: alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
retrieving revision 1.49
diff -u -r1.49 emu10k1_main.c
--- alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c	27 Mar 2005 14:00:54 -0000	1.49
+++ alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c	31 Mar 2005 21:27:47 -0000
@@ -680,6 +680,7 @@
 	 .driver = "Audigy", .name = "Audigy 1 or 2 [Unknown]", 
 	 .emu10k2_chip = 1,
 	 .ca0102_chip = 1,
+	 .ac97_chip = 1,
 	 .spdif_bug = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x40011102,
 	 .driver = "EMU10K1", .name = "E-mu APS [4001]", 




-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
