From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: rmmod snd-es1968 crashes my laptop...
Date: Sun, 13 Jun 2004 20:23:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406132023.48894.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

...if the us428 is running. 
the us428 (via uhci module) uses exactly the same irq 5 as the snd-es1968 
here.
If the us428 is deactivated, that is there are only snd-es1968 related 
interrupts on irq5, "rmmod snd-es1968" is ok.

This prevents the crash here (2.4.26 kernel, planet CCRMA fc1):
>>>>>>
--- alsa-kernel/pci/es1968.c	3 May 2004 17:34:48 -0000	1.66
+++ alsa-kernel/pci/es1968.c	13 Jun 2004 17:01:32 -0000
@@ -2477,7 +2477,7 @@
 		kfree_nocheck(chip->res_joystick);
 	}
 #endif
-	snd_es1968_set_acpi(chip, ACPI_D3);
+	//snd_es1968_set_acpi(chip, ACPI_D3);
 	chip->master_switch = NULL;
 	chip->master_volume = NULL;
 	if (chip->res_io_port) {
<<<<<<

I don't know, if this is the correct solution.
Let me know, if you need more details or tests.

thanks,
Karsten



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
