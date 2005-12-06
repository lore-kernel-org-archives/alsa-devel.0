From: TAMAS Gergely <dice@mfa.kfki.hu>
Subject: REPOST [dice@mfa.kfki.hu: SB Live 5.1 Digital OEM [SB0220, (c) 2003]]
Date: Tue, 6 Dec 2005 14:39:25 +0100
Message-ID: <20051206133925.GB11208@felix.mfa.kfki.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

----- Forwarded message from TAMAS Gergely <dice@mfa.kfki.hu> -----

Date: Thu, 17 Nov 2005 06:31:14 +0100
From: TAMAS Gergely <dice@mfa.kfki.hu>
To: alsa-devel@lists.sourceforge.net
User-Agent: Mutt/1.5.9i
Subject: [Alsa-devel] SB Live 5.1 Digital OEM [SB0220, (c) 2003]

Hi!

I've got an 'SB Live 5.1 Digital OEM' card, model number 'SB0220',
(c) 2003.

PCM playing and MIDI (i tested only these) works fine, but alsamixer and
/proc/asound/cards shows 'unknown' as card type (on kernel 2.6.14,
included alsa drivers).

If it doesn't do any harm, maybe the following patch could be
included...

Thanks,
Gergely

Signed-off-by: Gergely Tamas <dice@mfa.kfki.hu>

--- emu10k1/emu10k1_main.c~	2005-11-16 22:08:32.218141000 +0100
+++ emu10k1/emu10k1_main.c	2005-11-16 22:20:24.575285000 +0100
@@ -748,6 +748,12 @@
 	 .emu10k1_chip = 1,
 	 .ac97_chip = 1,
 	 .sblive51 = 1} ,
+	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x100a1102,
+	 .driver = "EMU10K1", .name = "SB Live 5.1 [SB0220]", 
+	 .id = "Live",
+	 .emu10k1_chip = 1,
+	 .ac97_chip = 1,
+	 .sblive51 = 1} ,
 	{.vendor = 0x1102, .device = 0x0002, .subsystem = 0x80641102,
 	 .driver = "EMU10K1", .name = "SB Live 5.1", 
 	 .id = "Live",


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

----- End forwarded message -----


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
