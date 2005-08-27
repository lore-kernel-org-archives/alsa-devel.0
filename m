From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-user] ALSA / emu10k1 / SPDIF / surround?
Date: Sat, 27 Aug 2005 19:00:23 -0400
Message-ID: <1125183623.25011.102.camel@mindpipe>
References: <1124755115.5763.3.camel@hostmaster.org>
	 <1125166820.22285.68.camel@hostmaster.org>
	 <1125168446.25011.68.camel@mindpipe>
	 <1125173150.22285.103.camel@hostmaster.org>
	 <1125174445.25011.76.camel@mindpipe>
	 <1125177706.22285.144.camel@hostmaster.org>
	 <1125178767.25011.86.camel@mindpipe>
	 <1125181627.22285.155.camel@hostmaster.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1125181627.22285.155.camel@hostmaster.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Zehetbauer <thomasz@hostmaster.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, ALSA user list <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 2005-08-28 at 00:27 +0200, Thomas Zehetbauer wrote:
> AFAIR I bought the card as a "SoundBlaster Live! 5.1" and that is also
> printed on the card. Model number is SB0220. There are a EMU10K1-JFF
> and a Sigmatel STC9708T on the card. 

Try this patch.

If you still get both a PCM and a Wave control, and distortion at high
levels, try removing the "ac97_chip = 1" line.

Lee

Index: alsa-kernel/pci/emu10k1/emu10k1_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c,v
retrieving revision 1.66
diff -u -r1.66 emu10k1_main.c
--- alsa-kernel/pci/emu10k1/emu10k1_main.c	26 Aug 2005 16:26:40 -0000	1.66
+++ alsa-kernel/pci/emu10k1/emu10k1_main.c	27 Aug 2005 22:58:59 -0000
@@ -741,6 +741,13 @@
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
+	/* Tested by Thomas Zehetbauer 27th Aug 2005 */
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80651102,
+	 .driver = "EMU10K1", .name = "SB Live 5.1 [SB0220]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80641102,
 	 .driver = "EMU10K1", .name = "SB Live 5.1", 
 	 .id = "Live",




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
