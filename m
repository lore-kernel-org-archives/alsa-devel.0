From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: kernel 2.6.14.x and alsamixer problems
Date: Fri, 25 Nov 2005 21:35:54 -0500
Message-ID: <1132972554.7393.11.camel@mindpipe>
References: <437EB3E6.6030205@gmail.com> <437F073D.4070906@superbug.co.uk>
	 <437FF88A.5070502@gmail.com> <43805484.70902@superbug.co.uk>
	 <9cf823c60511212148o2fa440b7vb3b151c97b1a78db@mail.gmail.com>
	 <9cf823c60511251409u49de1bd2u5621e54cedbe72f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <9cf823c60511251409u49de1bd2u5621e54cedbe72f4@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jon Grosshart <jgrosshart@gmail.com>
Cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-11-25 at 17:09 -0500, Jon Grosshart wrote:

Try this patch:

--- /home/rlrevell/cvs/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c~     2005-11-05 16:25:13.000000000 -0500
+++ /home/rlrevell/cvs/alsa/alsa-kernel/pci/emu10k1/emu10k1_main.c      2005-11-25 15:28:47.000000000 -0500
@@ -752,9 +752,16 @@
         .emu10k1_chip = 1,
         .ac97_chip = 1,
         .sblive51 = 1} ,
+       /* Tested by Alexandr 25th Nov 2005 */
+       {.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80661102,
+        .driver = "EMU10K1", .name = "SB Live 5.1 [SB0220]", 
+        .id = "Live",
+        .emu10k1_chip = 1,
+        .ac97_chip = 1,
+        .sblive51 = 1} ,
        /* Tested by Thomas Zehetbauer 27th Aug 2005 */
        {.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80651102,
-        .driver = "EMU10K1", .name = "SB Live 5.1 [SB0220]", 
+        .driver = "EMU10K1", .name = "SB Live 5.1 [SB0222]", 
         .id = "Live",
         .emu10k1_chip = 1,
         .ac97_chip = 1,





-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
